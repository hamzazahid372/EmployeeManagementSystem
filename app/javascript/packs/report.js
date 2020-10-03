$(document).ready( function () {
  $('#history-tab').on('click', function(e){
    $.ajax({ type:'GET', url: '/reports/task_audits.js?task_id='+ $(this).data('resource-id') });
  });
});
