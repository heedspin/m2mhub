var current_subject = null;
var dom_modification_timer = null;
var contexts_url = null;
var comments_url = null;
var current_user_url = null;
var current_user = null;

// Bootstrap!
chrome.extension.sendMessage({method: "bootstrap"}, function(response) {
	if (response) {
	  contexts_url = response.contexts_url;
		console.debug("Bootstrap contexts_url=" + contexts_url);
	  comments_url = response.comments_url;
		console.debug("Bootstrap comments_url=" + comments_url);
		current_user_url = response.current_user_url;
		console.debug("Bootstrap current_user_url=" + current_user_url);
		if (current_user_url) {
			$.ajax({
			  url: current_user_url,
			  type: 'GET',
				async: true,
			  dataType: 'json'
			}).done(function(response) {
				current_user = response;
				console.debug("Got current user: " + JSON.stringify(current_user));
			}).fail(function(xhr, exception) {
				console.debug("Failed to get current user: " + xhr.status, + " " + xhr.responseText);
				// TODO: Bring up login popup.
			});			
		}
	}
});

function DOMModificationHandler() {
	if (dom_modification_timer) {
		clearTimeout(dom_modification_timer);
	}	else {
		$('body').unbind('DOMSubtreeModified', DOMModificationHandler);		
	}
	dom_modification_timer = setTimeout(processPageChange, 200);
}
$('body').bind('DOMSubtreeModified', DOMModificationHandler);

function getSubject() {
	return $("h1:not([role=banner])").children("span:first").text();
}

function processPageChange() {
	dom_modification_timer = null;
	$('body').bind('DOMSubtreeModified', DOMModificationHandler);
	var new_subject = getSubject();
	if (current_subject != new_subject) {
		current_subject = new_subject;
		if (current_subject) {
			getContextsFromServer();						
		}
	}
}

function getContextsFromServer() {
	if (!contexts_url) {
		return null;
	}
	// chrome.cookies.get({url:context_assistants}, function(cookies){
	//   	console.log("Cookies: " + cookies);
	// });
	$.ajax({
	  url: contexts_url,
	  type: 'GET',
		async: true,
		data: { subject: getSubject() },
	  dataType: 'json'
	}).done(handleContexts).fail(handleContextsFail);	
}

function handleContexts(context) {
	console.debug("Received context: " + JSON.stringify(context));
	var destination = $("#contextassistant");
	destination.empty();
	render_opportunities(context, destination);
	render_comments(context, destination);
}

function handleContextsFail(xhr, exception){
  console.error("Ajax call to get contexts failed: " + xhr.status, + " " + xhr.responseText);
}

function getParents(node) {
  var nodes = [node]
  for (; node; node = node.parentNode) {
    nodes.unshift(node)
  }
  return nodes
}

function commonAncestor(node1, node2) {
  var parents1 = getParents(node1)
  var parents2 = getParents(node2)
  if (parents1[0] != parents2[0]) {
		return undefined;
	}
  for (var i = 0; i < parents1.length; i++) {
    if (parents1[i] != parents2[i]) {
			return parents1[i - 1]
		}
  }
}

var context_assistant_parent = null;
var context_assistant_div = null;
var context_time_in_place = 0;
var load_time = new Date().getTime();
function placeContextAssistant() {
	// var toolbar_main_container = $("div[title=Archive]").last().parents().eq(5);
	var common_ancestor = commonAncestor($("div[title=Archive]").first().get(0), $("h1:not([role=banner])").first().get(0));
	if (common_ancestor) {
		if (context_assistant_parent) {
			if (context_assistant_parent.get(0) != common_ancestor) {
				console.debug("placeContextAssistant: Detected change in ancestory.  Moving context assistant.")
				var archives = $("div[title=Archive]");
				var titles = $("h1:not([role=banner])");
				// debugger;
				context_assistant_div.detach();
			} else {
				console.debug("placeContextAssistant: No change.")
				var elapsed_time_in_place = new Date().getTime() - context_time_in_place;
				if (elapsed_time_in_place <= 4000) {
					setTimeout(placeContextAssistant, elapsed_time_in_place * 2);					
				} else {
					console.debug("placeContextAssistant: No change.  Will stop checking.")
				}
				return;
			}
		}
		context_assistant_parent = $(common_ancestor);
		context_assistant_parent.children("div:first-child").after(context_assistant_div);
		context_assistant_div.show();
		context_time_in_place = new Date().getTime();
		console.debug("placeContextAssistant: placing context assistant.")
		setTimeout(placeContextAssistant, 500);
	} else {
		if (!context_assistant_div && (context_assistant_parent = $('body'))) {
			context_assistant_div = $("<div id=\"contextassistant\"><span>Loading context assistant...</span></div>");
			context_assistant_parent.prepend(context_assistant_div);
			context_assistant_div.hide();
		}
		console.debug("placeContextAssistant: no common parent.")
		setTimeout(placeContextAssistant, (new Date().getTime() - load_time) * 2);
	}
}

placeContextAssistant();
