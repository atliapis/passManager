<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta charset="UTF-8">
	<title>passManager</title>
	<link rel="icon" href="images/favicon.gif" type="image/x-icon"/>
	<!--[if lt IE 9]>
		<script src="https://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->

	<link rel="shortcut icon" href="images/favicon.gif" type="image/x-icon"/> 
	<link rel="stylesheet" type="text/css" href="css/styles.css"/>
	<link type="text/css" href="css/css3.css" rel="stylesheet" />
	<script type="text/javascript" src=" https://ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.js"></script>
	<script type="text/javascript" src="js/jquery.pikachoose.js"></script>
	<script language="javascript">

	$(document).ready(
		function (){
			$("#pikame").PikaChoose();
	});
	</script>
	
</head>

<body>
<!--start container-->
    <div id="container">

    <!--start header-->

    <header>
 
    <!--start logo-->
    <a href="#" id="logo"><img src="images/logo.png" width="169" height="105" alt="logo"/></a>    

	<!--end logo-->
	
   <!--start menu-->

	<nav>
    <ul>
    <li><a href="login.jsp">Login</a></li>
    <li><a href="" class="current">Register</a></li>
    <li><a href="contact.jsp">Contact</a></li>
    <li><a href="about.jsp">About</a></li>
    </ul>
    </nav>
	<!--end menu-->
	

    <!--end header-->
	</header>


   <!--start intro-->

   <div id="intro">
   
   <div class="group_bannner_right">
   
   <table>
   <td width="360px">
   
   <h4>Please enter your personal data</h4>
	<hr/>
	
    <script type="text/javascript">
		var RecaptchaOptions = { theme : 'blackglass' };
	</script>

<form name="registrationform" method="post" action="register">

<%
	HttpSession user_session = request.getSession(true);
	String session_email_error = (String)user_session.getAttribute("email_error");
	String session_password_error = (String)user_session.getAttribute("password_error");
	String session_recaptcha_error = (String)user_session.getAttribute("recaptcha_error");
%>


<table align="left" width="550px" cellspacing="1" cellpadding="1" border="0">
  <tr>
  <td colspan=2></td>
  </tr>
  <tr>
  <td width="10%">e-mail:</td>
  <td width="30%"><input type="email" name="email" value=""></td>
  <td width="60%"><h6><% if(session_email_error != null){ out.print(session_email_error); user_session.removeAttribute("email_error"); } %></h6></td>
  </tr>
  <tr>
  <td>Password:</td>
  <td><input type="password" name="pass" value=""></td>
  <td><h6><% if(session_password_error != null){ out.print(session_password_error); user_session.removeAttribute("password_error"); } %></h6></td>
  </tr>
  <tr>
  <td>Retype Password:</td>
  <td><input type="password" name="pass2" value=""></td>
  </tr>
  <tr>
  <td align="left" colspan=2>
  	<script type="text/javascript" src="https://www.google.com/recaptcha/api/challenge?k=6LeehNgSAAAAAHnQE0GJGjLn2w8Hbqx_1450PpkX"></script>

  </td>
  <td><h6><% if(session_recaptcha_error != null){ out.print(session_recaptcha_error); user_session.removeAttribute("recaptcha_error"); } %></h6></td>
  </tr>
  <tr>
  <td></td>
  <td align="left" colspan=1><input type="submit" name="Register" value="Register" id="submit"></td>
  </tr>
</table>

</td>
</table>
   </div>
   
   <header class="group_bannner_left">
   <hgroup>
   <h1>passManager</h1>
   <h2>security comes first</h2>
   </hgroup>
   </header>
   </div>
   <!--end intro-->

   
   <!--start holder-->


    </div>
    <!--end holder-->

   
   
    </div>
   <!--end container-->
   
   <!--start footer-->
   <footer>
   <div class="container">  
   <div id="FooterTwo"> © 2013 passManager </div>
   <div id="FooterTree"> This is a <a href="http://texwww.wordpress.com">texwww</a> term project, <a href="http://www.inf.uth.gr">UTH</a>   </div> 
   </div>
   </footer>
   <!--end footer-->

</body>
</html>