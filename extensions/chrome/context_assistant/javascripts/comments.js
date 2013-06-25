var new_comment_html = null;
var comment_html = null;

function new_comment_main() {
	$(".ca_comment > textarea").expandingTextarea();
}

$.ajax({
	url: chrome.extension.getURL("html/new_comment.html"),
	dataType: "html",
	success: function(html) {
		new_comment_html = html;
	}
});
