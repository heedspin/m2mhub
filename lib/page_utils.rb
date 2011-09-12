module PageUtils
  PageObject = Struct.new(:menu_title, :url, :object)
  
  def set_previous_page(menu_title, url, object)
    @previous_page = PageObject.new(menu_title, url, object)
  end
  
  def set_next_page(menu_title, url, object)
    @next_page = PageObject.new(menu_title, url, object)
  end

  attr_reader :previous_page, :next_page
  
  def self.included(base)
    base.class_eval <<-EOS
    helper_method :previous_page
    helper_method :next_page
    EOS
  end
end

