require 'with_retries'

class Mailchimper
  include WithRetries
  include LoggerUtils
  
  def initialize(args={})
    @mailchimp_list_id = (args[:list_id] || CompanyConfig.mailchimp_list_id)
  end

  def subscribe(args)
    args ||= {}
    name = args[:name] || ''
    first_name, last_name = name.split(' ', 2)
    last_name ||= ''
    email = args[:email]
    if email.blank? or !Rails.env.production? or !CompanyConfig.mailchimp_api_key.present?
      false
    else
      begin
        with_retries do
          batch = [ { :EMAIL => email, :EMAIL_TYPE => 'html', :FNAME => first_name, :LNAME => last_name } ]
          # listBatchSubscribe(string apikey, string id, array batch, boolean double_optin, boolean update_existing, boolean replace_interests)
          self.mailchimp.listBatchSubscribe(@mailchimp_list_id, batch, false, false, true)
        end
      rescue => exc
        log_error "Unexpected mailchimp exception: #{exc.class.name} #{exc.message}:\n" + exc.backtrace.join("\n")
        return false
      end
      true
    end
  end
  
  def mailchimp
    @mailchimp ||= Hominid::API.new(CompanyConfig.mailchimp_api_key)
  end
  
  def status_for(email)
    with_retries do
      result = self.mailchimp.listMemberInfo(@mailchimp_list_id, [email])
      raise "Mailchimp failed" unless result
      status = if result['errors'] == 1
        :never_subscribed
      elsif result['data'].first['status'] == 'subscribed'
        :subscribed
      else
        :unsubscribed
      end
      return status
    end
    nil
  end
  
end