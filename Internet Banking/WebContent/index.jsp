<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<link rel="stylesheet" type="text/css" href="index/index.css">
	<link rel="stylesheet" type="text/css" href="index/masud-login.css">
	<link rel="stylesheet" type="text/css" href="index/pur.css">
	<link rel="stylesheet" type="text/css" href="common/customscrollbar.css">
	<link rel="stylesheet" type="text/css" href="index/snackbar.css">
	<link rel="stylesheet" type="text/css" href="common/fontawesome-free-5.7.2-web/css/all.min.css">
	
	<script type="text/javascript" src="index/snackbar.js"></script>
	<script src="index/index.js"></script>

	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>welcome</title>
</head>
<body>
	<!--header-->
	<div class="header">
		<table class="menu">
			<tr>
				<td class="logo"></td>
				<td class="menu-item"><a href="">Explore Product</a></td>
				<td class="menu-item"><a href="">Make Payment</a></td>
				<td class="menu-item"><a href="">Personal Banking</a></td>
				<td class="menu-item" onclick="regctnr()">Register</td>
				<td class="login-btn-ctnr">
					<button class="btn" onclick="loginctnr()">Login</button>
				</td>
			</tr>
		</table>
	</div>
	<!--header-end-->

	<!--popup-login-->
	<div id="pul" class="pul">
		<div class="login-ctnr">
			<h2>Login</h2>
			<form action="LoginServ" method="post">
				<div class="inputbox">
					<input type="text" name="uname" required>
					<label>User Name</label>
				</div>
				<div class="inputbox">
					<input type="Password" name="pass" required>
					<label>Password</label>
				</div>
				<input class="btn btn-login" type="Submit" value="Login">
				<button class="btn btn-cancel" onclick="loginctnrcancel()">Cancel</button>
			</form>
		</div>
	</div>
	<!--popup-login-end-->

	<!--popup-registration-->
	<div id="pur" class="pur">
		<div class="pur-ctnr">
			<h2>New Account Registration</h2>
			<form action="RegServ" method="post">
				<div class="inputbox">
					<input type="text" name="regUname" placeholder="i.e. jhon" required>
					<label>User Name</label>
				</div>
				<div class="inputbox">
					<input type="Password" name="regPass" required>
					<label>Password</label>
				</div>
				<div class="inputbox">
					<input type="text" name="regName" placeholder="i.e. Jhon Doe" required>
					<label>Name</label>
				</div>
				<div class="inputbox">
					<input type="number" name="regPhno" placeholder="i.e. 9874563210" min="6000000000" max="9999999999" required>
					<label>Phone Number</label>
				</div>
				<div class="inputbox">
					<input type="email" name="regEmail" placeholder="i.e. jhon@mail.com" required>
					<label>Email Address</label>
				</div>
				<div class="inputbox">
					<input type="date" name="regDob" placeholder="i.e. 26-01-1997" required>
					<label>Birth Date</label>
				</div>
				<div class="inputbox">
					<input type="text" name="regAddress" placeholder="i.e. Address line 1, address line 2" required>
					<label>Address</label>
				</div>
				<input class="purbtn btn-register" type="Submit" name="" value="Register">
				<button class="purbtn btn-cancel" onclick="regctnrcancel()">Cancel</button>
			</form>
		</div>
	</div>
	<!--popup-registration-end-->

	<!--social-link-->
	<div class="social-link">
		<a href="https://www.facebook.com/"><i class="fab fa-facebook-square social-link-i"></i></a>
		<a href="https://twitter.com/"><i class="fab fa-twitter-square social-link-i"></i></a>
		<a href="https://www.instagram.com/"><i class="fab fa-instagram social-link-i"></i></a>		
		<a href="https://www.linkedin.com/"><i class="fab fa-linkedin social-link-i"></i></a>		
		<a href=""><i class="fab fa-google-play social-link-i"></i></a>		
	</div>
	<!--social-link-end-->

	<!--main-->
	<div class="body">

		<!--banner-->
		<div class="inbk">
			<div class="banner-login-btn-ctnr">
				<h1>Internet Banking</h1>
				<p>Banking at your finger tip</p>
				<button class="banner-btn" onclick="loginctnr()">Login</button>
				<button class="banner-btn" onclick="regctnr()">Register</button>
			</div>
		</div>
		<!--banner-end-->
	</div>
	<!--main-end-->
	
</body>
</html>