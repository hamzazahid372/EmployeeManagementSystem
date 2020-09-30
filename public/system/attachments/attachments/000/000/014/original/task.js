require("datatables.net-bs4");

$(document).ready(function () {

  $('#tasks_table').DataTable({
    info: false,
    paging: false,
    searching: false
  });

  $("body").on('change',".data-filter",function(e) {
    e.preventDefault();
    $.ajax({ type:'GET', url: '/tasks.js', data: { project_id: $('#project').val(),
      priority: $('#priority').val(), status: $('#status').val(), assignable_id: $('#assignable_id').val() } });
  });

});
