$(document).ready( function () {
  $.get({url: new URL(location.href).pathname + '/projects_departments.js'});
});
