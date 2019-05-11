function transDetailsSearch() {
	var input, filter, table, tr, td1, td2, i, txtValue1, txtValue2;
	input = document.getElementById("transdetailsearchkey");
	filter = input.value;
	table = document.getElementById("transdetailtable");
	tr = table.getElementsByTagName("tr");
  
	for (i = 0; i < tr.length; i++) {
		td1 = tr[i].getElementsByTagName("td")[1];
	    td2 = tr[i].getElementsByTagName("td")[2];
	    
	    if (td1) {
	    	txtValue1 = td1.textContent || td1.innerText;
	    	txtValue2 = td2.textContent || td2.innerText;
	    	if ((txtValue1.indexOf(filter) > -1) || (txtValue2.indexOf(filter) > -1)) {
	    		tr[i].style.display = "";
	        
	    		if(txtValue1.indexOf(filter) > -1){
	    			td1.style.color = "green";
	    			td2.style.color = "black";
	    		} else if(txtValue2.indexOf(filter) > -1){
	    			td2.style.color = "green";
	    			td1.style.color = "black";
	    		}
	    	} else {
	    		tr[i].style.display = "none";
	    	}
	    }       
	}
}

function customerDetailsSearch(){
	var input, filter, table, tr, td1, td2, i, txtValue1, txtValue2;
	input = document.getElementById("customerdetailsearchkey");
	filter = input.value.toUpperCase();
	table = document.getElementById("customerList");
	tr = table.getElementsByTagName("tr");
  
	for (i = 0; i < tr.length; i++) {
		td1 = tr[i].getElementsByTagName("td")[1];
	    td2 = tr[i].getElementsByTagName("td")[2];
	    
	    if (td1) {
	    	txtValue1 = td1.textContent || td1.innerText;
	    	txtValue2 = td2.textContent || td2.innerText;
	    	if ((txtValue1.toUpperCase().indexOf(filter) > -1) || (txtValue2.toUpperCase().indexOf(filter) > -1)) {
	    		tr[i].style.display = "";
	        
	    		if(txtValue1.toUpperCase().indexOf(filter) > -1){
	    			td1.style.color = "green";
	    			td2.style.color = "black";
	    		} else if(txtValue2.toUpperCase().indexOf(filter) > -1){
	    			td2.style.color = "green";
	    			td1.style.color = "black";
	    		}
	    	} else {
	    		tr[i].style.display = "none";
	    	}
	    }       
	}
}

function totalDetailSearch(){
	var input, filter;
	input = document.getElementById("totalDetailSearchKey");
	filter = input.value.toUpperCase();
	
	if(filter != ""){
		document.getElementById("searchResult").style.display = "block";
		searchAndAppend("customerList", 1, "searchResultCustomer", filter);
		searchAndAppend("sbList", 2, "searchResultSb", filter);
		searchAndAppend("fdList", 2, "searchResultFd", filter);
		searchAndAppend("rdList", 2, "searchResultRd", filter);
	} else if(filter == "") {
		document.getElementById("searchResult").style.display = "none";
	}
}

function searchAndAppend(sourceTable, sourceIndex, tergetTable, filter){
	var stable, ttable, tr, i, td, txtValue, copy;
	stable = document.getElementById(sourceTable);
	ttable = document.getElementById(tergetTable);
	tr = stable.getElementsByTagName("tr");
	
	while (ttable.childElementCount > 1) {
		ttable.removeChild(ttable.lastChild);
	}
	
	for (i = 0; i < tr.length; i++) {
		td = tr[i].getElementsByTagName("td")[sourceIndex];
	    if (td) {
	    	txtValue = td.textContent || td.innerText;
	    	if (txtValue.toUpperCase().indexOf(filter) > -1) {
	    		copy = tr[i].cloneNode(true);
	    		ttable.appendChild(copy);
	    	}
	    }  
	}
}