require('jquery-tokeninput')
$(document).ready( function () {
  
  $('#watchers-tab').on('click', function(e){
    $.ajax({ type:'GET', url: new URL(location.href).pathname + '/tasks_watchers.js' });
  });

  $('body').on('change', '#tasks_watcher_watcher_type', function(e){
    var watcherType = $("#tasks_watcher_watcher_type").val();
    if(watcherType == 'User')
    {
      $("#tasks_watcher_watcher_id").siblings(".token-input-list-facebook").remove();
      $("#tasks_watcher_watcher_id").tokenInput('/users/search.json', {
        theme: "facebook",
        tokenLimit: 1
      });
    }
    else if (watcherType == 'Team')
    {
      $("#tasks_watcher_watcher_id").siblings(".token-input-list-facebook").remove();
      $("#tasks_watcher_watcher_id").tokenInput('/teams/search.json', {
        theme: "facebook",
        tokenLimit: 1
      });
    }
  });
});
