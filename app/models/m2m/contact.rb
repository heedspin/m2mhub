# == Schema Information
#
# Table name: syphon
#
#  fllongdist       :boolean          default(FALSE), not null
#  fcfax            :string(25)       default(""), not null
#  fcclass          :string(3)        default(""), not null
#  fcemail          :string(60)       default(""), not null
#  fcextensio       :string(6)        default(""), not null
#  fcnumber         :string(25)       default(""), not null
#  fcsourceid       :string(6)        default(""), not null
#  fcs_alias        :string(10)       default(""), not null
#  fcbesttime       :string(10)       default(""), not null
#  fccurid          :string(3)        default(""), not null
#  fcfname          :string(15)       default(""), not null
#  fcontact         :string(20)       default(""), not null
#  fcrange          :string(10)       default(""), not null
#  fsalute          :string(5)        default(""), not null
#  fctitle          :string(25)       default(""), not null
#  fccountry        :string(25)       default(""), not null
#  timestamp_column :binary
#  identity_column  :integer          not null, primary key
#  fmnotes          :text             default(""), not null
#  fncrmmod         :integer          default(0), not null
#  fccrmcntct       :string(12)       default(""), not null
#  Number           :string(6)        default("0"), not null
#  PhoneWork        :string(20)       default(""), not null
#  PhoneHome        :string(20)       default(""), not null
#  PhoneMobile      :string(20)       default(""), not null
#  Address          :text             default(""), not null
#  City             :string(20)       default(""), not null
#  State            :string(20)       default(""), not null
#  PostalCode       :string(10)       default(""), not null
#  URL              :string(100)      default(""), not null
#  IsPrimary        :boolean          default(FALSE), not null
#  CreatedDate      :datetime         default(1900-01-01 00:00:00 UTC), not null
#  ModifiedDate     :datetime         default(1900-01-01 00:00:00 UTC), not null
#  flEdited         :boolean          default(FALSE), not null
#

class M2m::Contact < M2m::Base
  self.table_name = 'syphon'
  include ActionView::Helpers::NumberHelper
  
  alias_attribute :primary, :IsPrimary
  alias_attribute :work_phone, :PhoneWork
  alias_attribute :work_fax, :fcfax
  alias_attribute :mobile_phone, :PhoneMobile
  alias_attribute :work_country_name, :fccountry
  alias_attribute :contact_number, :Number
  alias_attribute :work_email, :fcemail
  alias_attribute :first_name, :fcfname
  alias_attribute :last_name, :fcontact
  alias_attribute :notes, :fmnotes
  alias_attribute :work_address, :Address
  alias_attribute :work_city, :City
  alias_attribute :work_state, :State
  alias_attribute :work_postal_code, :PostalCode
  
  def first_name
    self.fcfname.titleize.strip
  end
  def last_name
    self.fcontact.titleize.strip
  end
  def name
    [self.first_name, self.last_name].join(' ').strip
  end
  def email
    self.fcemail.strip.downcase
  end
  def fax
    self.fcfax.strip
  end

  m2m_id_setter :Number, 6, :contact_number
  
  after_create :set_contact_number
  def set_contact_number
    self.contact_number = self.id
    self.save
  end
  
  scope :primary, :conditions => { :IsPrimary => true }

  def phone_number_array
    result = []
    if self.PhoneWork.present?
      result.push "Office: #{number_to_phone(self.PhoneWork.strip)}" + (self.extension.present? ? " x#{self.extension}" : '')
    end
    if self.PhoneMobile.present?
      result.push "Mobile: #{number_to_phone(self.PhoneMobile.strip)}"
    end
    if self.PhoneHome.present?
      result.push "Home: #{number_to_phone(self.PhoneHome.strip)}"
    end
    result
  end

  def extension
    self.fcextensio.strip
  end
  
  m2m_id_setter :fcsourceid, 6  
  validates_presence_of :first_name, :last_name
  
end
