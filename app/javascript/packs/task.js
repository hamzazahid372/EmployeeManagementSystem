require("datatables.net-bs4");
$(document).ready(function () {
  $('#tasks-table').DataTable();

  $("#Project").change(function() {
    alert($(this).val());
    $.ajax({ type:'GET', url: '/tasks.js', data: { project_id: $(this).val() } });
  });

  $("#priority").change(function(){
    alert($(this).val());
    $.ajax({ type:'GET', url: '/tasks.js', data: { priority: $(this).val() } });
  });

  $("#status").change(function(){
    alert($(this).val());
    $.ajax({ type:'GET', url: '/tasks.js', data: { status: $(this).val() } });
  });

  $("#assignable_id").change(function(){
    alert($(this).val());
    $.ajax({ type:'GET', url: '/tasks.js', data: { assignable_id: $(this).val() } });
  });


});
