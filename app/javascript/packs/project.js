require("datatables.net-bs4");

$(document).ready( function () {
  $('#tasks-tab').on('click',function(e){
    e.preventDefault();
    $.ajax({ type:'GET', url: '/tasks.js', data: { project_id: $('#project_id').val() } });
  });

  $('#projects-datatable').DataTable({
    info: false,
    paging: false,
    searching: false
  });
} );
