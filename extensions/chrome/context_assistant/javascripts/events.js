chrome.extension.onMessage.addListener(function(request, sender, sendResponse) {
	if (request.method == "getLocalStorage") {
		var result = localStorage[request.key];
		if (result) {
	 		result = "https://" + result + "/m2mhub_context_assistants.json";	
		}
		sendResponse({data: result});
	}	else {
		sendResponse({});		
	}
});

chrome.runtime.onInstalled.addListener(function(object details) {
	if (details.reason == 'install') {
		localStorage['opportunity_server'] = "m2mhub.lxdinc.com";
	}
});