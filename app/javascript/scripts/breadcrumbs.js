$(document).ready(function() {
  var children = document.getElementById("breadcrumbs").children;
  for(var i = 0; i < children.length - 1; i++) {
    children[i].classList.add("btn");
    children[i].classList.add("btn-dark");
    children[i].classList.add("mr-1");
    children[i].setAttribute("text-decoration", "none")
    children[i].firstChild.classList.add("text-white");
  }
  if(children[children.length - 1]){
    children[children.length - 1].classList.add("btn");
    children[children.length - 1].classList.add("btn-light");
  }
});
