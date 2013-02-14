<!doctype html>  
<head>

<style>
	img#dot{ position: absolute; }
</style>

<script src="js/jquery-latest.js"></script>

<meta charset="UTF-8">
<title>passManager</title>
<link rel="icon" href="images/favicon.gif" type="image/x-icon"/>

<!--[if lt IE 9]>
	<script src="https://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
<![endif]-->

<link rel="shortcut icon" href="images/favicon.gif" type="image/x-icon"/> 
<link rel="stylesheet" type="text/css" href="css/styles.css"/>
<link rel="stylesheet" type="text/css" href="css/gallerystyle.css"/>
<link type="text/css" href="css/css3.css" rel="stylesheet" />

<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
<script type="text/javascript" src="js/gallery.js"></script>

<script type="text/javascript" src="js/jquery.pikachoose.js"></script>
<script language="javascript">
	$(document).ready(
		function (){ $("#pikame").PikaChoose(); }
	);
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
		<li><a href="#" class="current">Login</a></li>
		<li><a href="register.jsp">Register</a></li>
		<li><a href="contact.jsp">Contact</a></li>
		<li><a href="about.jsp">About</a></li>
	</ul>
	</nav>

	<!--end menu-->
	
	</header>

	<!--start intro-->
	<div id="intro">


<header class="group_bannner_right">

  <!-- Slideshow HTML -->
  <div id="slideshow">
	
    <div id="slidesContainer">
	
      <div class="slide">
        <h2>World Map</h2>
        <p><img src="img/World_Map.jpg" width="715" height="415" id="click"></p>
      </div>
        <div class="slide">
        <h2>Nebula</h2>
        <p><img src="img/Nebula.jpg" width="715" height="415" id="click"></p>
      </div>
        <div class="slide">
        <h2>Periodic Table</h2>
        <p><img src="img/periodic.jpg" width="715" height="415" id="click"></p>
      </div>
        <div class="slide">
        <h2>Lightning</h2>
        <p><img src="img/Night.jpg" width="715" height="415" id="click"><script>
		function getOffset( el ) {
    			var _x = 0;
    			var _y = 0;
    			while( el && !isNaN( el.offsetLeft ) && !isNaN( el.offsetTop ) ) {
        			_x += el.offsetLeft - el.scrollLeft;
       			_y += el.offsetTop - el.scrollTop;
        			el = el.offsetParent;
    			}
    			return { top: _y, left: _x };
		}

		function pad(num, size) {
    		var s = num+"";
    		while (s.length < size) s = "0" + s;
    		return s;
		}


    		$("img#click").click(function(e){
		var imgX = getOffset( this ).left;
		var imgY = getOffset( this ).top;
		var X = e.clientX - imgX - 29;
		var Y = e.clientY - imgY;

		var pageCoords = pad(X,3) + "" + pad(Y,3);
		document.getElementById("img_password").value = document.getElementById("img_password").value + pageCoords;

		var img = $('<img>');
		img.css('top', Y + 59 - 7);
        	img.css('left', X - 7);
        	img.attr('src', 'images/dot.png');
		img.attr('id', 'dot');
        	img.appendTo('#slidesContainer');


    		});
 
       </script></p>
        <p> 
      </div>
    </div>
  </div>
   </header>

   
   <div class="group_bannner_left">
   <hgroup>
   <h4 style="display:inline">Please login: </h4> 
   <h6>
   <%
	HttpSession user_session = request.getSession(true);
	String session_login_error = (String)user_session.getAttribute("login_error");
	if((session_login_error != null) && (session_login_error.equals("true"))){ out.print("Invalid  email or password"); user_session.removeAttribute("login_error"); }
   %>
   </h6>



	<hr/>
    <form id="loginForm" name="loginform" method="post" action="login" target="_parent">
    
    <table align="center" width="100%" cellspacing="1" cellpadding="1" border="0">
<tr><td colspan=2></td></tr>

	<tr>
		<td width="25%">e-mail</td>
		<td width="75%"><input type="email" name="email" value=""></td>
	</tr>
	<tr>
		<td>Password</td>
		<td><input type="password" name="password" value=""></td>
	</tr>
	<tr>
		<td></td>
		<td><input type="submit" name="Submit" value="Log in" id="submit"></td>
	</tr>
	<tr>
        	<td></td>
		<td>New user? <a target="_top" href="register.jsp" >Register</a></td>
	</tr>
	<tr>
		<td></td>
		<td><input type="hidden" name="img_password" value="" id="img_password"></td>
	</tr>
	</table>
	</form>
   </hgroup>
   </div>
   

   </div>
   <!--end intro-->

   
   <!--start holder-->

   <div class="holder_content1">
    <section class="group4">
   <h3>How it works:</h3>
   	<div class="pikachoose">
	<ul id="pikame" >
		<li><img src="images/screen1.png" width="500" height="250"  alt="picture"/></a><span>Step 1</span></li>
		<li><img src="images/screen2.png" width="500" height="250" alt="picture"/></a><span>Step 2</span></li>
		<li><img src="images/screen3.png" width="500" height="250" alt="picture"/></a><span>Step 3</span></li>
		<li><img src="images/screen4.png" width="500" height="250" alt="picture"/></a><span>Step 4</span></li>
	   </ul>
       </div>

	</section>


       
   <section class="group5">
   <h3>4 Simple Steps</h3>
   <br>

    <dl>
		<dt><span class="purple">1.</span>Register</dt>
		<dd>- as simple as it sounds</dd>
		<dt><span class="purple">2.</span>Log in</dt>
		<dd>- using image-password or with the conventional way</dd>
        <dt><span class="purple">3.</span> Store your passwords</dt>
		<dd>- type in full site url, username & password, store them</dd>
		<dt><span class="purple">4.</span> Retrieve your stored passwords</dt>
		<dd>- copy password & click the link button to get redirected</dd>
	</dl>
	</section>

   
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

    	

   </body></html>
