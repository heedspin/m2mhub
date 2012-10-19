class M2mhub::NewCustomerLink
  include ActionView::Helpers::UrlHelper
  def initialize(args)
    @args = args
  end
  
  def to_url
    begin
      "http://#{AppConfig.production_hostname}/customers/new?d=" + CGI.escape(ActiveSupport::Base64.encode64(@args.to_json))
    rescue
      Rails.logger.error "Failed to create hub link: #{$!.class.name} #{$!.message}\n" + $!.backtrace.join("\n")
      if Rails.env.production?
        return 'error'
      else
        raise $! 
      end
    end
  end

end
