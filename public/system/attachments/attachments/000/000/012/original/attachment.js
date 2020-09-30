$(document).ready( function () {
  $('#documents-tab').on('click', function(e){
    $.ajax({ type:'GET', url: new URL(location.href).pathname + '/attachments.js' });
  });
});