# == Schema Information
#
# Table name: syaddr
#
#  fllongdist       :boolean          default(FALSE), not null
#  fcaddrkey        :varchar(6)       default(""), not null
#  fcaddrtype       :char(1)          default(" "), not null
#  fcaliaskey       :char(6)          default("      "), not null
#  fcalias          :char(10)         default("          "), not null
#  fcfname          :char(15)         default("               "), not null
#  fclname          :char(20)         default("                    "), not null
#  fccounty         :char(20)         default("                    "), not null
#  fccompany        :varchar(35)      default(""), not null
#  fccity           :char(20)         default("                    "), not null
#  fccountry        :char(25)         default("                         "), not null
#  fcfax            :char(20)         default("                    "), not null
#  fcphone          :char(20)         default("                    "), not null
#  fcstate          :char(20)         default("                    "), not null
#  fczip            :char(10)         default("          "), not null
#  fcjrdict         :char(10)         default("          "), not null
#  fcemail          :varchar(100)     default(""), not null
#  timestamp_column :ss_timestamp
#  identity_column  :integer          not null, primary key
#  fmnotes          :varchar_max(2147 default(""), not null
#  fmstreet         :varchar_max(2147 default(""), not null
#  fac              :char(20)         default("                    "), not null
#  fncrmmod         :integer          default(0), not null
#  fccrmaddrs       :varchar(12)      default(""), not null
#  fcloc            :char(14)         default("              "), not null
#  PhoneHome        :varchar(20)      default(""), not null
#  PhoneMoblie      :varchar(20)      default(""), not null
#  ContactNum       :char(6)          default("      "), not null
#  CreatedDate      :datetime         default(1900-01-01 00:00:00 UTC), not null
#  ModifiedDate     :datetime         default(1900-01-01 00:00:00 UTC), not null
#

class M2m::Address < M2m::Base
  self.table_name = 'syaddr'
  
  # Magic number.  But I don't know the logic the M2M uses to choose this.
  scope :sold_to, -> { where(fcaddrtype: 'O') }
  scope :ship_to, -> { where(fcaddrtype: 'S') }
  def sold_to?
    self.fcaddrtype == 'O'
  end
  def ship_to?
    self.fcaddrtype == 'S'
  end
  def bill_to?
    self.fcaddrtype == 'B'
  end

  def self.key(key)
    where [ 'syaddr.fcaddrkey = ?', key ]
  end
  
  alias_attribute :first_name, :fcfname
  alias_attribute :last_name, :fclname
  alias_attribute :work_email, :fcemail
  alias_attribute :work_phone, :fcphone
  alias_attribute :notes, :fmnotes
  alias_attribute :work_fax, :fcfax
  alias_attribute :work_address, :fmstreet
  alias_attribute :work_city, :fccity
  alias_attribute :work_state, :fcstate
  alias_attribute :work_postal_code, :fczip
  alias_attribute :work_country_name, :fccountry
  alias_attribute :company_name, :fccompany
  
  def address_type
    M2m::CsPopup.cached_lookup('SYADDR.FCADDRTYPE', self.fcaddrtype).try(:text)
  end
  def vendor_address_type
    M2m::CsPopup.cached_lookup('SYADDR.FCADDR1', self.fcaddrtype).try(:text)
  end
  
  m2m_id_setter :fcaddrkey, 4
  
  before_create :set_fcaddrkey
  def set_fcaddrkey
    unless self.fcaddrkey.present?
      self.fcaddrkey = M2m::Address.where(:fcaliaskey => self.fcaliaskey, :fcalias => self.fcalias, :fcaddrtype => self.fcaddrtype).count + 1
    end
    true
  end
  
  # def address_type
  #   case self.fcaddrtype
  #   when 'O'
  #     'Sold To'
  #   when 'S'
  #     'Ship To'
  #   else
  #     self.fcaddrtype
  #   end
  # end
  include M2m::ParsedWorkAddress
end
