require("datatables.net-bs4");
require("jquery-tokeninput");

$(document).ready(function () {
  $('#tasks-datatable').DataTable({
    info: false,
    paging: false,
    searching: false
  });
  if($('.data-filter').length > 0){
    $("body").on('change',".data-filter",function(e) {
      e.preventDefault();
      $.ajax({ type:'GET', url: '/tasks.js', data: { project_id: $('#project').val(),
        priority: $('#priority').val(), status: $('#status').val(), assignee: $('#assignee').val() } });
    });
  }
  if($('#task_assignee_id').length == 1){
    var pre = [];
    if($("#task_assignee_id").data("pre").id){
      pre[0] = $("#task_assignee_id").data("pre");
    }
    $("#task_assignee_id").tokenInput('/users/search.json', {
      theme: "facebook",
      tokenLimit: 1,
      prePopulate: pre
    });
  }
});
