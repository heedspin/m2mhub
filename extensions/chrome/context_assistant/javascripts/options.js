// Save this script as `options.js`

// Saves options to localStorage.
function save_options() {
  var opportunity_server_input = document.getElementById("opportunity_server");
  localStorage["opportunity_server"] = opportunity_server_input.value;

  // Update status to let user know options were saved.
  var status = document.getElementById("status");
  status.innerHTML = "Options Saved.";
  setTimeout(function() {
    status.innerHTML = "";
  }, 750);
}

// Restores select box state to saved value from localStorage.
function restore_options() {
  var opportunity_server = localStorage["opportunity_server"];
  if (!opportunity_server) {
    opportunity_server = "m2mhub.lxdinc.com";
  }
  var opportunity_server_input = document.getElementById("opportunity_server");
	opportunity_server_input.value = opportunity_server;
}
document.addEventListener('DOMContentLoaded', restore_options);
document.querySelector('#save').addEventListener('click', save_options);
