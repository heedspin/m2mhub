# == Schema Information
#
# Table name: syaddr
#
#  fllongdist       :boolean          default(FALSE), not null
#  fcaddrkey        :string(4)        default(""), not null
#  fcaddrtype       :string(1)        default(""), not null
#  fcaliaskey       :string(6)        default(""), not null
#  fcalias          :string(10)       default(""), not null
#  fcfname          :string(15)       default(""), not null
#  fclname          :string(20)       default(""), not null
#  fccounty         :string(20)       default(""), not null
#  fccompany        :string(35)       default(""), not null
#  fccity           :string(20)       default(""), not null
#  fccountry        :string(25)       default(""), not null
#  fcfax            :string(20)       default(""), not null
#  fcphone          :string(20)       default(""), not null
#  fcstate          :string(20)       default(""), not null
#  fczip            :string(10)       default(""), not null
#  fcjrdict         :string(10)       default(""), not null
#  fcemail          :string(60)       default(""), not null
#  fcloc            :string(14)       default(""), not null
#  timestamp_column :binary
#  identity_column  :integer          not null, primary key
#  fmnotes          :text             default(""), not null
#  fmstreet         :text             default(""), not null
#  fncrmmod         :integer          default(0), not null
#  fccrmaddrs       :string(12)       default(""), not null
#  fac              :string(20)       default(""), not null
#  PhoneHome        :string(20)       default(""), not null
#  PhoneMoblie      :string(20)       default(""), not null
#  ContactNum       :string(6)        default(""), not null
#  CreatedDate      :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  ModifiedDate     :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#

class M2m::Address < M2m::Base
  self.table_name = 'syaddr'
  
  # Magic number.  But I don't know the logic the M2M uses to choose this.
  scope :sold_to, :conditions => { :fcaddrtype => 'O' }
  scope :ship_to, :conditions => { :fcaddrtype => 'S' }
  def sold_to?
    self.fcaddrtype == 'O'
  end
  def ship_to?
    self.fcaddrtype == 'S'
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
  
  m2m_id_setter :fcaddrkey, 4
  
  before_create :set_fcaddrkey
  def set_fcaddrkey
    unless self.fcaddrkey.present?
      self.fcaddrkey = M2m::Address.where(:fcaliaskey => self.fcaliaskey, :fcalias => self.fcalias, :fcaddrtype => self.fcaddrtype).count + 1
    end
    true
  end
  
  def address_type
    case self.fcaddrtype
    when 'O'
      'Sold To'
    when 'S'
      'Ship To'
    else
      self.fcaddrtype
    end
  end
end
