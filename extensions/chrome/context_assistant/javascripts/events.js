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
