<%@page import="DAO.CustomerDAO"%>
<%@page import="DAO.TransactionDAO"%>
<%@page import="DAO.PayeeDAO"%>
<%@page import="DAO.AccountsDAO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="javax.websocket.Session"%>
<%@page import="nclass.MySQLConnector"%>
<%@page import="java.sql.Connection"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%
	response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
	response.setHeader("Pragma", "no-cache");
	response.setHeader("Expires", "0");

	if(session.getAttribute("uname") == null){
		response.sendRedirect("index.jsp");
	} else if(session.getAttribute("type").equals("a")) {
		session.removeAttribute("uname");
		session.invalidate();
		response.sendRedirect("index.jsp");
	} else {
%>
<% 
	String uname = session.getAttribute("uname").toString();
	Connection con = null;
	AccountsDAO adao = new AccountsDAO();
	TransactionDAO tdao = new TransactionDAO();
	CustomerDAO cdao = new CustomerDAO();
%>

<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="home/home.css">
	<link rel="stylesheet" type="text/css" href="common/messagebox.css">
	<link rel="stylesheet" type="text/css" href="home/comingsoon.css">
	<link rel="stylesheet" type="text/css" href="home/popup.css">
	<link rel="stylesheet" type="text/css" href="home/hovermenu.css">
	<link rel="stylesheet" type="text/css" href="common/customscrollbar.css">
	<link rel="stylesheet" type="text/css" href="common/credit.css">
	<link rel="stylesheet" type="text/css" href="common/fontawesome-free-5.7.2-web/css/all.min.css">
	<script src="home/home.js"></script>
	<script src="home/comingsoon.js"></script>
	<script type="text/javascript" src="home/popup.js"></script>
	<script type="text/javascript" src="common/common.js"></script>

	<title>home</title>
</head>
<body onresize="mainLeft(); mainHeight()" onload="mainLeft(); mainHeight()">

	<!--header-->
	<div class="header">
		<div class="home click" id="homelogofa" onclick="home()"><i class="fas fa-home"></i></div>
		<div class="acc-div">
			<img src="common/resources/m_avatar.png">
			<h3><%=session.getAttribute("uname") %></h3>
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
  		<a href="#account" id="acc" class="sidebar-a" onclick="AccountsVisible()"><i class="fas fa-user"></i> Accounts</a>
  		
  		<br>
  		<br>
  		<a href="#tf" id="tff" class="sidebar-a" onclick="TFVisible()"><i class="fas fa-money-bill-wave"></i>
  		Transfer Funds</a>
  		
  		<br>
  		<br>
  		<a href="#pb" id="pbb" class="sidebar-a" onclick="PBVisible()"><i class="fas fa-file-invoice"></i> Statement</a>
  		
  		<br>
  		<br>
  		<a href="#forex" id="for" class="sidebar-a" onclick="ForexVisible()"><i class="fas fa-dollar-sign"></i> Forex</a>
  		
  		<div class="cr">
  			<p id="cr" >This web application is developed by Manish Parui, Manpreet Singh, Adrita Majumder, Kushankur Das, Debyendu Ghosh, Masudur Rahaman as major project of BCA in the year of 2019 at Techno India Salt Lake.</p>
  		</div>
	</div>
	<!--sidebar-end-->

	<!--main-->
	<!--snapshot-->
	<div id="main" class="main">
		<div id="snapshot" class="container-temp">
			<div class="card last-trans">
				<div class="card-header">
					Last Five Transaction
				</div>
				<div class="card-body last-trans-body">
					<table class="striped-table">
						<tr>
							<th>Date Time</th>
							<th>From</th>
							<th>To</th>
							<th>Amount</th>
						</tr>
						<%
							ResultSet sbacnotrrs = adao.retrieveAcno(uname);
  							String acnotr = null;
  							while(sbacnotrrs.next()){
  								acnotr = sbacnotrrs.getString(1);
  								break;
  							}
  							sbacnotrrs.close();
  							int x5 = tdao.countData(acnotr);
  							if(x5 == 0){
  						%>
  								<tr><td colspan="4">You don't have any transaction yet.</td></tr>
  						<%		
  							} else{
								ResultSet transrs = tdao.retrive5Data(acnotr);
								while(transrs.next()){
						%>
									<tr>
										<td><%=transrs.getString("datetime") %></td>
										<td><%=transrs.getString("from") %></td>
										<td><%=transrs.getString("to") %></td>
										<td><%=transrs.getString("amount") %></td>
									</tr>
						<%
								}
								transrs.close();
							}
						%>

					</table>
				</div>
			</div>
			<div class="card balance">
				<div class="card-header">
					Balance
				</div>
				<div class="card-body balance-body">
					<%=adao.retrieveBalance(acnotr) %>
				</div>
			</div>

			<div class="card quick-request">
				<div class="card-header">
					Quick Action
				</div>
				<div class="card-body quick-request-body">
					<table class="striped-table">
						<tr><td class="click" onclick="openUpdateProfile()">Update Profile</td></tr>
						<tr><td class="click" onclick="openChangePassword()">Change Password</td></tr>
					</table>
				</div>
			</div>
		</div>
		
		<!--update-profile-->
		<table class="displaynone" id="updateProfileData">
			<tr>
		<%
			ResultSet updateprofrs = cdao.retrieveData(uname);
			while(updateprofrs.next()){
		%>
				<td><%=updateprofrs.getString("holdername") %></td>
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
				<form action="UpdateProfileServ" method="post">
					<div class="inputbox">
						<input type="text" name="uprrrUname" readonly value=<%=uname %>>
						<label>User Name</label>
					</div>
					<div class="inputbox">
						<input type="text" name="uprrrName" id="uprrrName" required>
						<label>Name</label>
					</div>
					<div class="inputbox">
						<input type="number" name="uprrrPhno" id="uprrrPhno" min="6000000000" max="9999999999" required>
						<label>Phone Number</label>
					</div>
					<div class="inputbox">
						<input type="email" name="uprrrEmail" id="uprrrEmail" required>
						<label>Email Address</label>
					</div>
					<div class="inputbox">
						<input type="date" name="uprrrDob" id="uprrrDob" required>
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
				<form action="ChangePassServ" method="post">
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
		<!--snapshot-end-->

		<!--accounts-->
		<div id="accounts" class="container">
			<div class="card accounts-lists">
				<div class="card-header">
					Savings Account
				</div>
				<div class="card-body accounts-lists-body">
					<table class="striped-table">
						<tr>
							<th>Status</th>
							<th>Account No.</th>
							<th>Balance</th>
							<th>Interest rate (%)</th>
							<th>Opening</th>
							<th>Setting</th>
						</tr>
						<%
  							int sbcount = adao.countData("sb", uname);
							if(sbcount == 0){
						%>
								<tr><td colspan="6">You don't have any Savings Account.</td></tr>
						<%	
							} else{
								ResultSet sbrs = adao.retriveData("sb", uname);
  								while (sbrs.next()){	
  						%>
  								<tr>
  									<td><%=sbrs.getString("status") %></td>
  									<td><%=sbrs.getString("acno") %></td>
  									<td><%=sbrs.getString("balance") %></td>
  									<td><%=sbrs.getString("rate") %></td>
  									<td><%=sbrs.getString("opening") %></td>
  									<td class="tooltip">
										<i class="fas fa-cog click"></i>
										<span class="tooltiptext">
											<span class="click" onclick="openAccStatement()">
												View Statement
											</span>
										</span>
									</td>
  								</tr>
  						<%		}
  								sbrs.close();
  							}
						%>
					</table>
				</div>
			</div>
			<div class="card accounts-lists">
				<div class="card-header">
					Fixed deposit
				</div>
				<div class="card-body accounts-lists-body">
					<table class="striped-table">
						<tr>
							<th>Status</th>
							<th>Account no.</th>
							<th>Balance</th>
							<th>Interest rate (%)</th>
							<th>No. of month</th>
							<th>Amount</th>
							<th>Expiry</th>
							<th>Setting</th>
						</tr>
						<%
  							int fdcount = adao.countData("fd", uname);
							if(fdcount == 0){
						%>
								<tr><td colspan="8">You don't have any Fixed deposit.</td></tr>
						<%	
							} else{
								ResultSet fdrs = adao.retriveData("fd", uname);
  								while (fdrs.next()){	
  						%>
  								<tr>
  									<td><%=fdrs.getString("status") %></td>
  									<td><%=fdrs.getString("acno") %></td>
  									<td><%=fdrs.getString("balance") %></td>
  									<td><%=fdrs.getString("rate") %></td>
  									<td><%=fdrs.getString("nomonth") %></td>
  									<td><%=fdrs.getString("installment") %></td>
  									<td><%=fdrs.getString("expiry") %></td>
  									<td class="tooltip">
										<i class="fas fa-cog click"></i>
										<span class="tooltiptext">
											<span class="click" onclick="openAccStatement()">
												View Statement
											</span>
											<%
												if(fdrs.getString("status").equals("active")){
											%>
													<br>
													<hr>
													<span class="click" onclick="openAccReqClose(this)">
														Close Account
													</span>
											<%	} %>
										</span>
									</td>
  								</tr>
  						<%		}
  								fdrs.close();
  							}
						%>
					</table>
				</div>
			</div>
			<div class="card accounts-lists">
				<div class="card-header">
					Recurring Deposit
				</div>
				<div class="card-body accounts-lists-body">
					<table class="striped-table">
						<tr>
							<th>Status</th>
							<th>Account no.</th>
							<th>Balance</th>
							<th>Interest rate (%)</th>
							<th>No. of month</th>
							<th>Installment amount</th>
							<th>Expiry</th>
							<th>Setting</th>
						</tr>
						<%
  							int rdcount = adao.countData("rd", uname);
							if(rdcount == 0){
						%>
								<tr><td colspan="8">You don't have any Recurring Deposit.</td></tr>
						<%	
							} else{
								ResultSet rdrs = adao.retriveData("rd", uname);
  								while (rdrs.next()){	
  						%>
  								<tr>
  									<td><%=rdrs.getString("status") %></td>
  									<td><%=rdrs.getString("acno") %></td>
  									<td><%=rdrs.getString("balance") %></td>
  									<td><%=rdrs.getString("rate") %></td>
  									<td><%=rdrs.getString("nomonth") %></td>
  									<td><%=rdrs.getString("installment") %></td>
  									<td><%=rdrs.getString("expiry") %></td>
  									<td class="tooltip">
										<i class="fas fa-cog click"></i>
										<span class="tooltiptext">
											<span class="click" onclick="openAccStatement()">
												View Statement
											</span>
											<%
												if(rdrs.getString("status").equals("active")){
											%>
													<br>
													<hr>
													<span class="click" onclick="openAccReqClose(this)">
														Close Account
													</span>
											<%	} %>
										</span>
									</td>
  								</tr>
  						<%		}
  							}
						%>
					</table>
				</div>
			</div>
			<button type="button" class="btn-ana" onclick="openNewAccountPopup()">Create new account</button>
		</div>
		
		<!--account-statement-->
		<div class="pop-overlay" id="accstatement">
			<div class="pop">
				<button type="button" class="pop-btn-right" onclick="closeAccStatement()">Cancel</button>
			</div>
		</div>
		<!--account-statement-end-->

		<!--account-request-close-->
		<div class="pop-overlay" id="accreqclose">
			<div class="pop">
				<p>Do you really want to close your account: <span id="accreqcloseacno"></span>?</p>
				<form action="AccCloseServ" method="post">
					<input id="accreqcloseaccnojs" type="hidden" name="accreqcloseaccno">
					<input class="pop-btn-left" type="submit" value="Yes">
				</form>
				<button type="button" class="pop-btn-right" onclick="closeAccReqClose()">Cancel</button>
			</div>
		</div>
		<!--account-request-close-end-->
		
		<!--new-account-popup-->
		<div id="newaccountpopup" class="pop-overlay">
			<div class="pop">
				<h2>New Account</h2>
				<form action="NewAccServ" method="post">
					<div class="inputbox">
						<label>Type</label><br><br>
						<select name="type">
							<option value="fd">Fixed deposit</option>
							<option value="rd">Recurring Deposit</option>
						</select>
					</div>
					<div class="inputbox">
						<label>Number of month</label><br><br>
						<select name="newacnomonth">
							<option value="6">6</option>
							<option value="12">12</option>
							<option value="18">18</option>
							<option value="24">24</option>
						</select>
					</div>
					<div class="inputbox">
						<label>Amount</label><br><br>
						<input type="number" name="newacamt" required>
						
					</div>
					<input type="hidden" name="uname" value=<%=uname %>>
					<input class="pop-btn-left" type="Submit" name="" value="Apply">
					<button type="button" class="pop-btn-right" onclick="closeNewAccountPopup()">Cancel</button>
				</form>
			</div>
		</div>
		<!--new-account-popup-end-->
		<!--accounts-end-->

		<!--transfer-funds-->
		<div id="tf" class="container">
			<div class="card lop">
				<div class="card-header">
					List of Payee
				</div>
				<div class="card-body lop-body">
					<table id="payeetable" class="striped-table">
						<tr>
							<th>Account No.</th>
							<th>Holder Name</th>
							<th>Bank Name</th>
							<th></th>
						</tr>
						<%
							PayeeDAO pdao = new PayeeDAO();
							int lopCount = pdao.countData(uname);
							if(lopCount == 0){
						%>
								<tr><td colspan="4">You don't have any payee.</td></tr>
						<%	
							} else{
								ResultSet loprs = pdao.retrieveData(uname);
								while(loprs.next()){
						%>
									<tr onclick="openPopUp(this)">
										<td><%=loprs.getString("acno")%></td>
										<td><%=loprs.getString("holdername")%></td>
										<td><%=loprs.getString("bankname")%></td>
										<td><button class="btn-lop-pay click">Pay</button></td>
									</tr>
						<%
								}
							}
						%>
					</table>
				</div>
			</div>
			<button type="button" class="btn-ana" onclick="openPayeePopup()">Add Payee</button>
		</div>
		
		<!--add-payee-popup-->
		<div id="payeepopup" class="pop-overlay">
			<div class="pop">
				<h2>New Payee</h2>
				<form action="AddPayeeServ" method="post">
					<div class="inputbox">
						<input type="text" name="payeeacno" required>
						<label>Account No.</label>
					</div>
					<div class="inputbox">
						<input type="text" name="payeehname" required>
						<label>Holader Name</label>
					</div>
					<div class="inputbox">
						<input type="text" name="payeebname" value="NA">
						<label>Bank Name</label>
					</div>
					<input type="hidden" name="payeeaddby" value=<%=uname %>>
					<input class="pop-btn-left" type="Submit" name="" value="Add">
					<button type="button" class="pop-btn-right" onclick="closePayeePopup()">Cancel</button>
				</form>
			</div>
		</div>
		<!--add-payee-popup-end-->
		
		<!--transfer-funds-popup-->
		<div id="popup" class="pop-overlay">
			<div class="pop">
				<h2>You are paying:</h2>
				<form action="FundTransferServ" method="post">
				<h3 class="h3">From:</h3>
					<div class="inputbox">
						<label>Account No.</label><br><br>
						<select name="hsbacno">
						<%
							ResultSet tfrs = adao.retrieveAcno(uname);
							while(tfrs.next()){
								String acnotff = tfrs.getString("acno");
						%>
							<option value=<%= tfrs.getString("acno") %>><%= tfrs.getString("acno") %></option>
						<%
							}
						%>
						</select>
					</div>
					<h3 class="h3">To:</h3>
					<div class="inputbox">
						<input id="pacno" type="text" name="pacno" readonly>
						<label>Account No.</label>
					</div>
					<div class="inputbox">
						<input id="phname" type="text" name="phname" readonly>
						<label>Holder Name</label>
					</div>
					<div class="inputbox">
						<input id="pbname" type="text" name="pbname" readonly>
						<label>Bank Name</label>
					</div>
					<div class="inputbox">
						<input id="pamount" type="text" name="pamount" required>
						<label>Amount</label>
					</div>
					<div class="inputbox">
						<input id="ppass" type="Password" name="ppass" required>
						<label>Password</label>
					</div>
					<input type="hidden" name="puname" value=<%=uname %>>
					<input class="pop-btn-left" type="Submit" name="" value="Pay">
					<button type="button" class="pop-btn-right" onclick="closePopUp()">Cancel</button>
				</form>
			</div>
		</div>
		<!--transfer-funds-popup-end-->
		<!--transfer-funds-end-->

		<!--statement-->
		<div id="pb" class="container">
		<%
			ResultSet allrs = adao.retrieveAllAcno(uname);
			while(allrs.next()){
				String acno = allrs.getString("acno");
				String type = allrs.getString("type");
		%>
				<div class="card stat" id="<%=acno %>">
					<div class="card-header">
						Account Number: <%=acno %>, Type: <%=type %>
					</div>
					<div class="card-body stat-body">
						<table class="striped-table">
							<tr>
								<th>Date - Time</th>
								<th>From (Account No.)</th>
								<th>To (Account No.)</th>
								<th>Amount</th>
								<th>Remarks</th>
							</tr>
							<%
								int x = tdao.countData(acno);
								if(x == 0){
							%>
									<tr><td colspan="5">You don't have any transaction.</td></tr>
							<%
								} else{
									ResultSet acnors = tdao.retriveData(acno);
									while(acnors.next()){
							%>
							<tr >
								<td><%=acnors.getString("datetime") %></td>
								<td><%=acnors.getString("from") %></td>
								<td><%=acnors.getString("to") %></td>
								<td><%=acnors.getString("amount") %></td>
								<td><%=acnors.getString("remarks") %></td>
							</tr>
							<%
									}
									acnors.close();		
								}
							%>
						</table>
					</div>
				</div>
		<%		
			}
			allrs.close();
		%>
		</div>
		<!--statement-end-->

		<!--forex-->
		<div id="forex" class="container">
			<div class="cs-middle">
				<h1>COMING SOON</h1>
				<p id="demo" style="font-size:30px"></p>
			</div>
		</div>
		<!--forex-end-->
	</div>
	<!--main-end-->


	
	<script type="text/javascript">CusReload();</script>
	<script type="text/javascript">cr();</script>
</body>
</html>
<%}%>