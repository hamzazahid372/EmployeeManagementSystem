require("jquery-tokeninput");
$(document).ready( function () {
  $("#user_id").tokenInput('/users/search.json', {
    theme: "facebook",
    tokenLimit: 1
  });

  $('#history-tab').on('click', function(e){
    $.ajax({ type:'GET', url: '/reports/task_audits.js?task_id='+ $(this).data('resource-id') });
  });
});
