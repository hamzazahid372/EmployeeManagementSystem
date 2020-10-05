require("datatables.net-bs4");
require("jquery-tokeninput");

$(document).ready( function () {
  if($('#teams-datatable').length == 1){
    $('#teams-datatable').DataTable({
      info: false,
      paging: false,
      searching: false
    });  
  }
  if($('#team_lead_id').length == 1){
    var pre = [];
    if($("#team_lead_id").data("pre").id){
      pre[0] = $("#team_lead_id").data("pre");
    }
    $("#team_lead_id").tokenInput('/users/search.json?only_admins=true', {
      theme: "facebook",
      tokenLimit: 1,
      prePopulate: pre
    });
  }
});
