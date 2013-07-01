Handlebars.registerHelper('link', function(text, url) {
  text = Handlebars.Utils.escapeExpression(text);
	var result = null;
	if (url) {
	  url  = Handlebars.Utils.escapeExpression(url);
	  result = '<a href="' + url + '">' + text + '</a>';		
	} else {
		result = url;
	}
  return new Handlebars.SafeString(result);
});

Handlebars.registerHelper('name', function(id, first_name, last_name) {
	var result = null;
	if (current_user && (current_user.id == id)) {
		result = 'me';
	} else {
		result = first_name
	}
	return result;
});

Handlebars.registerHelper('each_comment', function(comments, options) {
	var out = '';
	var current_creator_id = null;
	for (var i = 0; i < comments.length; i++) {
		var comment = comments[i];
		if (comment.creator_id != current_creator_id) {
			current_creator_id = comment.creator_id;
			comment = $.extend(true, {new_creator: true}, comment);
			out = out + options.fn(comment);
		} else {
			out = out + options.fn(comment);
		}
	}
	return out;
});

Handlebars.registerHelper('simple_format', function(text) {
  text = Handlebars.Utils.escapeExpression(text);
	return new Handlebars.SafeString(text.replace(/\n/g, '<br />'));
});

Handlebars.registerHelper('if_equal', function(a,b,options) {
	if (a == b) {
		return options.fn(this);
	} else {
		return options.inverse(this);
	}
});