class M2mhub::ContextAssistantChromeExtensionsController < M2mhubController
  skip_before_filter :require_login

  def index
  end
  
  def show
    headers['Content-type'] = 'application/x-chrome-extension'
    send_file File.join(Rails.root, 'tmp/context_assistant.crx')
  end
  
  protected

    def model_class
      M2mhub::ContextAssistant
    end
    
    def current_object
      ''
    end
end
