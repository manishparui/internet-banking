function mainLeft(){
	var left = document.getElementById("sidebar").offsetWidth;
	if (left <= 180) {
		document.getElementById("main").style.left = "180px";
	} else{
		document.getElementById("main").style.left = left + "px";
	}
	mainHeight();
	cr();
}

function mainHeight(){
	var h = Math.max(document.documentElement.clientHeight, window.innerHeight || 0);
	var x = h - 88; 
	document.getElementById("main").style.height = x + "px";
}

function SnapshotVisible() {
	document.getElementById("snap").style.color = "#f1f1f1";
	document.getElementById("acc").style.color = "#818181";
	document.getElementById("tff").style.color = "#818181";
	document.getElementById("pbb").style.color = "#818181";
	document.getElementById("for").style.color = "#818181";

	document.getElementById("snapshot").style.display = "block";
	document.getElementById("accounts").style.display = "none";
	document.getElementById("tf").style.display = "none";
	document.getElementById("pb").style.display = "none";
  	document.getElementById("forex").style.display = "none";
}

function AccountsVisible() {
	document.getElementById("snap").style.color = "#818181";
	document.getElementById("acc").style.color = "#f1f1f1";
	document.getElementById("tff").style.color = "#818181";
	document.getElementById("pbb").style.color = "#818181";
	document.getElementById("for").style.color = "#818181";

	document.getElementById("snapshot").style.display = "none";
	document.getElementById("accounts").style.display = "block";
	document.getElementById("tf").style.display = "none";
	document.getElementById("pb").style.display = "none";
  	document.getElementById("forex").style.display = "none";
}

function TFVisible() {
	document.getElementById("snap").style.color = "#818181";
	document.getElementById("acc").style.color = "#818181";
	document.getElementById("tff").style.color = "#f1f1f1";
	document.getElementById("pbb").style.color = "#818181";
	document.getElementById("for").style.color = "#818181";

	document.getElementById("snapshot").style.display = "none";
	document.getElementById("accounts").style.display = "none";
	document.getElementById("tf").style.display = "block";
	document.getElementById("pb").style.display = "none";
  	document.getElementById("forex").style.display = "none";
}

function PBVisible() {
	document.getElementById("snap").style.color = "#818181";
	document.getElementById("acc").style.color = "#818181";
	document.getElementById("tff").style.color = "#818181";
	document.getElementById("pbb").style.color = "#f1f1f1";
	document.getElementById("for").style.color = "#818181";

	document.getElementById("snapshot").style.display = "none";
	document.getElementById("accounts").style.display = "none";
	document.getElementById("tf").style.display = "none";
	document.getElementById("pb").style.display = "block";
  	document.getElementById("forex").style.display = "none";
}

function ForexVisible() {
	document.getElementById("snap").style.color = "#818181";
	document.getElementById("acc").style.color = "#818181";
	document.getElementById("tff").style.color = "#818181";
	document.getElementById("pbb").style.color = "#818181";
	document.getElementById("for").style.color = "#f1f1f1";
	
	document.getElementById("snapshot").style.display = "none";
	document.getElementById("accounts").style.display = "none";
	document.getElementById("tf").style.display = "none";
	document.getElementById("pb").style.display = "none";
  	document.getElementById("forex").style.display = "block";
}

function CusReload(){
	var url = window.location.href;
	if (url.search("snapshot") > 0 ) {
		SnapshotVisible();
	} else if (url.search("account") > 0 ) {
		AccountsVisible();
	} else if (url.search("tf") > 0 ) {
		TFVisible();
	} else if (url.search("pb") > 0 ) {
		PBVisible();
	} else if (url.search("forex") > 0 ) {
		ForexVisible();
	}
	cr();
}

function ModalOverlay(){
	document.getElementById("modal-overlay").style.display = "block";
}
function CloseModalOverlay(){
	document.getElementById("modal-overlay").style.display = "none";
}

function openPayeePopup(){
	document.getElementById("payeepopup").style.display = "block";
}
function closePayeePopup(){
	document.getElementById("payeepopup").style.display = "none";
}

function openNewAccountPopup(){
	document.getElementById("newaccountpopup").style.display = "block";
}
function closeNewAccountPopup(){
	document.getElementById("newaccountpopup").style.display = "none";
}

function home(){
	window.location.replace("home.jsp");
}
