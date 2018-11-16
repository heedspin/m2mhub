class VendorCache
  def initialize
    @vendors = {}
  end

  def by_vendno(vendno)
    vendno = vendno.strip
    if @vendors.member?(vendno)
      @vendors[vendno]
    else
      @vendors[vendno] = M2m::Vendor.where(fvendno: vendno).first
    end
  end
end