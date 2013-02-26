# == Schema Information
#
# Table name: inquiry
#
#  InquiryNo        :string(6)        default(""), not null
#  StatusCode       :string(10)       default(""), not null
#  CategoryCode     :string(10)       default(""), not null
#  ClassCode        :string(10)       default(""), not null
#  fCustNo          :string(6)        default(""), not null
#  ContactNumber    :string(20)       default(""), not null
#  InqSubject       :text             default(""), not null
#  CreatedDate      :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  ModifiedDate     :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  identity_column  :integer          not null
#  timestamp_column :binary
#  fInqType         :string(1)        default(""), not null
#  fcassignto       :string(3)        default(""), not null
#  fdestdate        :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fcreslvby        :string(3)        default(""), not null
#  fdreslvdat       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fcrevwby         :string(3)        default(""), not null
#  fdrevwdate       :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fcactby          :string(3)        default(""), not null
#  fdactdate        :datetime         default(Mon Jan 01 00:00:00 UTC 1900), not null
#  fmaction         :text             default(""), not null
#  fcsono           :string(6)        default(""), not null
#  fccustpo         :string(20)       default(""), not null
#  fcphone          :string(20)       default(""), not null
#  fcfax            :string(20)       default(""), not null
#  fcemail          :string(60)       default(""), not null
#  fccuststat       :string(1)        default(""), not null
#  fctype           :string(1)        default(""), not null
#  fcwlitem         :string(6)        default(""), not null
#  frelsno          :string(3)        default(""), not null
#  fcother          :string(1)        default(""), not null
#  fcother2         :string(20)       default(""), not null
#  fcnextact        :string(1)        default(""), not null
#

class M2m::Inquiry < M2m::Base
  set_table_name 'inquiry'

  def category
    M2m::CsPopup.cached_lookup('INQUIRY.CategoryCode', self.CategoryCode)
  end
  def category_name
    self.category.try(:text).try(:strip)
  end
  
  alias_attribute :category_code, :CategoryCode
end
