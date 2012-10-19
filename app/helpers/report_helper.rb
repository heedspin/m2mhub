module ReportHelper
  def include_closed_details_javascript(show_text='Show Details', hide_text='Hide Details')
    show_text = escape_javascript(show_text)
    hide_text = escape_javascript(hide_text)
    html = <<-HTML
    <script type="text/javascript">
    $(function() {
    	$(".show_closed_details").toggle(function() { 
    	  $(".x" + $(this).attr("id")).show();
    	  $(this).html("#{hide_text}");
    	}, function() {
    	  $(".x" + $(this).attr("id")).hide();
    	  $(this).html("#{show_text}");
    	});
    });
    </script>
    HTML
    content_for :javascripts, html.html_safe
  end

  def include_toggle_javascript(toggle_class, show_text='Show Details', hide_text='Hide Details')
    show_text = escape_javascript(show_text)
    hide_text = escape_javascript(hide_text)
    html = <<-HTML
    <script type="text/javascript">
    $(function() {
    	$(".#{toggle_class}").toggle(function() { 
        var this_id = $(this).attr("id");
    	  $("#x" + this_id).show();
    	  $(this).children(".replace_" + this_id).html("#{hide_text}");
    	}, function() {
        var this_id = $(this).attr("id");
    	  $("#x" + this_id).hide();
    	  $(this).children(".replace_" + this_id).html("#{show_text}");
    	});
    });
    </script>
    HTML
    content_for :javascripts, html.html_safe
  end

end