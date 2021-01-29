# == Schema Information
#
# Table name: context_groups
#
#  id            :integer          not null, primary key
#  group_type_id :integer
#  name          :string(255)
#  domain        :string(255)
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#

class Context::Group < M2mhub::Base
  self.table_name = 'context_groups'  
  has_many :group_users, :class_name => 'Context::GroupUser'
  has_many :users, :class_name => 'User', :through => :group_users
  has_many :group_contexts, :class_name => 'Context::GroupContext'
  has_many :contexts, :class_name => 'Context::Context', :through => :group_contexts
end
