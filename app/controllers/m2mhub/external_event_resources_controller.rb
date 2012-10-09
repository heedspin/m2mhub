class M2mhub::ExternalEventResourcesController < M2mhubController
  respond_to :json
  skip_before_filter :require_login
  skip_before_filter :verify_authenticity_token

  def create
    @external_event = build_object
    @external_event.request_header = { :host => request.host, :format => request.format, :method => request.method, :headers => request.env.select {|k,v| k.match("^HTTP.*")}, :port => request.port, :protocol => request.protocol, :remote_ip => request.remote_ip, :url => request.url }.to_json
    if @external_event.save
      @external_event.queue_to_run!
      render :json => @external_event.to_json(:only => [:id, :created_at])
    else
      render :json => {:errors => @external_event.errors.full_messages}, :status => :unprocessable_entity
    end
  end

  protected

    def model_class
      M2mhub::ExternalEvent
    end
    def model_name
      'external_event_resource'
    end

    before_filter :require_api_key
    def require_api_key
      unless (params[:api_key] == AppConfig.external_event_api_key)
        not_authorized
      end
      true
    end

    def build_object
      @current_object ||= model_class.new(params[model_name])
    end
end
