$(document).ready( function () {
  $('#users_teams-tab').on('click', function(e){
    $.ajax({ type:'GET', url: new URL(location.href).pathname + '/users_teams.js' });
  });
});
