module NavigationSystem

  def self.included(base)
    base.class_eval <<-EOS
    helper_method :controller_active?
    helper_method :controller_selected
    EOS
  end
  
  SELECTED_CSS_CLASS='current'
  
  def controller_active?(controller)
    self.controller_name == controller.to_s
  end
  
  def controller_selected(controller)
    controller_active?(controller) ? SELECTED_CSS_CLASS : ''
  end
  
end
