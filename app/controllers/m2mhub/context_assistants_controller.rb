class M2mhub::ContextAssistantsController < M2mhubController
  filter_access_to_defaults

  def index
    subject = params[:subject]
    @opportunities = Sales::Opportunity.with_parsed_xnumber(subject).limit(10)
    result = @opportunities.map do |o|
      {
        :title => o.title_or_number,
        :customer => o.customer_name,
        :customer_url => o.sales_customer_id.present? && Rails.application.routes.url_helpers.sales_customer_url(o.sales_customer_id, :host => AppConfig.hostname),
        :part_numbers => o.part_numbers.map { |pn| { :part_number => pn, :url => Rails.application.routes.url_helpers.doogle_display_url(pn, :host => AppConfig.hostname) } },
        :url => url = Rails.application.routes.url_helpers.opportunity_url(o.xnumber, :host => AppConfig.hostname)
      }
    end
    respond_to do |format|
      format.html {
        render :text => result.inspect
      }
      format.json {
        render :json => result
      }
    end
  end

  protected

    def model_name
      :m2mhub_context_assistant
    end

    def model_class
      M2mhub::ContextAssistant
    end
end
