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
	document.getElementById("cus").style.color = "#818181";
	document.getElementById("acc").style.color = "#818181";
	document.getElementById("rep").style.color = "#818181";

	document.getElementById("snapshot").style.display = "block";
	document.getElementById("customer").style.display = "none";
	document.getElementById("account").style.display = "none";
	document.getElementById("report").style.display = "none";
}

function CustomerVisible() {
	document.getElementById("snap").style.color = "#818181";
	document.getElementById("cus").style.color = "#f1f1f1";
	document.getElementById("acc").style.color = "#818181";
	document.getElementById("rep").style.color = "#818181";

	document.getElementById("snapshot").style.display = "none";
	document.getElementById("customer").style.display = "block";
	document.getElementById("account").style.display = "none";
	document.getElementById("report").style.display = "none";
}

function AccountVisible() {
	document.getElementById("snap").style.color = "#818181";
	document.getElementById("cus").style.color = "#818181";
	document.getElementById("acc").style.color = "#f1f1f1";
	document.getElementById("rep").style.color = "#818181";

	document.getElementById("snapshot").style.display = "none";
	document.getElementById("customer").style.display = "none";
	document.getElementById("account").style.display = "block";
	document.getElementById("report").style.display = "none";
}

function ReportVisible() {
	document.getElementById("snap").style.color = "#818181";
	document.getElementById("cus").style.color = "#818181";
	document.getElementById("acc").style.color = "#818181";
	document.getElementById("rep").style.color = "#f1f1f1";

	document.getElementById("snapshot").style.display = "none";
	document.getElementById("customer").style.display = "none";
	document.getElementById("account").style.display = "none";
	document.getElementById("report").style.display = "block";
}

function ModalOverlay(){
	document.getElementById("modal-overlay").style.display = "block";
}

function CloseModalOverlay(){
	document.getElementById("modal-overlay").style.display = "none";
}

function CusReload(){
	var url = window.location.href;
	if (url.search("snapshot") > 0 ) {
		SnapshotVisible();
	} else if (url.search("account") > 0 ) {
		AccountVisible();
	} else if (url.search("customer") > 0 ) {
		CustomerVisible();
	} else if (url.search("report") > 0 ) {
		ReportVisible();
	}
	cr();
}

function home(){
	window.location.replace("admin.jsp");
}