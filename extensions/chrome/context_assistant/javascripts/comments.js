var comments_template = null;
var current_comments = null;
var current_context = null;

function submit_new_comment() {
	var comment_text_area = $(this).parent().find("textarea");
	var comment_text = comment_text_area.val();
	if (comment_text) {
		$.ajax({
			url: comments_url + '.json',
			type: 'POST',
			dataType: 'json',
			data: { comment: { subject: current_subject, text: comment_text } }
		}).done(function(new_comment) {
			console.log("Posting new comment succeeded: " + JSON.stringify(new_comment));
			comment_text_area.val("");
			if (current_comments) {
				current_comments.unshift(new_comment)
				render_comments();
			}
		}).fail(function(xhr, exception){
			console.log("Posting new comment failed: " + xhr.status, + " " + xhr.responseText);
		})
	} else {
		console.log("No comment text");
	}
}

function render_comments(context, destination) {
	if (context) {
		current_context = context;
		current_comments = context.comments;		
	}
	if (!destination) destination = $("#contextassistant");
	var comments_container = destination.find("#ca_comments");
	if (comments_container.length == 0) {
		comments_container = $('<div id="ca_comments"></div>');
		destination.append(comments_container);
	}
	var html = comments_template({ current_user: current_user, comments: current_context.comments, context: current_context });
	var new_elements = $(html);
	comments_container.replaceWith(new_elements);
	comments_ready(new_elements);
}

function get_comment(comment_id) {
	if (!current_comments) return null;
	for (var i=0; i < current_comments.length; i++) {
		var comment = current_comments[i];
		if (comment.id == comment_id) return comment;
	}
	return null;
}

function remove_comment(comment_id) {
	if (!current_comments) return null;
	for (var i=0; i < current_comments.length; i++) {
		var comment = current_comments[i];
		if (comment.id == comment_id) current_comments.splice(i,1)
	}
}

function comments_ready(container) {
	container.find("#ca_new_comment > button").click(submit_new_comment);
	container.find("textarea.expanding").expandingTextarea();
	// Populated comment edit form.
	container.find(".ca_hidden_edit .ca_edit").on('click', function(e) {
		var comment_id = $(this).parent().attr("data-id");
		console.log("Editing comment " + comment_id);
		$("#ca_new_comment").hide();
		var edit_container = $("#ca_edit_comment").show();
		edit_container.attr("data-id", comment_id);
		var comment = get_comment(comment_id);
		if (comment) edit_container.find("textarea").val(comment.text);
	});
	// Toggle Save / Delete button.
	container.find("#ca_edit_comments").on('click', 'input.delete_option', function(e) {
		console.log("#ca_edit_comments input.delete_option click");
		var save_button = $(this).siblings("button");
		if ($(this).is(":checked")) {
			save_button.html("Delete");
		} else {
			save_button.html("Save");			
		}
	});
	// Handle Edit Save / Delete button.
	container.find("#ca_edit_comments").on("click", "#ca_edit_comment > button", function(e) {
		var button = $(this);
		var comment_id = button.parent().attr("data-id");		
		if (button.html() == "Save") {
			save_comment(comment_id, button.siblings("textarea").val());
		} else {
			delete_comment(comment_id);
		}
	});
}

function save_comment(comment_id, comment_text) {
	$.ajax({
		url: comments_url + "/" + comment_id + ".json",
		type: 'PUT',
		dataType: 'json',
		data: { comment: { text: comment_text } }
	}).done(function() {
		console.log("Putting comment succeeded");
		if (current_comments) {
			var comment = get_comment(comment_id);
			if (comment) comment.text = comment_text;
			render_comments();
			show_new_comment_form();
		}
	}).fail(function(xhr, exception){
		console.log("Posting new comment failed: " + xhr.status, + " " + xhr.responseText);
	})
}

function delete_comment(comment_id) {
	$.ajax({
		url: comments_url + "/" + comment_id + ".json",
		type: 'DELETE',
		dataType: 'json',
	}).done(function() {
		console.log("Delete comment succeeded");
		remove_comment(comment_id);
		render_comments();
		show_new_comment_form();
	}).fail(function(xhr, exception){
		console.log("Posting new comment failed: " + xhr.status, + " " + xhr.responseText);
	})
}

function show_new_comment_form() {
	$("#ca_new_comment").show();
	$("#ca_edit_comment").hide();	
}

$.ajax({
	url: chrome.extension.getURL("html/comments.html"),
	dataType: "html",
	success: function(html) {
		comments_template = Handlebars.compile(html);
	}
});
