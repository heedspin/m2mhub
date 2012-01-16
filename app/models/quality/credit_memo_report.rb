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

    results = M2m::CustomerServiceLog.find_by_sql <<-SQL
    select sycslm.*,
      armast.fcinvoice as invoice_number, armast.finvdate as invoice_date, armast.fnamount as invoice_amount,
      invend.fvendno as vendor_number
    from armast
    left join aritem on armast.fcinvoice = aritem.fcinvoice
    left join sycslm on sycslm.fcpartno = aritem.fpartno
                    and sycslm.fcpartrev = aritem.frev
                    and sycslm.fdinqdate <= armast.finvdate
    left join invend on invend.fpartno = sycslm.fcpartno 
                    and invend.fpartrev = sycslm.fcpartrev    
    where armast.finvtype = 'C'
      and (sycslm.fccategory = 'Q' or sycslm.fccategory = '')
      and sycslm.fdinqdate >= '#{@start_date.to_s(:db)}'
      and sycslm.fdinqdate < '#{@end_date.to_s(:db)}'
    order by sycslm.fdinqdate desc, sycslm.fcinqno, armast.finvdate
    SQL
    rmas = {}
    results.each do |rma|
      rma.invoice_number = 'CM-' + rma.invoice_number[/\d+/].to_i.to_s
      (rmas[rma.inquiry_number] ||= []).push(rma)
    end
    rmas.each do |inquiry_number, candidates|
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
  
  def find_credit_memo_reference_match(candidates)
    candidates.each do |rma|
      if rma.credit_memo_reference.present? and (rma.credit_memo_reference[/\d+/].to_i == rma.invoice_number[/\d+/].to_i)
        return rma
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
