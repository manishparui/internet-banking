function openPopUp(x){
	document.getElementById("popup").style.display = "block";
	var payeetable = document.getElementById("payeetable");
	document.getElementById("pacno").value = payeetable.rows[x.rowIndex].cells[0].innerHTML;
	document.getElementById("phname").value= payeetable.rows[x.rowIndex].cells[1].innerHTML;
	document.getElementById("pbname").value= payeetable.rows[x.rowIndex].cells[2].innerHTML;
}

function closePopUp(){
	document.getElementById("popup").style.display = "none";
}

function openAccStatement(){
	PBVisible();
}

function closeAccStatement(){
	document.getElementById("accstatement").style.display = "none";
}

function openAccReqClose(x){
	document.getElementById("accreqclose").style.display = "block";
	var y = x.parentNode.parentNode.parentNode.cells[1].innerHTML;
	document.getElementById("accreqcloseacno").innerHTML = y;
	document.getElementById("accreqcloseaccnojs").value = y;
}

function closeAccReqClose(){
	document.getElementById("accreqclose").style.display = "none";
}

function openChangePassword(){
	document.getElementById("chnagepass").style.display = "block";
}

function closeChangePassword(){
	document.getElementById("chnagepass").style.display = "none";
}

function openUpdateProfile(){
	var updTable = document.getElementById("updateProfileData");
	document.getElementById("uprrrName").value = updTable.rows[0].cells[0].innerHTML;
	document.getElementById("uprrrPhno").value = updTable.rows[0].cells[1].innerHTML;
	document.getElementById("uprrrEmail").value = updTable.rows[0].cells[2].innerHTML;
	document.getElementById("uprrrDob").value = updTable.rows[0].cells[3].innerHTML;
	document.getElementById("uprrrAddress").value = updTable.rows[0].cells[4].innerHTML;
	document.getElementById("updateprof").style.display = "block";
}

function closeUpdateProfile(){
	document.getElementById("updateprof").style.display = "none";
}