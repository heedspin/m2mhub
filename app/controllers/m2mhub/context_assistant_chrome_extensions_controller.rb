class M2mhub::ContextAssistantChromeExtensionsController < M2mhubController
  filter_access_to_defaults :context => :m2mhub_context_assistant_chrome_extensions

  def index
  end
  
  def show
    headers['Content-type'] = 'application/x-chrome-extension'
    send_file File.join(M2mhub::Engine.root, 'extensions/chrome/context_assistant/package/context_assistant.crx')
  end
  
  protected

    def model_class
      M2mhub::ContextAssistant
    end
    
    def current_object
      ''
    end
end
