require("datatables.net-bs4");
$(document).ready( function () {
  $('#events-datatable').DataTable({
    info: false,
    paging: false,
    searching: false
  });
} );
