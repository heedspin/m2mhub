jQuery.fn.setupInPlaceActions = function() {
	this.find(".inplace_show").click(function() {
	  $(this).hide().siblings(".inplace_form").show().find("input[type=text]").focus();
	  return false;
	});
	this.find(".inplace_cancel_link").click(function() {
	  $(this).closest(".inplace_form").hide().siblings(".inplace_show").show();
		$(this).siblings(".inplace_delete_confirmation").hide();
		$(this).siblings(".inplace_delete_link").show();
	  return false;
	});
	this.find(".inplace_form").submit(function() {
		$.post($(this).attr("action"), $(this).serialize(), null, "script");
		return false;
	})
	this.find(".inplace_delete_link").click(function() {
	  $(this).hide().siblings(".inplace_delete_confirmation").show();
	  return false;
	});
	this.find(".inplace_delete_cancel_link").click(function() {
		$(this).closest(".inplace_delete_confirmation").hide().siblings(".inplace_delete_link").show();
	})
	this.find(".inplace_delete_confirmation_link").click(function() {
		$.post($(this).closest(".inplace_container").find(".inplace_form").attr("action"), { _method: "delete" }, null, "script");		
	})
}
$(document).ready(function(){	
	$(".inplace_container").setupInPlaceActions();
})