class UserActivity < ActiveRecord::Base
  belongs_to :user
  named_scope :recent, :order => 'id desc', :limit => 40
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
  named_scope :for_agency, lambda { |thing|
    agency_id = thing.is_a?(Agency) ? thing.id : thing.to_i
    if agency_id > 0
      {
        :joins => :user,
        :conditions => { :user => { :agency_id => agency_id } }
      }
    else
      {
        :joins => :user,
        :conditions => 'users.agency_id is null'
      }
    end
  }
  named_scope :with_name, lambda { |report_name|
    {:conditions => {:report_name => report_name}}
  }
  
  def password_related?
    ['user_sessions / create', 'password_resets / update'].include?(self.report_name)
  end
  
  def params_hash
    JSON.parse(read_attribute(:params))
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

