# == Schema Information
#
# Table name: m2mhub_trigger_users
#
#  id         :integer          not null, primary key
#  trigger_id :integer
#  user_id    :integer
#

class M2mhub::TriggerUser < M2mhub::Base
  self.table_name = 'm2mhub_trigger_users'
  belongs_to :m2mhub_trigger, :class_name => 'M2mhub::Trigger'
  belongs_to :user
end
