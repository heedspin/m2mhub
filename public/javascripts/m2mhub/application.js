// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

$(document).ready(function(){
  $("input.calendar").datepicker({
    yearRange: '-10:+4',
    dateFormat: 'mm/dd/yy',
    showOn: 'button',
    buttonImage: '/images/m2mhub/calendar.png',
    buttonImageOnly: true,
		inline: true
  });
});

function ajax_link(target_id) {
	$(target_id + ' a.ajax_link').bind('click', function(event){
    event.preventDefault();
		$(this).replaceWith('<p class="inprogress">Fetching...</p>');
		ajax_load_content($(this).attr('href'), target_id)
	});	
}

function ajax_load_content(href, target_id) {
	$.ajax({
  url: href,
  type: 'GET',
  dataType: 'html',
  success: function(data) {
		$(target_id).html(data);
		ajax_link(target_id);
  },
  error: function(){
    // alert('Unable to load. Please try again later.');
  }
})
}
