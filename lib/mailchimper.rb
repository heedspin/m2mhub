require 'with_retries'

class Mailchimper
  include WithRetries
  include LoggerUtils

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
          h = Hominid::API.new(CompanyConfig.mailchimp_api_key)
          h.listBatchSubscribe(CompanyConfig.mailchimp_list_id, batch, false, false, true)
        end
      rescue => exc
        log_error "Unexpected mailchimp exception: #{exc.class.name} #{exc.message}:\n" + exc.backtrace.join("\n")
        return false
      end
      true
    end
  end
  
end