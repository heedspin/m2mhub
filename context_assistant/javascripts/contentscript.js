var current_subject = null;
var dom_modification_timer = null;
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
			showContextAssistant();			
		} else {
			hideContextAssistant();
		}
	}
}

var context_assistant_div = null;
function showContextAssistant() {
	var context_assistant_div = $("#contextassistant");
	if ((context_assistant_div.length == 0) && current_subject) {
		// var toolbar_main_container = $("div[role=button] > span:contains('More')").last().parents().eq(10);
		var toolbar_main_container = $("div[title=Archive]").last().parents().eq(5);
		// debugger;
		context_assistant_div = $("<div id=\"contextassistant\"><span>Loading context assistant...</span></div>");
		toolbar_main_container.children("div:first-child").after(context_assistant_div);
	}
	$("#contextassistant").show();
	getContextAssistantsFromServer();
}

function hideContextAssistant() {
	$("#contextassistant").hide();
}

function getContextAssistantsFromServer() {
	var context_assistants_url = "https://staging.lxdinc.com/m2mhub_context_assistants.json";
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

function createLink(text, url) {
	if (!url) return document.createTextNode(text);
	var a = document.createElement('a');
	a.title = text;
	a.href = url;
	a.appendChild(document.createTextNode(text));
	return a;
}

function handleContexts(data) {
	console.log("Received contexts: " + JSON.stringify(data));
	var destination = $("#contextassistant");
	destination.empty();
	for(var i=0; i < data.length; i++) {
		var context = data[i];
		var context_element = document.createElement('div');
		context_element.class = 'context';
		var p_element = document.createElement('p');
		context_element.appendChild(p_element);
		if (context.customer) {
			var span_element = document.createElement('span');
			span_element.appendChild(document.createTextNode("Customer: "));
			span_element.appendChild(createLink(context.customer, context.customer_url));
			p_element.appendChild(span_element);
			p_element.appendChild(document.createTextNode(" "));
		}
		{
			var span_element = document.createElement('span');
			span_element.appendChild(document.createTextNode("Opportunity: "));
			span_element.appendChild(createLink(context.title, context.url));
			p_element.appendChild(span_element);			
			p_element.appendChild(document.createTextNode(" "));
		}
		for (var ii = 0; ii < context.part_numbers.length; ii++) {
			var part = context.part_numbers[ii];
			var span_element = document.createElement('span');
			span_element.appendChild(createLink(part.part_number, part.url));
			p_element.appendChild(span_element);
			p_element.appendChild(document.createTextNode(" "));
		}
		destination.append(p_element);
	}
}
function handleContextsFail(xhr, exception){
  console.debug("Ajax call to context_assistants failed: " + xhr.status, + " " + xhr.responseText);
}


// chrome.runtime.sendMessage({hello: "musketeer"}, function() {});	
