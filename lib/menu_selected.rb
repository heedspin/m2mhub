module MenuSelected
  def self.included(base)
    base.class_eval <<-EOS
    helper_method :menu_selected
    EOS
  end

  SELECTED_CSS_CLASS='current'

  def menu_config(menu_key)
    all_configs = AppConfig.menu_selected || {}
    all_configs[menu_key]
  end

  class MenuConfigurations
    class MenuConfig
      attr_accessor :path, :path_starts_with, :parent, :controllers, :action, :children
      def initialize(config)
        %w(path_starts_with parent action).each do |k|
          self.send("#{k}=", config[k])
        end
        if txt = config['controllers']
          self.controllers = txt.split(/[ ,]/).map(&:strip)
        end
        if txt = config['children']
          self.children = txt.split(/[ ,]/).map(&:strip)
        end
        if txt = config['path']
          self.path = Regexp.new(txt)
        end
      end
      def to_s
        if @to_s.nil?
          result = []
          %w(path path_starts_with parent).map do |k| 
            if value = self.send(k)
              result.push "#{k}=#{value}"
            end
          end
          if self.controllers
            result.push 'controllers=' + self.controllers.join(',')
          end
          if self.children
            result.push 'children=' + self.children.join(',')
          end
          @to_s = result.join(', ')
        end
        @to_s
      end
    end

    include Singleton
    def initialize
      @menu_configs = {}
      (AppConfig.m2mhub_menu_selected || {}).merge(AppConfig.menu_selected || {}).each do |key, config|
        @menu_configs[key] = MenuConfig.new(config)
      end
    end

    def key(txt)
      txt = txt.to_s
      @menu_configs[txt] ||= MenuConfig.new('controllers' => txt )
    end
  end

  def menu_selected(menu_key)
    menu_active?(menu_key) ? SELECTED_CSS_CLASS : ''
  end

  def menu_active?(menu_key)
    menu_config = MenuConfigurations.instance.key(menu_key)
    result = false
    dbgtxt = [ "menu_active? #{menu_key}", menu_config ]
    route_info = Rails.application.routes.recognize_path(request.path)
    if menu_config.path
      result = menu_config.path.match(request.path).present?
      dbgtxt.push "request.path = #{request.path}"
    elsif menu_config.path_starts_with
      result = request.path.starts_with?(menu_config.path_starts_with)
      dbgtxt.push "request.path = #{request.path}"
    elsif menu_config.controllers
      controller_name = route_info[:controller]
      result = menu_config.controllers.include?(controller_name)
      dbgtxt.push "controller_name=#{controller_name}"
      # if result and menu_config.parent
      #   parent_id_key = menu_config.parent.to_s.singularize + '_id'
      #   if result = params[parent_id_key].present?
      #     dbgtxt.push "#{parent_id_key} = #{params[parent_id_key]}"
      #   end
      # end
      if result and menu_config.action
        action_name = route_info[:action]
        result = menu_config.action == action_name
        dbgtxt.push "#{action_name}=#{action_name}"
      end
    end
    if !result and menu_config.children
      menu_config.children.each do |child|
        if result = menu_active?(child)
          dbgtxt.push "#{child} child active"
          break
        end
      end
    end
    if result
      dbgtxt.push route_info.inspect
      Rails.logger.info "menu_active? #{menu_key} = #{result}\n\t" + dbgtxt.join("\n\t")
    else
      Rails.logger.info "menu_active? #{menu_key} = #{result} #{route_info.inspect}"
    end
    result
  end

end
