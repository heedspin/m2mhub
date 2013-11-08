require 'plutolib/to_xls'

class Sales::RepReport
  include Plutolib::ToXls
  attr_accessor :start_date, :end_date

  def initialize(args)
    args ||= {}
    self.start_date = args[:start_date]
    self.end_date = args[:end_date]
  end

  def start_date=(val)
    @start_date = val.is_a?(String) ? Date.parse(val) : val
  end

  def end_date=(val)
    @end_date = val.is_a?(String) ? Date.parse(val) : val
  end

  def xls_sheet_name
    'Rep Report'
  end

  def xls_initialize
  end

  def xls_data
    raise ':start_date required' unless self.start_date
    raise ':end_date required' unless self.end_date

    M2m::VendorInvoice.invoice_dates('2013-01-01', '2014-01-01').invoice_number_like('COMMISSIONS').vendor_number(387).by_date_desc.last
    accrued_commissions = M2m::GlTransaction.where(:fcacctnum => '2102212').post_dates('2013-01-01', '2014-01-01')

  end
end
