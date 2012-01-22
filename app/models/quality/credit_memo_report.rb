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

    rma_items = M2m::RmaItem.find_by_sql <<-SQL
    select syrmaitm.*,
      armast.fcinvoice as invoice_number, armast.finvdate as invoice_date, armast.fnamount as invoice_amount,
      invend.fvendno as vendor_number
    from armast
    left join aritem on armast.fcinvoice = aritem.fcinvoice
    left join syrmaitm on syrmaitm.fcpartno = aritem.fpartno
    and syrmaitm.fcpartrev = aritem.frev
    and syrmaitm.fcrmano = SUBSTRING(aritem.fcrmakey, 1, 15)
    and syrmaitm.finumber = SUBSTRING(aritem.fcrmakey, 16, 13)
    left join syrmama on syrmama.fcrmano = syrmaitm.fcrmano
    left join invend on invend.fpartno = syrmaitm.fcpartno
    and invend.fpartrev = syrmaitm.fcpartrev
    where armast.finvtype = 'C'
    and syrmama.fdenterdate >= '#{@start_date.to_s(:db)}'
    and syrmama.fdenterdate < '#{@end_date.to_s(:db)}'
    and aritem.fcrmakey != '' and aritem.fcrmakey is not NULL
    SQL
    rmas = M2m::Rma.with_rma_numbers(rma_items.map(&:rma_number))
    rma_items.each do |rma_item|
      rma_item.rma = rmas.detect { |r| r.rma_number == rma_item.rma_number }
      rma_item.invoice_number = rma_item.invoice_number[/\d+/].to_i.to_s
      rma_item.invoice_date = rma_item.invoice_date
    end
    customers = M2m::Customer.with_customer_numbers(rma_items.map(&:rma).map(&:customer_number)).all
    rma_items.each do |rma_item|
      rma = rma_item.rma
      next unless rma.severity.nil? || CompanyConfig.credit_memo_report_severity_names.include?(rma.severity_name)
      rma.customer = customers.detect { |c| c.customer_number == rma.customer_number }
      month_for(rma.date).add_rma_item(rma_item)
      @vendor_reports[rma_item.vendor_number].try(:add_rma_item, rma_item)
    end
    true
  end

  def find_credit_memo_reference_match(candidates)
    candidates.each do |rma|
      # First check for a CM-XYZ in the user defined fields.
      if rma.credit_memo_reference.present?
        if rma.credit_memo_reference.no_credit_memo?
          return nil
        elsif rma.credit_memo_reference.invoice_number.to_s == rma.invoice_number.to_s
          return rma
        end
      end
      # Second check if there's an RMA Number in the invoice item.
      if rma.invoice_item_rma_key.present?
        invoice_rma_number = M2m::InvoiceItem.rma_number(rma.invoice_item_rma_key)
        # rma_item_no = M2m::InvoiceItem.rma_item_number(rma.invoice_item_rma_key)
        if rma.rma_number == invoice_rma_number
          return rma
        end
      end
    end
    nil
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
