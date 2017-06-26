# == Schema Information
#
# Table name: user_activities
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  remote_ip    :string(255)
#  report_name  :string(255)
#  format       :string(255)
#  params       :text
#  elapsed_time :float
#  created_at   :datetime
#

class M2mhub::UserActivity < ActiveRecord::Base
  belongs_to :user
  scope :year_in, -> (year) {
    where [ 'user_activities.created_at > ? and user_activities.created_at < ?', year.start_date, year.start_date.advance(:years => 1) ]
  }
  scope :month_in, -> (month) {
    where [ 'user_activities.created_at > ? and user_activities.created_at < ?', month, month.advance(:months => 1) ]
  }
  scope :for_user, -> (user) {
    where :user_id => user.id
  }
  scope :by_date_desc, -> { order('user_activities.created_at desc') }

  scope :with_name, -> (report_name) {
    where :report_name => report_name
  }

  def password_related?
    ['user_sessions / create', 'password_resets / update'].include?(self.report_name)
  end

  def params_to_url_hash
    hash = ActiveSupport::JSON.decode(read_attribute(:params))
    if hash.is_a?(Hash)
      hash.keys.each { |string_key| hash[string_key.to_sym] = hash.delete(string_key) }
    end
    result = { :controller => hash.delete(:controller), :action => hash.delete(:action), :params =>hash }
    if id = hash.delete(:id)
      result[:id] = id
    end
    result
  end

end
