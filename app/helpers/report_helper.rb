module ReportHelper
  def include_closed_details_javascript(show_text='Show Details', hide_text='Hide Details')
    html = <<-HTML
    <script type="text/javascript">
    $(function() {
    	$(".show_closed_details").toggle(function() { 
    	  $("#x" + $(this).attr("id")).show();
    	  $(this).html("#{hide_text}");
    	}, function() {
    	  $("#x" + $(this).attr("id")).hide();
    	  $(this).html("#{show_text}");
    	});
    });
    </script>
    HTML
    content_for :javascripts, html.html_safe
  end
end