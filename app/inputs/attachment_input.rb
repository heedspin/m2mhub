class AttachmentInput < Formtastic::Inputs::FileInput
  # Implements image preview and delete option.
  def to_html
    delete_attachment_link  = "delete_#{method}_link"
    preview_id  = "#{method}_preview"
    attachment_file_field = method #"#{method}_file_field"
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
    deleter_input_html = builder.hidden_field(method.to_s + '_file_name', :value => '', :id => deleter_input_id )
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
          if ($('##{object_name}_#{method}').val() != '') {
            $('##{deleter_input_id}').remove();
          }
          return true;
        });
      })
      </script>
    JAVASCRIPT
    ff = builder.file_field(method, input_html_options.except(:required))
    if preview
      preview << <<-HTML
      <span class="attachment_delete" id="#{delete_attachment_link}">(<a href="#delete">Delete</a>)</span>
      HTML
    end
    l = builder.label(method, input_html_options.delete(:label), input_html_options.slice(:required))

    result = <<-HTML
      #{l}
      #{ff}
      <div class="attachment_preview">#{preview}</div>
      #{magic}
    HTML
    template.content_tag :li, result.html_safe, :class => 'input', :id => "#{object_name}_#{method}_input"
  end
end