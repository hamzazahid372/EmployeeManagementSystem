require("datatables.net-bs4");
require("jquery-tokeninput");
$(document).ready( function () {
  if($('#department_projects-tab').length == 1){
    $('#department_projects-tab').click();
  }
  if($('#departments-datatable').length == 1){
    $('#departments-datatable').DataTable({
      info: false,
      paging: false,
      searching: false
    });  
  }
  if($('#projects_department_project_id').length == 1){
    $("#projects_department_project_id").tokenInput('/projects/search.json', {
      theme: "facebook",
      tokenLimit: 1,
    });
  }
});
