class UserActivity < ActiveRecord::Base
  belongs_to :user
  named_scope :year_in, lambda { |year|
    {
      :conditions => [ 'user_activities.created_at > ? and user_activities.created_at < ?', year.start_date, year.start_date.advance(:years => 1) ]
    }
  }
  named_scope :month_in, lambda { |month|
    {
      :conditions => [ 'user_activities.created_at > ? and user_activities.created_at < ?', month, month.advance(:months => 1) ]
    }
  }
  named_scope :for_user, lambda { |user|
    {
      :conditions => { :user_id => user.id }
    }
  }
  named_scope :by_date_desc, :order => 'user_activities.created_at desc'
  
  named_scope :with_name, lambda { |report_name|
    {:conditions => {:report_name => report_name}}
  }
  
  def password_related?
    ['user_sessions / create', 'password_resets / update'].include?(self.report_name)
  end
  
  def params_hash
    ActiveSupport::JSON.decode(read_attribute(:params))
  end
 
end
# == Schema Information
#
# Table name: user_activities
#
#  id           :integer(4)      not null, primary key
#  user_id      :integer(4)
#  remote_ip    :string(255)
#  report_name  :string(255)
#  format       :string(255)
#  params       :text
#  elapsed_time :float
#  created_at   :datetime
#

