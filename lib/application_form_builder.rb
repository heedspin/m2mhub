class ApplicationFormBuilder < Formtastic::SemanticFormBuilder
  def cancel_link(options = {})
    location = options[:url] || template.request.params[:_cancel_url] || template.request.referer || '/'
    template.hidden_field_tag(:_cancel_url, location)
    
    if location =~ /\?/
      location = location + '&_cancel=1'
    else
      location = location + '?_cancel=1'
    end
    
    template.content_tag(:li, template.link_to('Cancel', location), :class => "cancel" )
  end

  def calendar_input(method, options)
    # don't want to use #{method}_before_type_cast; want to get the value after it has been formatted
    options[:value] ||= @object.send(method).try(:to_s, :mdy)
    label(method, options.delete(:label), options.slice(:required)) + text_field(method, options.except(:required))
  end
  
  # Implements image preview and delete option.
  def attachment_input(method, options = {})
    delete_attachment_link  = "delete_#{method}_link"
    preview_id  = "#{method}_preview"
    attachment_file_field = "#{method}_file_field"
    unless (attachment = @object.send(method)).blank? or (not attachment.file?)
      if (attachment.content_type =~ /^image\/.+/) and (attachment.styles.member?(:thumbnail) or attachment.styles.member?(:edit))
        style = attachment.styles.member?(:thumbnail) ? :thumbnail : :edit
        preview = <<-HTML
        <img id="#{preview_id}" src="#{attachment.url(style)}" />
        HTML
      else
        preview = <<-HTML
        <a href="#{attachment.url}" id="#{preview_id}">#{attachment.original_filename}</a>
        HTML
      end
    end
    deleter_input_id = "#{method}_deleter"
    deleter_input_html = hidden_field(method.to_s + '_file_name', :value => '', :id => deleter_input_id )
    magic = <<-JAVASCRIPT
    <script type="text/javascript">
      $(function() {
        $("##{delete_attachment_link}").click(function() {
          $('##{preview_id}').hide();
          $('##{delete_attachment_link}').hide();
          $(this).after('#{deleter_input_html}');
          return false;
        });
        $('form').submit(function () {
          if ($('##{attachment_file_field}').val() != '') {
            $('##{deleter_input_id}').remove();
          }
          return true;
        });
      })
      </script>
    JAVASCRIPT
    ff = file_field method, {:id => attachment_file_field}.merge(options.except(:required))
    if preview
      preview << <<-HTML
      <span class="attachment_delete" id="#{delete_attachment_link}">(<a href="#delete">Delete</a>)</span>
      HTML
    end
    l = label(method, options.delete(:label), options.slice(:required))

    template.content_tag(:li, <<-HTML, nil, false)
      #{l}
      #{ff}
      <div class="attachment_preview">#{preview}</div>
      #{magic}
    HTML
  end
end
