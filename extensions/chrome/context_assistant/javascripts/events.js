chrome.extension.onMessage.addListener(function(request, sender, sendResponse) {
	if (request.method == "bootstrap") {
		var opportunity_server = localStorage['opportunity_server'];
		if (opportunity_server) {
	 		opportunity_server = "https://" + opportunity_server + "/m2mhub_context_assistants.json";	
		}
		sendResponse({opportunity_server: opportunity_server});		
		// $.ajax({
		// 	url: chrome.extension.getURL("/html/new_comment.html"),
		// 	dataType: "html",
		// 	success: function(new_comment_html) {
		// 		sendResponse({opportunity_server: opportunity_server, new_comment_html: new_comment_html});
		// 	}
		// });
		// return true; // Allow asychronous response.
	}	else {
		sendResponse({});
	}
});

chrome.runtime.onInstalled.addListener(function(details) {
	var default_opportunity_server = "m2mhub.lxdinc.com";
	if (details.reason == 'install') {
		localStorage['opportunity_server'] = default_opportunity_server;
	} else if (details.reason == 'update') {
		if (!localStorage['opportunity_server']) {
			localStorage['opportunity_server'] = default_opportunity_server;
		}
	}
});