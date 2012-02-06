module NavigationSystem

  def self.included(base)
    base.class_eval <<-EOS
    helper_method :menu_selected
    EOS
  end
  
  SELECTED_CSS_CLASS='current'
  
  def menu_selected(args={})
    result = if path_regex = args[:path]
      path_regex.match(request.path).present?
    elsif path_starts_with = args[:path_starts_with]
      request.path.starts_with?(path_starts_with)
    else
      parent_key = args[:parent]
      controller_names = args[:controllers] || args[:controller] || self.controller_name
      controller_names = if controller_names.is_a?(Enumerable)
        controller_names.map(&:to_s)
      else
        [ controller_names.to_s ]
      end
      action = (args[:action] || self.action_name).to_s
      (parent_key.nil? || params[parent_key.to_s.singularize + '_id'].present?) && (controller_names.include?(self.controller_name)) && (action == self.action_name)  
    end
    result ? SELECTED_CSS_CLASS : ''
  end
  
end
