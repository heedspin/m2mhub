# == Schema Information
#
# Table name: m2mhub_triggers
#
#  id                    :integer          not null, primary key
#  trigger_type_id       :integer
#  trigger_state_id      :integer
#  part_number           :string(255)
#  notification_type_id  :integer
#  target_user_id        :integer
#  lighthouse_project_id :string(255)
#  title                 :string(255)
#  instructions          :text
#  created_at            :datetime
#  updated_at            :datetime
#

class M2mhub::Trigger < M2mhub::Base
  self.table_name = 'm2mhub_triggers'
  belongs_to_active_hash :trigger_state, :class_name => 'M2mhub::TriggerState'
  belongs_to_active_hash :trigger_type, :class_name => 'M2mhub::TriggerType'
  belongs_to_active_hash :notification_type, :class_name => 'M2mhub::NotificationType'
  belongs_to :target_user, :class_name => 'User', :foreign_key => :target_user_id
  has_many :events, :class_name => 'M2mhub::Event', :foreign_key => 'trigger_id'
  has_many :trigger_users, :class_name => 'M2mhub::TriggerUser'
  has_many :users, :through => :trigger_users
  belongs_to_lighthouse_project
  
  scope :enabled, :conditions => { :trigger_state_id => M2mhub::TriggerState.enabled.id }
  scope :not_deleted, :conditions => [ 'm2mhub_triggers.trigger_state_id != ?', M2mhub::TriggerState.deleted.id ]
  scope :by_part_number, :order => [:part_number, :created_at]
  
  def destroy
    self.trigger_state = M2mhub::TriggerState.deleted
    self.save
  end
  
  def trigger_description
    "#{self.trigger_type.name.pluralize} for #{self.part_number}"
  end
  
  def run
    self.trigger_type.runner_class.new(self).run
  end  
end
