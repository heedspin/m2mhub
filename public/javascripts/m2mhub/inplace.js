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
		$.post($(this).closest("form").attr("action"), { _method: "delete" }, null, "script");		
	})
}
jQuery.fn.setupDeletasticActions = function() {
	this.find(".deletastic_delete_link").click(function() {
	  $(this).hide().siblings(".deletastic_confirmation").show();
		$(".deletastic_param").show();
	  return false;
	});
	this.find(".deletastic_delete_cancel_link").click(function() {
		$(this).closest(".deletastic_confirmation").hide().siblings(".deletastic_delete_link").show();
		$(".deletastic_param").hide();
		return false;
	})
	this.find(".deletastic_boom").click(function() {
		var params={};
		var handle_delete = function(data, textStatus) {
			if (data.location) {
				window.location.href = data.location;				
			}
	  }
		var handle_error = function(data, textStatus) {
			alert('Uggg... The delete failed!');
		}
		$(".deletastic_param").each(function(i,e) {
			// Only get last input in each param li.  Checkboxes have multiple.
			$(e).find("input").last().each(function(index, element) {
				var obj = $(element);
				if (obj.is(":checkbox")) {
					params[obj.attr("name")] = obj.is(":checked");
				}	else {
					params[obj.attr("name")] = obj.val();
				}
			})
		})
		$.ajax({
		  type: 'DELETE',
		  url: $(this).closest("form").attr("action"),
			async: false,
			dataType: 'json',
		  data: params,
			success: handle_delete,
			error: handle_error
		});
		return false;
	})
}
$(document).ready(function(){	
	$(".inplace_container").setupInPlaceActions();
	$(".deletastic_container").setupDeletasticActions();
})

