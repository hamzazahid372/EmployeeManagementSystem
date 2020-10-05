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
    assigneeTokenInput(pre);
  }
  if($('#task_reviewer_id').length == 1){
    var pre = [];
    if($("#task_reviewer_id").data("pre").id){
      pre[0] = $("#task_reviewer_id").data("pre");
    }
    reviewerTokenInput(pre);
  }
  if($('#tasks-watchers-datatable').length == 1){
    $('#tasks-watchers-datatable').DataTable({
      info: false,
      paging: false,
      searching: false
    });  
  }
  $('#task_project_id').on('change',function(){
    assigneeTokenInput([]);
    reviewerTokenInput([]);
  });

  function assigneeTokenInput(pre){
    var url = '/users/search.json?project_id=' + $('#task_project_id').val(); 
    $("#task_assignee_id").siblings(".token-input-list-facebook").remove();
    $("#task_assignee_id").tokenInput(url, {
      theme: "facebook",
      tokenLimit: 1,
      prePopulate: pre
    });
  }
  function reviewerTokenInput(pre){
    var url = '/users/search.json?project_id=' + $('#task_project_id').val(); 
    $("#task_reviewer_id").siblings(".token-input-list-facebook").remove();
    $("#task_reviewer_id").tokenInput(url, {
      theme: "facebook",
      tokenLimit: 1,
      prePopulate: pre
    });
  }
});
