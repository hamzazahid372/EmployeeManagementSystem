require("datatables.net-bs4");
document.currentScript.setAttribute("data-turbolinks-eval", "false");

$(document).ready( function () {
  $('#users-datatable').DataTable();
});