require("datatables.net-bs4");
document.currentScript.setAttribute("data-turbolinks-eval", "false");

$(document).ready( function () {
  $('#time_logs-tab').on('click', function(e){
    $.ajax({ type:'GET', url: new URL(location.href).pathname + '/time_logs' });
  });
});