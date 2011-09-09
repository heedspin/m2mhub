module ContentModuleHelper
  def content_module_edit_link(cm)
    if current_user and (permitted_to? :edit, cm)
      path = edit_content_module_path(:id => cm.id, :return_to => request.fullpath)
      result = <<-HTML
      <p><a href="#{path}">Edit</a></p>
      HTML
      result.html_safe
    else
      nil
    end
  end
  def content_module(key)
    cm = ContentModule.find_by_key(key.to_s)
    raise "Please create content module for #{key}" if cm.nil?
    if cm.has_content?
      # Secure emails.
      cm.content = cm.content.to_s.gsub(/<a[^href]+href="mailto:([^"]+)"[^>]*>([^<]+)<\/a>/m) do |link|
        mail_to $1, $2, :encode => "javascript" #, :host => request.host
      end
    end
    # Add an edit link.
    if current_user and (permitted_to? :edit, cm)
      path = edit_content_module_path(:id => cm.id, :return_to => request.fullpath)
      editlink = <<-HTML
      <a href="#{path}">Edit</a>
      HTML
      if cm.has_content
        if cm.content =~ /^<p>(.+)<\/p>$/m
          cm.content = '<p>' + $1 + ' ' + editlink + '</p>'
        else
          cm.content << '<p>' + editlink + '</p>'
        end
      else
        cm.title ||= ''
        cm.title << ' ' + editlink
      end
    end
    # disable XSS for all content module attributes
    ContentModule.columns.each do |column| 
      if (value = cm.send(column.name)) and value.respond_to?(:html_safe)
        cm.send("#{column.name}=", value.html_safe)
      end
    end
    cm
  end
end
