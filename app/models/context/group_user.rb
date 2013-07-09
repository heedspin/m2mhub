# == Schema Information
#
# Table name: context_group_users
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  group_id   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Context::GroupUser < M2mhub::Base
  self.table_name = 'context_group_users'
  belongs_to :user
  belongs_to :group, :class_name => 'Context::Group'
  def self.user(user)
    user = user.id if user.is_a?(User)
    where(:user_id => user)
  end
end
