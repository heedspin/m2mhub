module LayoutHelper
  def title(txt)
    return unless txt.present?
    txt = txt.html_safe
    content_for(:title, txt)
    txt
  end
  def meta_title(txt)
    return unless txt.present?
    content_for(:meta_title, txt)
    txt
  end
  def meta_description(txt)
    return unless txt.present?
    content_for(:meta_description, txt)
    txt
  end
  def meta(cm)
    unless cm.is_a?(ContentModule)
      cm = content_module(cm)
    end
    title cm.title_was if cm.has_title?
    meta_title cm.meta_title if cm.has_meta_title? && cm.meta_title.present?
    meta_description cm.meta_description if cm.has_meta_description?
    cm
  end
  def get_meta_title
    txt = content_for(:meta_title)
    txt = content_for(:title) unless txt.present?
    txt = if txt.present?
      "#{txt} | #{CompanyConfig.long_name}"
    else
      CompanyConfig.long_name
    end
    strip_tags(txt).html_safe
  end
  def navigation_li(key, link_text)
		url = send("#{key}_url", nocache)
    result = <<-HTML
		<li class="#{controller_selected(key.to_s.pluralize)}">
			<a href="#{url}">#{link_text}</a>
		</li>
		HTML
		result.html_safe
	end
end
