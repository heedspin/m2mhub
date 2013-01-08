module UserActivitiesHelper
  def url_for_user_activity(user_activity)
    begin
      phash = user_activity.params_to_url_hash
      cs = phash[:controller]
      if [:customer_otd_reports, :rma_reports, :credit_memo_reports].include?(cs)
        phash[:controller] = 'quality/' + cs.to_s
      end
      begin
        url_for phash
      rescue
        '/'
      end
    rescue
      user_activity.report_name
    end
  end
end