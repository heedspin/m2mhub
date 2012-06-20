jQuery.fn.setupInPlaceActions = function() {
	this.find(".inplace_link").click(function() {
	  $(this).closest(".inplace_show").hide().siblings(".inplace_form").show();
	  return false;
	});
	this.find(".inplace_cancel_link").click(function() {
	  $(this).closest(".inplace_form").hide().siblings(".inplace_show").show();
	  return false;
	});
	this.find(".inplace_form").submit(function() {
		$.post($(this).attr("action"), $(this).serialize(), null, "script");
		return false;
	})
}
$(document).ready(function(){	
	$(".inplace_container").setupInPlaceActions();
})