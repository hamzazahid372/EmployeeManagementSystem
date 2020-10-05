require("datatables.net-bs4");

$(document).ready( function () {
  $('#tasks-tab').on('click',function(){
    e.preventDefault();
    $.ajax({ type:'GET', url: 'tasks/index.js.erb', data: { project_id: $('#project').val(),
    priority: $('#priority').val(), status: $('#status').val(), assignee: $('#assignee').val() } });
  });

  $('#projects-datatable').DataTable({
    info: false,
    paging: false,
    searching: false
  });
} );
