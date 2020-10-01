$(document).ready( function () {
  $('#projects_users-tab').on('click', function(e){
    $.ajax({ type:'GET', url: new URL(location.href).pathname + '/projects_users.js' });
  });
});
