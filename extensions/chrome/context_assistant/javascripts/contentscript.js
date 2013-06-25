var current_subject = null;
var dom_modification_timer = null;
var context_assistants_url = null;

function DOMModificationHandler() {
	if (dom_modification_timer) {
		clearTimeout(dom_modification_timer);
	}	
	dom_modification_timer = setTimeout(processPageChange, 200);
}
$('body').bind('DOMSubtreeModified', DOMModificationHandler);

function getSubject() {
	return $("h1:not([role=banner])").children("span:first").text();
}

function processPageChange() {
	var new_subject = getSubject();
	if (current_subject != new_subject) {
		current_subject = new_subject;
		if (current_subject) {
			getContextAssistantsFromServer();						
		}
	}
}

function getContextAssistantsFromServer() {
	if (!context_assistants_url) {
		return null;
	}
	// chrome.cookies.get({url:context_assistants}, function(cookies){
	//   	console.log("Cookies: " + cookies);
	// });
	$.ajax({
	  url: context_assistants_url,
	  type: 'GET',
		async: true,
		data: { subject: getSubject() },
	  dataType: 'json'
	}).done(handleContexts).fail(handleContextsFail);	
}

function handleContexts(data) {
	console.log("Received contexts: " + JSON.stringify(data));
	var destination = $("#contextassistant");
	destination.empty();
	for(var i=0; i < data.length; i++) {
		var context = data[i];
		if (context.type == 'opportunity') {
			destination.append(opportunity_html)
			render_opportunity(destination, context);
		} else if (context.type == 'comment') {
			destination.append(comment_html)
			render_comment(destination, context);
		}
	}
	new_comment_main();
}

function handleContextsFail(xhr, exception){
  console.debug("Ajax call to context_assistants failed: " + xhr.status, + " " + xhr.responseText);
}

chrome.extension.sendMessage({method: "bootstrap"}, function(response) {
	if (response) {
		if (response.opportunity_server) {
		  context_assistants_url = response.opportunity_server;
			console.log("Bootstrap opportunity_server=" + context_assistants_url);
		}
		if (response.new_comment_html) {
			new_comment_html = response.new_comment_html;
			// console.log("Bootstrap new_comment_html=" + response.new_comment_html);
		}
	}
});

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
var context_assistant_div = $("<div id=\"contextassistant\"><span>Loading context assistant...</span></div>");
var context_time_in_place = 0;
var load_time = new Date().getTime();
function placeContextAssistant() {
	// var toolbar_main_container = $("div[title=Archive]").last().parents().eq(5);
	var common_ancestor = commonAncestor($("div[title=Archive]").first().get(0), $("h1:not([role=banner])").first().get(0));
	if (common_ancestor) {
		if (context_assistant_parent) {
			if (context_assistant_parent.get(0) != common_ancestor) {
				console.log("placeContextAssistant: Detected change in ancestory.  Moving context assistant.")
				context_assistant_div.detach();
			} else {
				console.log("placeContextAssistant: No change.")
				setTimeout(placeContextAssistant, (new Date().getTime() - context_time_in_place) * 2);
				return;
			}
		}
		context_assistant_parent = $(common_ancestor);
		context_assistant_parent.children("div:first-child").after(context_assistant_div);
		context_time_in_place = new Date().getTime();
		console.log("placeContextAssistant: placing context assistant.")
		setTimeout(placeContextAssistant, 500);
	} else {
		console.log("placeContextAssistant: no common parent.")
		setTimeout(placeContextAssistant, (new Date().getTime() - load_time) * 2);
	}
}

placeContextAssistant();
