module LinkHelper
  def store_referrer_as_return_to
    path = params[:return_to]
    if path.nil? and (r = request.referrer)
      begin
        path = URI.parse(r).path
      rescue
      end
    end
    if path
      "<input type=\"hidden\" name=\"return_to\" value=\"#{path}\" />"
    else
      nil
    end
  end

  def popup_image_tag(image_path, args)
    link_to image_tag(image_path, args), "/images/#{image_path}", :class => 'wide_popup'  
  end
  
  def nocache(args={})
    if current_user
      args[:nocache] = 1
    end
    args
  end
end