require 'useragent' 
class Context::ContextsController < M2mhubController
  filter_access_to_defaults

  def index
    respond_to do |format|
      format.html {
        @user_agent = UserAgent.parse(request.env['HTTP_USER_AGENT'])
      }
      format.json {
        @context = Context::Context.subject(params[:subject]).accessible_to(current_user).order(:created_at).last
        # Create a temporary context to look for opportunities.
        @context ||= Context::Context.new(:subject => params[:subject])
        render :json => @context.to_context 
      }
    end
  end
  
  protected

    def model_name
      :context
    end

    def model_class
      Context::Context
    end
end
