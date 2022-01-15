module M2mhub::UserActivityLogger
  # Log all requests unless one has been explicity logged.
  def log_user_activity
    @log_user_activity_start_time = Time.now.to_f
    yield
    if @last_user_activity.nil? and (not request.xhr?)
      user_activity do
        { :elapsed_time => Time.current.to_f - @log_user_activity_start_time }
      end
    end
  end

  def user_activity
    begin
      options = yield
      options[:user_id] ||= current_user.try(:id)
      options[:remote_ip] ||= request.try(:remote_ip)
      options[:params] ||= params.try(:to_json)
      options[:report_name] ||= (controller_name || 'no controller') + ' / ' + (action_name || 'no action')
      options[:format] ||= params[:format]# || 'html'
      @last_user_activity = M2mhub::UserActivity.create(options)
    rescue
      logger.error "Ignoring UserActivity exception: #{$!}"
    end
  end
  
  def self.included(base)
    base.class_eval <<-RUBY
    around_action :log_user_activity, :except => :options
    RUBY
  end
end