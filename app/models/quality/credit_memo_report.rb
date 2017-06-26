class Quality::CreditMemoReport
  class Month
    attr_accessor :date, :invoice_total, :rma_items
    def initialize(date)
      @date = date
      @invoice_total = 0
      @rma_items = []
    end
    def add_rma_item(rma_item)
      @rma_items.push rma_item
    end
    def quality_credit_memo_total
      @quality_credit_memo_total ||= @rma_items.sum { |rma_item| rma_item.invoice_amount.abs }
    end
    def percent_quality_credit_memos
      if self.quality_credit_memo_total == 0
        0
      else
        (self.quality_credit_memo_total.to_f / self.invoice_total) * 100
      end
    end
  end

  class VendorReport
    attr_accessor :vendor, :invoice_total, :rma_items
    def initialize(vendor)
      @vendor = vendor
      @invoice_total = 0
      @rma_items = []
    end
    def add_rma_item(rma_item)
      @rma_items.push rma_item
    end
    def name
      self.vendor.name
    end
    def quality_credit_memo_total
      @quality_credit_memo_total ||= @rma_items.sum { |rma_item| rma_item.invoice_amount.abs }
    end
    def percent_quality_credit_memos
      if (self.quality_credit_memo_total == 0) or (self.invoice_total == 0)
        0
      else
        (self.quality_credit_memo_total.to_f / self.invoice_total) * 100
      end
    end
  end

  attr_accessor :vendor_reports

  def initialize(args=nil)
    args ||= {}
    @start_date = args[:start_date] || Date.current.beginning_of_year
    @end_date = args[:end_date] || @start_date.advance(:years => 1)
    @months = {}
    @vendor_reports = {}
  end

  def run
    results = M2m::Invoice.connection.select_rows <<-SQL
    select year(finvdate) as invoice_year, month(finvdate) as invoice_month,
      sum(fnamount) as month_invoice_totals
    from armast
    where finvdate >= '#{@start_date.to_s(:db)}'
    and finvdate < '#{@end_date.to_s(:db)}'
    and (finvtype != 'C' and fcsource != 'P')
    group by year(finvdate), month(finvdate)
    order by invoice_year, invoice_month
    SQL
    results.each do |result_row|
      invoice_year, invoice_month, month_invoice_totals = result_row
      month_for(Date.new(invoice_year, invoice_month, 1)).invoice_total += month_invoice_totals
    end

    results = M2m::Invoice.connection.select_rows <<-SQL
    select invend.fvendno as vendor_number,
      sum(aritem.ftotprice) as vendor_invoice_total
    from aritem
    left join armast on armast.fcinvoice = aritem.fcinvoice
    left join invend on invend.fpartno = aritem.fpartno and invend.fpartrev = aritem.frev
    where armast.finvdate >= '#{@start_date.to_s(:db)}'
    and armast.finvdate < '#{@end_date.to_s(:db)}'
    and (armast.finvtype != 'C' and armast.fcsource != 'P')
    group by invend.fvendno
    SQL
    vendor_numbers = results.map(&:first)
    M2m::Vendor.with_vendor_numbers(vendor_numbers).each do |vendor|
      @vendor_reports[vendor.vendor_number] ||= VendorReport.new(vendor)
    end
    results.each do |result_row|
      vendor_number, vendor_invoice_total = result_row
      if vendor_report = @vendor_reports[vendor_number]
        vendor_report.invoice_total += vendor_invoice_total
      end
    end

    rmas = M2m::Rma.between(@start_date, @end_date).includes(:items).to_a
    customers = M2m::Customer.with_customer_numbers(rmas.map(&:customer_number)).to_a
    rma_items = rmas.map(&:items).flatten
    M2m::Item.attach_items(rma_items)
    invoice_items = M2m::InvoiceItem.for_rma_items(rma_items).includes(:invoice).to_a
    @vendor_for_item = {}
    if rma_items.size > 0
      results = M2m::InventoryVendor.connection.select_rows <<-SQL
      select syrmaitm.identity_column, invend.fvendno as vendor_number
      from syrmaitm
      left join invend on invend.fpartno = syrmaitm.fcpartno and invend.fpartrev = syrmaitm.fcpartrev
      where syrmaitm.identity_column in (#{rma_items.map(&:identity_column).join(',')})    
      SQL
      results.each do |rma_item_identity_column, vendor_number|
        @vendor_for_item[rma_item_identity_column] = vendor_number
      end
    end
    rmas.each do |rma|
      next unless rma.severity.nil? || AppConfig.credit_memo_report_severity_names.include?(rma.severity_name)
      rma.items.each do |rma_item|
        rma_item.rma = rma
        # Rails.logger.debug "Looking for #{M2m::InvoiceItem.rma_key(rma_item)} in " + invoice_items.map(&:rma_key).sort.join(', ')
        for_rma_item, remaining = invoice_items.partition { |ii| ii.for_rma_item?(rma_item) }
        rma_item.invoice_items = for_rma_item
        # Rails.logger.debug "rma item #{rma_item.rma_number} got invoice_items: #{for_rma_item.map(&:identity_column)} out of #{invoice_items.size}"
        invoice_items = remaining
        month_for(rma.date).add_rma_item(rma_item)
        if vendor_number = @vendor_for_item[rma_item.identity_column]
          @vendor_reports[vendor_number].try(:add_rma_item, rma_item)
        end
      end
      rma.customer = customers.detect { |c| c.customer_number == rma.customer_number }
    end 
    true
  end

  def ordered_months
    @months.values.sort_by(&:date)
  end

  def month_for(date)
    month_date = Date.new(date.year, date.month, 1)
    @months[month_date] ||= Month.new(month_date)
  end

  def ordered_vendor_reports
    @vendor_reports.values.select { |vr| vr.quality_credit_memo_total > 0 }.sort_by(&:percent_quality_credit_memos).reverse
  end

  def invoice_total
    @invoice_total ||= @months.values.sum(&:invoice_total)
  end

  def quality_credit_memo_total
    @quality_credit_memo_total ||= @months.values.sum(&:quality_credit_memo_total)
  end

  def percent_quality_credit_memos
    if self.quality_credit_memo_total == 0
      0
    else
      (self.quality_credit_memo_total.to_f / self.invoice_total) * 100
    end
  end

  def all_credit_memos
    @months.values.map(&:credit_memos).flatten
  end

end
