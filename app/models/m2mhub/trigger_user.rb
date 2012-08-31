# == Schema Information
#
# Table name: m2mhub_trigger_users
#
#  id         :integer(4)      not null, primary key
#  trigger_id :integer(4)
#  user_id    :integer(4)
#

class M2mhub::TriggerUser < M2mhub::Base
  set_table_name 'm2mhub_trigger_users'
  belongs_to :m2mhub_trigger, :class_name => 'M2mhub::Trigger'
  belongs_to :user
end
