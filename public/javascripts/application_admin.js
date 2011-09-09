// Calendar date-picker widget
$(document).ready(function(){
  $("li.calendar input").datepicker({
		inline: true
  });

	$('textarea.mceEditor').tinymce({
		script_url : '/javascripts/tiny_mce/tiny_mce.js',
		content_css: '/stylesheets/tinymce.css',
		theme : "advanced",
		mode : "specific_textareas",
		editor_selector : "mceEditor",
		plugins : "safari,pagebreak,style,layer,table,save,advhr,advimage,advlink,emotions,iespell,inlinepopups,insertdatetime,preview,media,searchreplace,print,contextmenu,paste,directionality,fullscreen,noneditable,visualchars,nonbreaking,xhtmlxtras,template",
		relative_urls : false,

		// Theme options
		theme_advanced_buttons1 : "bold,italic,underline,strikethrough,|,justifyleft,justifycenter,justifyright,justifyfull,|,formatselect,|,hr,removeformat,|,sub,sup,|,charmap,iespell,advhr,|,fullscreen,|,attribs",
		theme_advanced_buttons2 : "cut,copy,paste,pastetext,pasteword,|,search,replace,|,bullist,numlist,|,outdent,indent,blockquote,|,undo,redo,|,link,unlink,cleanup,code",
		theme_advanced_buttons3 : "",
		theme_advanced_toolbar_location : "top",
		theme_advanced_toolbar_align : "left",
		theme_advanced_statusbar_location : "bottom",
		theme_advanced_resizing : true,
	});
});

