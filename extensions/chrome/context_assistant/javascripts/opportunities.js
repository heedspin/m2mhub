var opportunity_html = null;

function render_opportunity(destination, data) {
	directive = {
	  'tr:nth-child(1) > td:nth-child(2) > a':'title',
	  'tr:nth-child(1) > td:nth-child(2) > a@href':'url',
	  'tr:nth-child(2) > td:nth-child(2) > a':'customer',
	  'tr:nth-child(2) > td:nth-child(2) > a@href':'customer_url'
  }
  destination.render(data, directive);
}

$.ajax({
	url: chrome.extension.getURL("html/opportunity.html"),
	dataType: "html",
	success: function(html) {
		opportunity_html = html;
	}
});
