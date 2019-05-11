<%@page import="DAO.LoginDAO"%>
<%@page import="DAO.AdminDAO"%>
<%@page import="DAO.TransactionDAO"%>
<%@page import="DAO.AccountsDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="DAO.CustomerDAO"%>
<%@page import="java.sql.Connection"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "0");

	if(session.getAttribute("uname") == null){
		response.sendRedirect("index.jsp");
	} else if(session.getAttribute("type").equals("c")) {
		session.removeAttribute("uname");
		session.invalidate();
		response.sendRedirect("index.jsp");
	} else {
%>
<% 
	String uname = session.getAttribute("uname").toString();
	Connection con = null;
	CustomerDAO cdao = new CustomerDAO();
	AccountsDAO adao = new AccountsDAO();
	TransactionDAO tdao = new TransactionDAO();
	AdminDAO amdao = new AdminDAO();
	LoginDAO ldao = new LoginDAO();
%>

<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="admin/admin.css">
	<link rel="stylesheet" type="text/css" href="common/messagebox.css">
	<link rel="stylesheet" type="text/css" href="admin/comingsoon.css">
	<link rel="stylesheet" type="text/css" href="common/customscrollbar.css">
	<link rel="stylesheet" type="text/css" href="admin/popup.css">
	<link rel="stylesheet" type="text/css" href="admin/hovermenu.css">
	<link rel="stylesheet" type="text/css" href="common/credit.css">
	<link rel="stylesheet" type="text/css" href="common/fontawesome-free-5.7.2-web/css/all.min.css">
	<script type="text/javascript" src="admin/admin.js"></script>
	<script type="text/javascript" src="admin/popup.js"></script>
	<script type="text/javascript" src="admin/search.js"></script>
	<script type="text/javascript" src="common/common.js"></script>
	
	<title>admin home</title>
</head>
<body onresize="mainLeft(); mainHeight()" onload="mainLeft(); mainHeight()">

	<!--header-->
	<div class="header">
		<div class="home click" id="homelogofa" onclick="home()"><i class="fas fa-home"></i></div>
		<div class="acc-div">
			<img src="common/resources/m_avatar.png">
			<h3><%= session.getAttribute("uname") %></h3>
		</div>
		<button id="logout-btn" class="logout-btn" onclick="ModalOverlay()">Logout</button>
	</div>
	<!--header-end-->

	<!--modal-overlay-logout-message-box-->
	<div id="modal-overlay" class="modal-overlay">
		<div class="messagebox">
			<p>Do you really wanna logout?</p><br>
			<form action="LogoutServ" method="post">
				<input class="messagebox-btn-left" type="Submit" value="Logout">
			</form>
			<button class="messagebox-btn-right" onclick="CloseModalOverlay()">Cancel</button>
		</div>	
	</div>
	<!--modal-overlay-logout-message-box-end-->

	<!--sidebar-->
	<div id="sidebar" class="sidebar">
		<br>
		<br>
 		<a href="#snapshot" id="snap" class="sidebar-a-temp" onclick="SnapshotVisible()"><i class="fas fa-archive"></i> Snapshot</a>
 		
 		<br>
  		<br>
  		<a href="#customer" id="cus" class="sidebar-a" onclick="CustomerVisible()"><i class="fas fa-file-invoice"></i> Customer</a>

 		<br>
 		<br>
  		<a href="#account" id="acc" class="sidebar-a" onclick="AccountVisible()"><i class="fas fa-user"></i> Account</a>
  		
  		<br>
  		<br>
  		<a href="#report" id="rep" class="sidebar-a" onclick="ReportVisible()"><i class="fas fa-warehouse"></i> Transaction</a>
		
		<div class="cr">
  			<p id="cr" >This web application is developed by Manish Parui, Manpreet Singh, Adrita Majumder, Kushankur Das, Debyendu Ghosh, Masudur Rahaman as major project of BCA in the year of 2019 at Techno India Salt Lake.</p>
  		</div>
	</div>
	<!--sidebar-end-->

	<!--main-->
	<div id="main" class="main">

		<!--snapshot-->
		<div id="snapshot" class="container-temp">
			<div class="nofcWarper">
			<div class="card nofc">
				<div class="card-header">
					Customer
				</div>
				<div class="card-body nofb-body">
					<table class="striped-table">
						<tr>
							<th>Total Number</th>
							<td><%=cdao.countData() %></td>
						</tr>
					</table>
				</div>
			</div>

			<div class="card nofc">
				<div class="card-header">
					Accounts
				</div>
				<div class="card-body nofc-body">
					<table class="striped-table">
						<tr>
							<th>Total Number</th>
							<td><%=adao.countTotal() %></td>
						</tr>
						<tr>
							<th>Savings</th>
							<td><%=adao.countTotal("sb") %></td>
						</tr>
						<tr>
							<th>Fixed deposit</th>
							<td><%=adao.countTotal("fd") %></td>
						</tr>
						<tr>
							<th>Recurring Deposit</th>
							<td><%=adao.countTotal("rd") %></td>
						</tr>
					</table>
				</div>
			</div>

			<div class="card nofc">
				<div class="card-header">
					Quick Action
				</div>
				<div class="card-body nofa-body">
					<table class="striped-table">
						<tr><th class="click" onclick="openUpdateProfile()">Update Profile</th></tr>
						<tr><th class="click" onclick="openChangePassword()">Change Password</th></tr>
					</table>
				</div>
			</div>
			</div>
			
			<!--update-profile-end-->
			<table class="displaynone" id="updateProfileData">
				<tr>
			<%
				ResultSet updateprofrs = amdao.retrieveData();
				while(updateprofrs.next()){
			%>
					<td><%=updateprofrs.getString("name") %></td>
					<td><%=updateprofrs.getString("phno") %></td>
					<td><%=updateprofrs.getString("email") %></td>
					<td><%=updateprofrs.getString("dob") %></td>
					<td><%=updateprofrs.getString("address") %></td>
			<%
					break;
				}
				updateprofrs.close();
			%>
				</tr>
			</table>
			
			<div id="updateprof" class="pop-overlay">
			<div class="pop">
				<h2>Update Profile</h2>
				<form action="UpdateAdminServ" method="post">
					<div class="inputbox">
						<input type="text" name="uprrrUname" readonly value=<%=uname %>>
						<label>User Name</label>
					</div>
					<div class="inputbox">
						<input type="text" name="uprrrName" id="uprrrName" required>
						<label>Name</label>
					</div>
					<div class="inputbox">
						<input type="text" name="uprrrPhno" id="uprrrPhno" required>
						<label>Phone Number</label>
					</div>
					<div class="inputbox">
						<input type="text" name="uprrrEmail" id="uprrrEmail" required>
						<label>Email Address</label>
					</div>
					<div class="inputbox">
						<input type="text" name="uprrrDob" id="uprrrDob" required>
						<label>Birth Date</label>
					</div>
					<div class="inputbox">
						<input type="text" name="uprrrAddress" id="uprrrAddress" required>
						<label>Address</label>
					</div>
					<input class="pop-btn-left" type="Submit" value="Update">
					<button type="button" class="pop-btn-right" onclick="closeUpdateProfile()">Cancel</button>
				</form>
			</div>
		</div>
		<!--update-profile-end-->

		<!--change-password-popup-->
		<div id="chnagepass" class="pop-overlay">
			<div class="pop">
				<h2>Change Password</h2>
				<form action="UpdateAdminPassServ" method="post">
					<div class="inputbox">
						<input type="password" name="oldPass" required>
						<label>Current Password</label>
					</div>
					<div class="inputbox">
						<input type="password" name="newPass" required>
						<label>New Password</label>
					</div>
					<input type="hidden" name="cphjuname" value=<%=uname %>>
					<input class="pop-btn-left" type="Submit" value="Change">
					<button type="button" class="pop-btn-right" onclick="closeChangePassword()">Cancel</button>
				</form>
			</div>
		</div>
		<!--change-password-end-->
		
		<!--search-box-->
		<div class="search">
			<div class="search-container">
				<input type="text" placeholder="type user name here to search" id="totalDetailSearchKey" onkeyup="totalDetailSearch()">
			</div>
		</div>
		<!--search-box-end-->
		
		<!--search-result-->
			<div class="card accounts-lists displaynone" id="searchResult">
				<div class="card-header">
					Search Result
				</div>
				<div class="card-body accounts-lists-body">
					<p><strong>---------- Customer ----------</strong></p>
					<table class="striped-table" id="searchResultCustomer">
						<tr>
							<th>Status</th>
							<th>User Name</th>
							<th>Name</th>
							<th>Phone Number</th>
							<th>Email Address</th>
							<th>Birth Date</th>
							<th>Address</th>
							<th>Action</th>
						</tr>
					</table>
					<hr>
					<hr>
					<p><strong>---------- Savings account ----------</strong></p>
					<table class="striped-table" id="searchResultSb">
						<tr>
							<th>Status</th>
							<th>Account no.</th>
							<th>Holder Name</th>
							<th>Balance</th>
							<th>Interest rate</th>
							<th>Opening</th>
							<th>Setting</th>
						</tr>
					</table>
					<hr>
					<hr>
					<p><strong>---------- Fixed deposit account ----------</strong></p>
					<table class="striped-table" id="searchResultFd">
						<tr>
							<th>Status</th>
							<th>Account no.</th>
							<th>Holder Name</th>
							<th>Balance</th>
							<th>Interest Rate</th>
							<th>No of month</th>
							<th>Amount</th>
							<th>Expiry</th>
							<th>Setting</th>
						</tr>
					</table>
					<hr>
					<hr>
					<p><strong>---------- Recurring Deposit account ----------</strong></p>
					<table class="striped-table" id="searchResultRd">
						<tr>
							<th>Status</th>
							<th>Account no.</th>
							<th>Holder Name</th>
							<th>Balance</th>
							<th>Interest Rate</th>
							<th>No of month</th>
							<th>Amount</th>
							<th>Expiry</th>
							<th>Setting</th>
						</tr>
					</table>
				</div>
			</div>
			<!--search-result-end-->
		</div>
		<!--snapshot-end-->

		<!--customer-->
		<div id="customer" class="container">
			<!--search-box-->
			<div class="search">
				<div class="search-container">
					<input type="text" placeholder="type user name or name here to search" id="customerdetailsearchkey" onkeyup="customerDetailsSearch()">
				</div>
			</div>
			<!--search-box-end-->
			
			<div class="card accounts-lists">
				<div class="card-header">
					List of Customer
				</div>
				<div class="card-body accounts-lists-body">
					<div>
						<table class="striped-table" id="customerList">
							<tr>
								<th>Status</th>
								<th>User Name</th>
								<th>Name</th>
								<th>Phone Number</th>
								<th>Email Address</th>
								<th>Birth Date</th>
								<th>Address</th>
								<th>Action</th>
							</tr>
							<%
								ResultSet csrs = cdao.retrieveData();
								while(csrs.next()){
							%>
								<tr>
									<td><%=csrs.getString("status") %></td>
									<td><%=csrs.getString("uname") %></td>
									<td><%=csrs.getString("holdername") %></td>
									<td><%=csrs.getString("phno") %></td>
									<td><%=csrs.getString("email") %></td>
									<td><%=csrs.getString("dob") %></td>
									<td><%=csrs.getString("address") %></td>
									<td class="tooltip">
										<i class="fas fa-cog click"></i>
										<span class="tooltiptext">
											<span class="click" onclick="openCsPopUp(this)">Update</span>
											<%
												if(csrs.getString("status").equals("active")){
											%>
													<br>
													<hr>
													<span class="click" onclick="openDeleteUser(this)">Delete</span>
											<%	} %>
										</span>
									</td>
								</tr>
							<%		
								}
							%>
						</table>
					</div>
				</div>
			</div>
			<button type="button" class="btn-ana" onclick="openNewCusPopup()">New Customer</button>
		</div>

		<!--action-update-popup-->
		<div class="pop-overlay" id="cspopup">
			<div class="pop">
				<h2>Update Customer</h2>
				<form action="UpdateCusServ" method="post">
					<div class="inputbox">
						<input id="csuname" type="text" name="upUname" readonly>
						<label>User name</label>
					</div>
					<div class="inputbox">
						<input id="csname" type="text" name="upName" required>
						<label>Name</label>
					</div>
					<div class="inputbox">
						<input id="csphno" type="number" name="upPhno" min="6000000000" max="9999999999" required>
						<label>Phone number</label>
					</div>
					<div class="inputbox">
						<input id="csemail" type="email" name="upEmail" required>
						<label>Email address</label>
					</div>
					<div class="inputbox">
						<input id="csdob" type="date" name="upDob" required>
						<label>Birth date</label>
					</div>
					<div class="inputbox">
						<input id="csaddress" type="text" name="upAddress" required>
						<label>Address</label>
					</div>
					<input class="pop-btn-left" type="Submit" name="" value="Update">
					<button type="button" class="pop-btn-right" onclick="closeCsPopUp()">Cancel</button>
				</form>
			</div>
		</div>
		<!--action-update-popup-end-->
		<!--action-delete-popup-->
		<div class="pop-overlay" id="csdelpo">
			<div class="pop">
				<p>Do you really want to delete user: <span id="closeuname"></span>?</p>
				<form action="DelCusServ" method="post">
					<input id="csdeluname" type="hidden" name="csdeluname">
					<input class="pop-btn-left" type="Submit" name="" value="Delete">
					<button type="button" class="pop-btn-right" onclick="closeDeleteUser()">Cancel</button>
				</form>
			</div>
		</div>
		<!--action-delete-popup-end-->
		<!--new-cus-->
		<div id="newcus" class="pop-overlay">
			<div class="pop">
				<h2>New Customer</h2>
				<form action="NewCusServ" method="post">
					<div class="inputbox">
						<input type="text" name="regUname" required>
						<label>User Name</label>
					</div>
					<div class="inputbox">
						<input type="password" name="regPass" required>
						<label>Password</label>
					</div>
					<div class="inputbox">
						<input type="text" name="regName" required>
						<label>Name</label>
					</div>
					<div class="inputbox">
						<input type="number" min="6000000000" max="9999999999" name="regPhno" required>
						<label>Phone Number</label>
					</div>
					<div class="inputbox">
						<input type="email" name="regEmail" required>
						<label>Email Address</label>
					</div>
					<div class="inputbox">
						<label>Birth Date</label><br><br>
						<input type="date" name="regDob" required>
					</div>
					<div class="inputbox">
						<input type="text" name="regAddress" required>
					<label>Address</label>
					</div>
					<input class="pop-btn-left" type="Submit" name="" value="Create">
					<button type="button" class="pop-btn-right" onclick="closeNewCusPopup()">Cancel</button>
				</form>
			</div>
		</div>
		<!--new-cus-end-->
		<!--customer-end-->

		<!--accounts-->
		<div id="account" class="container">
			<!--sb-->
			<div class="card accounts-lists">
				<div class="card-header">
					Savings
				</div>
				<div class="card-body accounts-lists-body">
					
						<table class="striped-table" id="sbList">
							<tr>
								<th>Status</th>
								<th>Account no.</th>
								<th>Holder Name</th>
								<th>Balance</th>
								<th>Interest rate</th>
								<th>Opening</th>
								<th>Setting</th>
							</tr>
							<%
								ResultSet sbrs = adao.retrieveAllAccount("sb");
								while(sbrs.next()){
							%>
								<tr>
									<td><%=sbrs.getString("status") %></td>
									<td><%=sbrs.getString("acno") %></td>
									<td><%=sbrs.getString("uname") %></td>
									<td><%=sbrs.getString("balance") %></td>
									<td><%=sbrs.getString("rate") %></td>
									<td><%=sbrs.getString("opening") %></td>
									<td class="tooltip">
										<i class="fas fa-cog click"></i>
										<span class="tooltiptext">
											<span class="click" onclick="openAsPopUp(this)">Update Account</span>
											<%
												if(sbrs.getString("status").equals("active")){
											%>
													<br>
													<hr>
													<span class="click" onclick="openDeleteAc(this)">Close Account</span>
											<%	} %>
										</span>
									</td>
								</tr>
							<%	
								}
							%>
						</table>
					
				</div>
			</div>
			<!--sb-end-->

			<!--fd-->
			<div class="card accounts-lists">
				<div class="card-header">
					Fixed deposit
				</div>
				<div class="card-body accounts-lists-body">
					
						<table class="striped-table" id="fdList">
							<tr>
								<th>Status</th>
								<th>Account no.</th>
								<th>Holder Name</th>
								<th>Balance</th>
								<th>Interest Rate</th>
								<th>No of month</th>
								<th>Amount</th>
								<th>Expiry</th>
								<th>Setting</th>
							</tr>
							<%
								ResultSet fdrs = adao.retrieveAllAccount("fd");
								while(fdrs.next()){
							%>
								<tr>
									<td><%=fdrs.getString("status") %></td>
									<td><%=fdrs.getString("acno") %></td>
									<td><%=fdrs.getString("uname") %></td>
									<td><%=fdrs.getString("balance") %></td>
									<td><%=fdrs.getString("rate") %></td>
									<td><%=fdrs.getString("nomonth") %></td>
									<td><%=fdrs.getString("installment") %></td>
									<td><%=fdrs.getString("expiry") %></td>
									<td class="tooltip">
										<i class="fas fa-cog click"></i>
										<span class="tooltiptext">
											<span class="click" onclick="openAsPopUp(this)">Update Account</span>
											<%
												if(fdrs.getString("status").equals("active")){
											%>
													<br>
													<hr>
													<span class="click" onclick="openDeleteAc(this)">Close Account</span>
											<%	} %>
										</span>
									</td>
								</tr>
							<%	
								}
								fdrs.close();
							%>
						</table>
				</div>
			</div>
			<!--fd-end-->

			<!--rd-->
			<div class="card accounts-lists">
				<div class="card-header">
					Recurring Deposit
				</div>
				<div class="card-body accounts-lists-body">
					<div>
						<table class="striped-table" id="rdList">
							<tr>
								<th>Status</th>
								<th>Account no.</th>
								<th>Holder Name</th>
								<th>Balance</th>
								<th>Interest Rate</th>
								<th>No of month</th>
								<th>Amount</th>
								<th>Expiry</th>
								<th>Setting</th>
							</tr>
							<%
								ResultSet rdrs = adao.retrieveAllAccount("rd");
								while(rdrs.next()){
							%>
								<tr>
									<td><%=rdrs.getString("status") %></td>
									<td><%=rdrs.getString("acno") %></td>
									<td><%=rdrs.getString("uname") %></td>
									<td><%=rdrs.getString("balance") %></td>
									<td><%=rdrs.getString("rate") %></td>
									<td><%=rdrs.getString("nomonth") %></td>
									<td><%=rdrs.getString("installment") %></td>
									<td><%=rdrs.getString("expiry") %></td>
									<td class="tooltip">
										<i class="fas fa-cog click"></i>
										<span class="tooltiptext">
											<span class="click" onclick="openAsPopUp(this)">Update Account</span>
											<%
												if(rdrs.getString("status").equals("active")){
											%>
													<br>
													<hr>
													<span class="click" onclick="openDeleteAc(this)">Close Account</span>
											<%	} %>
										</span>
									</td>
								</tr>
							<%	
								}
								rdrs.close();
							%>
						</table>
					</div>
				</div>
			</div>
			<!--rd-end-->
			<button type="button" class="btn-ana" onclick="openNewAccountPopup()">Create new account</button>
		</div>
			
			<!--account-update-popup-->
			<div class="pop-overlay" id="aspopup">
				<div class="pop">
					<h2>Account Update</h2>
					<form action="UpdateAccServ" method="post">
						<div class="inputbox">
							<input id="asacno" type="text" name="asacno" readonly>
							<label>Account No.</label>
						</div>
						<div class="inputbox">
							<input id="asstat" type="text" name="asstat" required>
							<label>Status</label>
						</div>
						<div class="inputbox">
							<input id="ashname" type="text" name="asuname" readonly>
							<label>User Name</label>
						</div>
						<div class="inputbox">
							<input id="asbalance" type="text" name="asbalance" required>
							<label>Balance</label>
						</div>
						<div class="inputbox">
							<input id="asrate" type="text" name="asrate" required>
							<label>Rate</label>
						</div>
						<input class="pop-btn-left" type="Submit" value="Update">
						<button type="button" class="pop-btn-right" onclick="closeAsPopUp()">Cancel</button>
					</form>
				</div>
			</div>
			<!--account-update-popup-end-->

			<!--action-delete-popup-->
			<div class="pop-overlay" id="asdelpo">
				<div class="pop">
					<p>Do you really want to delete account: <span id="asacnoo"></span>?</p>
					<form action="DelAccServ" method="post">
						<input id="asdelacno" type="hidden" name="asdelacno">
						<input class="pop-btn-left" type="Submit" value="Close">
						<button type="button" class="pop-btn-right" onclick="closeDeleteAc()">Cancel</button>
					</form>
				</div>
			</div>
			<!--action-delete-popup-end-->
			
			<!--new-account-popup-->
			<div id="newaccountpopup" class="pop-overlay">
				<div class="pop">
					<h2>New Account</h2>
					<form action="NewAccAdminServ" method="post">
						<div class="inputbox">
							<label>Account type</label><br><br>
							<select id="newactype" name="newactype" onchange="newAcCreation()">
								<option value="sb">Savings</option>
								<option value="fd">Fixed deposit</option>
								<option value="rd">Recurring Deposit</option>
							</select>
						</div>
						<div class="inputbox">
							<label>User Name</label><br><br>
							<select name="newacuname">
							<%
								ResultSet activeCusUnamers = ldao.activeCusUname();
								while(activeCusUnamers.next()){
							%>
									<option value=<%=activeCusUnamers.getString(1) %>><%=activeCusUnamers.getString(1) %></option>
							<%
								}
								activeCusUnamers.close();
							%>
							</select>
						</div>
						<div class="inputbox" id="newacbalancediv">
							<input id="newacbalance" type="number" name="newacbalance" value="2000" required>
							<label>Balance</label>
						</div>
						<div class="inputbox">
							<input id="newacrate" type="number" name="newacrate" value="5" required>
							<label>Interest rate (%)</label>
						</div>
						<div class="displaynone inputbox" id="newacinstallmentdiv">
							<input type="number" name="newacamt" value="0" required>
							<label>Amount</label>
						</div>
						<div class="displaynone inputbox" id="newacnomdiv">
							<input type="number" name="newacnomonth" value="0" required>
							<label>No of Month</label>
						</div>
						<input class="pop-btn-left" type="Submit" value="Create">
						<button type="button" class="pop-btn-right" onclick="closeNewAccountPopup()">Cancel</button>
					</form>
				</div>
			</div>
			<!--new-account-popup-end-->
		<!--accounts-end-->

		<!--report-->
		<div id="report" class="container">
			<!--search-box-->
			<div class="search">
				<div class="search-container">
					<input type="text" placeholder="type account number here to search" id="transdetailsearchkey" onkeyup="transDetailsSearch()">
				</div>
			</div>
			<!--search-box-end-->
			
			<div class="card accounts-lists">
				<div class="card-header">
					Transaction Details
				</div>
				<div class="card-body accounts-lists-body">
					<table class="striped-table" id="transdetailtable">
						<tr>
							<th>Date - Time</th>
							<th>From (Account No.)</th>
							<th>To (Account No.)</th>
							<th>Amount</th>
							<th>Remarks</th>
						</tr>
						<%
							ResultSet alltranrs = tdao.retriveAllData();
							while(alltranrs.next()){
						%>
								<tr>
									<td><%=alltranrs.getString("datetime") %></td>
									<td><%=alltranrs.getString("from") %></td>
									<td><%=alltranrs.getString("to") %></td>
									<td><%=alltranrs.getString("amount") %></td>
									<td><%=alltranrs.getString("remarks") %></td>
								</tr>
						<%
							}
							alltranrs.close();
						%>
						
					</table>
				</div>
			</div>
		</div>
		<!--report-end-->
	</div>
	<!--main-end-->

	<script type="text/javascript">CusReload();</script>
	<script type="text/javascript">cr();</script>
</body>
</html>
<%}%>