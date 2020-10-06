require("jquery-tokeninput");
require("datatables.net-bs4");
$(document).ready( function () {
  $('#history-tab').on('click', function(e){
    $.ajax({ type:'GET', url: '/reports/task_audits.js?task_id='+ $(this).data('resource-id') });
  });
  $('#attendances-datatable').DataTable({
    info: false,
    paging: false,
    searching: false
  });
  if($('#user_id').length == 1){
    var prePopulate = [];
    if($("#user_id").data("pre-populate").id){
      prePopulate[0] = $("#user_id").data("pre-populate");
    }
    $("#user_id").tokenInput('/users/search.json', {
      theme: "facebook",
      tokenLimit: 1,
      prePopulate: prePopulate
    });
  }
  if($('#project_id').length == 1){
    var prePopulate = [];
    if($("#project_id").data("pre-populate").id){
      prePopulate[0] = $("#project_id").data("pre-populate");
    }
    $("#project_id").tokenInput('/projects/search.json', {
      theme: "facebook",
      tokenLimit: 1,
      prePopulate: prePopulate
    });
  }
});
