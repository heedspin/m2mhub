class Quality::CreditMemoReport
  class Month
    attr_accessor :date, :invoice_total, :credit_memos
    def initialize(date)
      @date = date
      @invoice_total = 0
      @credit_memos = []
    end
    def add_credit_memo(cm)
      @credit_memos.push cm
    end
    def quality_credit_memo_total
      @quality_credit_memo_total ||= @credit_memos.sum { |cm| cm.invoice_amount.abs }
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
    attr_accessor :vendor, :invoice_total, :credit_memos
    def initialize(vendor)
      @vendor = vendor
      @invoice_total = 0
      @credit_memos = []
    end
    def name
      self.vendor.name
    end
    def add_credit_memo(cm)
      @credit_memos.push cm
    end
    def quality_credit_memo_total
      @quality_credit_memo_total ||= @credit_memos.sum { |cm| cm.invoice_amount.abs }
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
    results.each do |result_row|
      vendor_number, vendor_invoice_total = result_row
      if vendor = vendor_for(vendor_number)
        vendor.invoice_total += vendor_invoice_total
      end
    end

    results = M2m::Rma.find_by_sql <<-SQL
    select syrmama.*,
          armast.fcinvoice as invoice_number, armast.finvdate as invoice_date, armast.fnamount as invoice_amount,
          aritem.fcrmakey as invoice_item_rma_key,
          invend.fvendno as vendor_number,
          syrmaitm.fcpartno as part_number, syrmaitm.fcpartrev as revision, syrmaitm.fnqty as quantity
    from armast
    left join aritem on armast.fcinvoice = aritem.fcinvoice
    left join syrmaitm on syrmaitm.fcpartno = aritem.fpartno
                      and syrmaitm.fcpartrev = aritem.frev
    left join syrmama on syrmama.fcrmano = syrmaitm.fcrmano
                     and syrmama.fdenterdate <= armast.finvdate
    left join invend on invend.fpartno = syrmaitm.fcpartno 
                    and invend.fpartrev = syrmaitm.fcpartrev    
    where armast.finvtype = 'C'
      and syrmama.fdenterdate >= '#{@start_date.to_s(:db)}'
      and syrmama.fdenterdate < '#{@end_date.to_s(:db)}'
    order by syrmama.fdenterdate desc, syrmama.fcrmano, armast.finvdate
    SQL
    rmas = {}
    results.each do |rma|
      rma.invoice_number = rma.invoice_number[/\d+/].to_i.to_s
      rma.part_number = rma.part_number.strip
      rma.revision = rma.revision.strip
      rma.invoice_date = rma.invoice_date
      (rmas[rma.rma_number] ||= []).push(rma)
    end
    rmas.each do |rma_number, candidates|
      next unless quality_related_rma?(candidates)
      winner = find_credit_memo_reference_match(candidates)
      if winner.nil?
        winner = candidates.first
        if winner.open? or winner.credit_memo_reference.present?
          # leave blank
          winner.invoice_number = winner.invoice_date = nil
          winner.invoice_amount = 0
        end
      end
      month_for(winner.date).add_credit_memo(winner)
      vendor_for(winner.vendor_number).try(:add_credit_memo, winner)
    end
    true
  end
  
  def quality_related_rma?(candidates)
    rma = candidates.first
    rma.severity.nil? || CompanyConfig.credit_memo_report_severity_names.include?(rma.severity_name)
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
  
  def vendor_for(vendor_number)
    return nil unless vendor_number.present?
    @vendor_reports[vendor_number] ||= VendorReport.new(M2m::Vendor.find(vendor_number))
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
