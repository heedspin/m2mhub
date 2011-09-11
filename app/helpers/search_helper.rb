module SearchHelper
  def search_excerpt(txt, search_txt)
    result = txt
    if txt.present? and search_txt.present? 
      txt.gsub(/(#{search_txt})/i).each do |token|
        '<span class="search_match">' + $1 + '</span>'
      end
    else
      txt
    end
  end
end