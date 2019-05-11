function cr(){
	var x = String.fromCharCode(77, 97, 110, 105, 115, 104);
	var y = document.getElementById("cr").textContent;

	if(y.search(x) <= 0){
		window.location.replace("./common/error");
	}
}