require 'plutolib/active_hash_methods'
class M2m::InvoiceType < ActiveHash::Base
  self.data = [
    {:id => 1,  :key => 'C', :name => 'Credit Memo'},
    {:id => 2,  :key => 'M', :name => 'Miscellaneous Invoice'},
    {:id => 3,  :key => 'N', :name => 'Normal Invoice'},
    {:id => 4,  :key => 'P', :name => 'Pre-Payment Memo'},
    {:id => 5,  :key => 'T', :name => 'Time & Material Billing'},
    {:id => 6,  :key => 'V', :name => 'Vendor Invoice'}
  ]
  include Plutolib::ActiveHashMethods

  def cs_popup
    M2m::CsPopup.for_key('ARMAST.FINVTYPE').with_code(self.key).first
  end
  
end
