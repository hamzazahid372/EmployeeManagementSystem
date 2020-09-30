$(document).ready( function () {
  $.get({url: new URL(location.href).pathname + '/attachments.js'});
});