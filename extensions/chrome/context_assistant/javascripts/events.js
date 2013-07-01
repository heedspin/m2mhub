chrome.extension.onMessage.addListener(function(request, sender, sendResponse) {
	if (request.method == "bootstrap") {
		console.log("tab " + sender.tab.id + " bootstrapping with url: " + sender.tab.url);
		var context_server = localStorage['context_server'];
		var comments_url = null;
		var contexts_url = null;
		var current_user_url = null;
		if (context_server) {
			comments_url = "https://" + context_server + "/context_comments";
	 		contexts_url = "https://" + context_server + "/contexts.json";	
	 		current_user_url = "https://" + context_server + "/users/0.json";	
		}
		sendResponse({contexts_url: contexts_url, comments_url: comments_url, current_user_url: current_user_url});
		chrome.tabs.onUpdated.addListener(function(tabId, changeInfo, tab) {
			if (changeInfo.url && (tab.id == sender.tab.id)) {
				console.log("tab " + tabId + " changed url: " + changeInfo.url);
			}		
		});
	}	else {
		sendResponse({});
	}
});

chrome.runtime.onInstalled.addListener(function(details) {
	var default_context_server = "m2mhub.lxdinc.com";
	if (details.reason == 'install') {
		localStorage['context_server'] = default_context_server;
	} else if (details.reason == 'update') {
		if (!localStorage['context_server']) {
			localStorage['context_server'] = default_context_server;
		}
	}
});

