require("datatables.net-bs4");

$(document).ready( function () {
  $('#projects-datatable').DataTable({
    info: false,
    paging: false,
    searching: false
  });
} );
