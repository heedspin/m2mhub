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
  def get_meta_title
    txt = content_for(:meta_title)
    txt = content_for(:title) unless txt.present?
    txt = if txt.present?
      "#{txt} | #{AppConfig.long_name}"
    else
      AppConfig.long_name
    end
    strip_tags(txt).html_safe
  end
end
