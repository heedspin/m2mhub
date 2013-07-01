var opportunities_template = null;
var current_context = null;

function render_opportunities(context, destination) {
	if (context) {
		current_context = context;
		current_opportunities = context.opportunities;		
	}
	if (!destination) destination = $("#contextassistant");
	var opportunity_container = destination.find("#ca_opportunities");
	if (opportunity_container.length == 0) {
		opportunity_container = $('<div id="ca_opportunities"></div>');
		destination.append(opportunity_container);
	}
	var html = opportunities_template({ current_user: current_user, 
		opportunities: current_context.opportunities, 
		context: current_context 
	});
	var old_container = opportunity_container.replaceWith(html);
}

$.ajax({
	url: chrome.extension.getURL("html/opportunities.html"),
	dataType: "html",
	success: function(html) {
		opportunities_template = Handlebars.compile(html);
	}
});
