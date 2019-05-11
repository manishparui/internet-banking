function openCsPopUp(x){
	document.getElementById("cspopup").style.display = "block";
	document.getElementById("csuname").value = x.parentNode.parentNode.parentNode.cells[1].innerHTML;
	document.getElementById("csname").value= x.parentNode.parentNode.parentNode.cells[2].innerHTML;
	document.getElementById("csphno").value= x.parentNode.parentNode.parentNode.cells[3].innerHTML;
	document.getElementById("csemail").value = x.parentNode.parentNode.parentNode.cells[4].innerHTML;
	document.getElementById("csdob").value= x.parentNode.parentNode.parentNode.cells[5].innerHTML;
	document.getElementById("csaddress").value= x.parentNode.parentNode.parentNode.cells[6].innerHTML;
}
function closeCsPopUp(){
	document.getElementById("cspopup").style.display = "none";
}


function openDeleteUser(x){
	document.getElementById("csdelpo").style.display = "block";
	var y = x.parentNode.parentNode.parentNode.cells[0].innerHTML;
	document.getElementById("closeuname").innerHTML = y;
	document.getElementById("csdeluname").value = y;
}
function closeDeleteUser(){
	document.getElementById("csdelpo").style.display = "none";
}


function openAsPopUp(x){
	document.getElementById("aspopup").style.display = "block";
	document.getElementById("asstat").value = x.parentNode.parentNode.parentNode.cells[0].innerHTML;
	document.getElementById("asacno").value = x.parentNode.parentNode.parentNode.cells[1].innerHTML;
	document.getElementById("ashname").value= x.parentNode.parentNode.parentNode.cells[2].innerHTML;
	document.getElementById("asbalance").value= x.parentNode.parentNode.parentNode.cells[3].innerHTML;
	document.getElementById("asrate").value = x.parentNode.parentNode.parentNode.cells[4].innerHTML;
}
function closeAsPopUp(){
	document.getElementById("aspopup").style.display = "none";
}
function openDeleteAc(x){
	document.getElementById("asdelpo").style.display = "block";
	var y = x.parentNode.parentNode.parentNode.cells[1].innerHTML;
	document.getElementById("asacnoo").innerHTML = y;
	document.getElementById("asdelacno").value = y;
}
function closeDeleteAc(){
	document.getElementById("asdelpo").style.display = "none";
}
function openNewAccountPopup(){
	document.getElementById("newaccountpopup").style.display = "block";
}
function closeNewAccountPopup(){
	document.getElementById("newaccountpopup").style.display = "none";
}
function openNewCusPopup(){
	document.getElementById("newcus").style.display = "block";
}
function closeNewCusPopup(){
	document.getElementById("newcus").style.display = "none";
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

function newAcCreation(){
	var type = document.getElementById("newactype").value;
	if(type == "fd"){
		document.getElementById("newacinstallmentdiv").style.display = "block";
		document.getElementById("newacnomdiv").style.display = "block";
		document.getElementById("newacbalancediv").style.display = "none";
	} else if(type == "rd"){
		document.getElementById("newacinstallmentdiv").style.display = "block";
		document.getElementById("newacnomdiv").style.display = "block";
		document.getElementById("newacbalancediv").style.display = "none";
	} else if(type == "sb"){
		document.getElementById("newacinstallmentdiv").style.display = "none";
		document.getElementById("newacnomdiv").style.display = "none";
	}
}