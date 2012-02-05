module SearchHelper
  def search_excerpt(txt, search_txt)
    result = if txt.present? and search_txt.present? 
      txt.gsub(/(#{search_txt})/i).each do |token|
        '<span class="search_match">' + $1 + '</span>'
      end
    else
      txt
    end
    result.html_safe
  end
end