# == Schema Information
#
# Table name: parent_companies
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Sales::ParentCompany < M2mhub::Base
  has_many :customers, :class_name => 'Sales::Customer'
end
