require("datatables.net-bs4");
document.currentScript.setAttribute("data-turbolinks-eval", "false");

$(document).ready( function () {
  $('#comments-datatable').DataTable();
  $.get({url: new URL(location.href).pathname + '/comments.js'});
});