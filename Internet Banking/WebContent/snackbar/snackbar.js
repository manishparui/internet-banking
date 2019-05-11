function snackbarFun() {
  var x = document.getElementById("snackbar");
  x.className = "showsnack";
  setTimeout(function(){ x.className = x.className.replace("showsnack", ""); }, 3000);
}