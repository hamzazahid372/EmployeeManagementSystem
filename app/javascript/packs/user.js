require("datatables.net-bs4");

$(document).ready( function () {
  $('#users-datatable').DataTable({
    info: false,
    paging: false,
    searching: false
  });
});