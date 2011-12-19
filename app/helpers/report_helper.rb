module ReportHelper
  def include_closed_details_javascript
    content_for :javascripts, <<-HTML
    <script type="text/javascript">
    $(function() {
    	$(".show_closed_details").toggle(function() { 
    	  $("#x" + $(this).attr("id")).show();
    	  $(this).html("Hide Details");
    	}, function() {
    	  $("#x" + $(this).attr("id")).hide();
    	  $(this).html("Show Details");
    	});
    });
    </script>
    HTML
  end
end