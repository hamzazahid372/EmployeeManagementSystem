require("datatables.net-bs4");

$(document).ready(function () {

  $('#tasks_table').DataTable({
    info: false,
    paging: false,
    searching: false
  });
  $("body").on('change',"#Project",function(e) {
    e.preventDefault();
    $.ajax({ type:'GET', url: '/tasks.js', data: { project_id: $(this).val(),
      priority: $('#priority').val(), status: $('#status').val(), assignable_id: $('#assignable_id').val() } });
  });

  $("body").on('change',"#priority",function(e) {
    e.preventDefault();
    $.ajax({ type:'GET', url: '/tasks.js', data: { project_id: $('#Project').val(),
      priority: $(this).val(), status: $('#status').val(), assignable_id: $('#assignable_id').val() } });
  });

  $("body").on('change',"#status",function(e) {
    e.preventDefault();
    $.ajax({ type:'GET', url: '/tasks.js', data: { project_id: $('#Project').val(),
      priority: $('#priority').val(), status: $(this).val(), assignable_id: $('#assignable_id').val() } });
  });

  $("body").on('change',"#assignable_id",function(e) {
    e.preventDefault();
    $.ajax({ type:'GET', url: '/tasks.js', data: { project_id: $('#Project').val(),
      priority: $('#priority').val(), status: $('#status').val(), assignable_id: $(this).val() } });
  });


});
