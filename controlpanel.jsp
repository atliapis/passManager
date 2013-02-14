<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

	<style>
		img#dot{ position: absolute; }
	</style>

	<script src="js/jquery-latest.js"></script>

	<meta charset="UTF-8">
	<title>passManager</title>
	<link rel="icon" href="images/favicon.gif" type="image/x-icon"/>
	<!--[if lt IE 9]>
		<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->

	<link rel="shortcut icon" href="images/favicon.gif" type="image/x-icon"/> 
	<link rel="stylesheet" type="text/css" href="css/styles.css"/>
	<link rel="stylesheet" type="text/css" href="css/gallerystyle.css"/>
	<link type="text/css" href="css/css3.css" rel="stylesheet" />

	<script type="text/javascript" src=" https://ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.js"></script>
	<script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.0/jquery.min.js"></script>
	<script type="text/javascript" src="js/gallery.js"></script>

	<script>
		function hide(a){ document.getElementById(a).style.visibility ="hidden"; }
		function show(a){ document.getElementById(a).style.visibility ="visible"; }

		function hideit(a){ document.getElementById(a).style.display = 'none'; }
		function showit(a){ document.getElementById(a).style.display = 'block'; }
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
    <li><a href="home.jsp">Home</a></li>
    <li><a href="controlpanel.jsp" class="current">Control Panel</a></li>
    <li><a href="contact.jsp">Contact</a></li>
    <li><a href="about.jsp">About</a></li>
    <li><a href="logout">Logout</a></li>
    </ul>
    </nav>
	<!--end menu-->

    <!--end header-->
	</header>


   <!--start intro-->

   <%

   	HttpSession user_session = request.getSession(true);
	String connectionURL = "jdbc:mysql://localhost/passmanager";
	Connection connection = null;
	ResultSet rs;
       String email = new String("");
       String token = new String("");
	String session_email = (String)user_session.getAttribute("email");
       String session_token = (String)user_session.getAttribute("token");
       String AES_key = new String("passmanager727645300");
       boolean show_data = false;

	if(session_email == null || session_token == null){ response.sendRedirect(response.encodeRedirectURL("/passmanager/login.jsp")); }
	else{

		try {
                    
			 // Load the database driver
			Class.forName("com.mysql.jdbc.Driver");
			// Get a Connection to the database
			connection = DriverManager.getConnection(connectionURL, "passmanager", "passmanager727645300");
			//Add the data into the database
                        //SELECT AES_DECRYPT(email,'vaanasta@hotmail.compassmanager727645300'), token FROM users WHERE AES_DECRYPT(email,'vaanasta@hotmail.compassmanager727645300')='vaanasta@hotmail.com'
			String sql = "SELECT AES_DECRYPT(email,'" + session_email + AES_key + "'), token FROM users WHERE AES_DECRYPT(email,'" + session_email + AES_key + "')='" + session_email + "'";
			Statement s = connection.createStatement();
                        s.executeQuery (sql);
                        
			rs = s.getResultSet();
			while (rs.next ()){
				email=rs.getString("AES_DECRYPT(email,'" + session_email + AES_key + "')");
                                token=rs.getString("token");
				
                                if(email == null){ continue; }
                                
                                if(email.equals(session_email) && token.equals(session_token) ){

						

   %>
    <p align="right"><h7>Hi <% out.print((String)user_session.getAttribute("email"));%>!</h7></p>

		<%
		//HttpSession user_session = request.getSession(true);
		String session_new_pass_error = (String)user_session.getAttribute("new_pass_error");
		String session_new_img_pass_error = (String)user_session.getAttribute("new_img_pass_error");
		String session_old_pass_error = (String)user_session.getAttribute("old_pass_error");
		String session_pass_error = (String)user_session.getAttribute("pass_error");
		String session_change_pass_success = (String)user_session.getAttribute("change_pass_success");
		%>
	
   
   <h4>Manage your account:   </h4>   <h6 align="center"><% 
	if(session_change_pass_success != null){ out.print(session_change_pass_success); user_session.removeAttribute("change_pass_success"); }
	if(session_new_pass_error != null){ out.print(session_new_pass_error); user_session.removeAttribute("new_pass_error"); } 
	if(session_new_img_pass_error != null){ out.print(session_new_img_pass_error); user_session.removeAttribute("new_img_pass_error"); } 
	if(session_old_pass_error != null){ out.print(session_old_pass_error); user_session.removeAttribute("old_pass_error"); } 
	if(session_pass_error != null){ out.print(session_pass_error); user_session.removeAttribute("pass_error"); } 

%></h6><hr/>
   
<div align="center" width="80%">
	<table align="center" width="100%">
		<tr>
			<td><input type="button" value="Change Password" style="color:#8b1d8a; font-weight:bold;" onclick="showit('changepass'); hideit('changeimgpass'); hideit('deleteacc');" ></td>
			<td><input type="button" value="Change Image Password" style="color:#8b1d8a; font-weight:bold;" onclick="showit('changeimgpass'); hideit('changepass'); hideit('deleteacc');" ></td>
			<td><input type="button" value="Delete Account" style="color:#8b1d8a; font-weight:bold;" onclick="showit('deleteacc'); hideit('changepass'); hideit('changeimgpass');" ></td>
		</tr>
	</table>
</div>

<div id="deleteacc" align="center" width="90%" style="display:none;">
	<table align="center" width="60%">
		<tr><td><br/></td></tr>
		<tr>
			<td><h7>Are you sure you want to delete your account?</h7></td>
			<td><input type="button" value="No" style="color:#8b1d8a; font-weight:bold;" onclick="hideit('deleteacc')"></td>
			<form name="deleteaccount" method="get" action="delete_account">
			<td><input name="deleteaccount" type="submit" value="Yes" style="color:#8b1d8a; font-weight:bold;" ></td>
			</form>
		</tr>
	</table>
</div>

<div id="changepass" align="center" width="90%" style="display:none;" >

		<form name="changepass" method="post" action="change_password">

		<table align="center" width="550px" cellspacing="1" cellpadding="1" border="0">
  			<tr>
				<td colspan=3><h4>Please fill the form to change your password: </h4><hr/></td>
			</tr>
			<tr>
				<td width="20%"><b>Old Password:</b></td>
				<td width="25%"><input type="password" name="old_password" value=""></td>
				<td width="55%"><h6><% //if(session_old_pass_error != null){ out.print(session_old_pass_error); user_session.removeAttribute("old_pass_error"); } %></h6></td>
			</tr>
			<tr>
				<td><b>New Password:</b></td>
				<td><input type="password" name="new_password_1" value=""></td>
				<td><h6><% //if(session_new_pass_error != null){ out.print(session_new_pass_error); user_session.removeAttribute("new_pass_error"); } %></h6></td>
			</tr>
  			<tr>
  				<td><b>Retype Password:</b></td>
  				<td><input type="password" name="new_password_2" value=""></td>
  			</tr>
			<tr>
				<td></td>
				<td align="left"><input type="submit" name="changepass" value="Submit" id="submit"></td>
				<td></td>
			</tr>
		</table>
		</form>

</div>

<div id="changeimgpass" align="center" width="90%" style="display:none;" >

	<form name="changeimgpass" method="post" action="change_password">
	<table align="center" width="550px" cellspacing="1" cellpadding="1" border="0">
		<tr><br/></tr>
		<tr>
			<td width="450px" colspan="3"><h4>Please fill in your password</h4><hr/></td>
		</tr>
		<tr>
			<td width="20%"><b>Password:</b></td>
			<td width="25%"><input type="password" name="old_password" value=""></td>
			<td width="55%"><h6><% if(session_pass_error != null){ out.print(session_pass_error); user_session.removeAttribute("pass_error"); } %></h6></td>
		</tr>
		<tr><br/></tr>
		<tr>
			<td colspan="3"><h4>Pick an image and choose 4 points</h4><hr/></td>
		</tr>
	</table>


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
		document.getElementById("new_img_password").value = document.getElementById("new_img_password").value + pageCoords;

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


<table align="center" width="250px" cellspacing="1" cellpadding="1" border="0">
	<tr>
		<td><input type="hidden" name="new_img_password" id="new_img_password" value=""><h6><% if(session_new_img_pass_error != null){ out.print(session_new_img_pass_error); user_session.removeAttribute("new_img_pass_error"); } %></h6></td>
	</tr>
	<tr>
		<td width="40%"><input type="submit" name="change_image_pass" value="Submit" id="submit"></td>
	</tr>
</table>

</form>

</div>
   


<div class="holder_content1">
	<h4>Stored passwords</h4>
	<hr/>
	
   <%

						sql = "SELECT id, AES_DECRYPT(email,'" + session_email + AES_key + "'), AES_DECRYPT(title,'" + session_email + AES_key + "'), AES_DECRYPT(username,'" + session_email + AES_key + "'), AES_DECRYPT(password,'" + session_email + AES_key + "'), AES_DECRYPT(url,'" + session_email + AES_key + "') FROM user_data WHERE AES_DECRYPT(email,'" + session_email + AES_key + "')='" + session_email + "'";
						//out.println(sql);
						s.executeQuery(sql);
						rs = s.getResultSet();

						if(rs.next ()){
						rs.previous();

%>

<table cellspacing="1" cellpadding="1" border="0" width="100%">
  <tr>
  <td width="13%"><b>Title:</b></td>
  <td width="18%"><b>Username:</b></td>
  <td width="18%"><b>Password:</b></td>
  <td width="27%"><b>URL:</b></td>
  <td width="2%"></td>
  <td width="16%"></td>
  <td width="6%"></td>
  </tr>


<%

						while (rs.next ()){
							String id = rs.getString("id");
							String title = rs.getString("AES_DECRYPT(title,'" + session_email + AES_key + "')");
							String username = rs.getString("AES_DECRYPT(username,'" + session_email + AES_key + "')");
							String password = rs.getString("AES_DECRYPT(password,'" + session_email + AES_key + "')");
							String url = rs.getString("AES_DECRYPT(url,'" + session_email + AES_key + "')");
%>

  <tr>
  <form name="delete_entry" method="post" action="delete_entry">
  <td><input type="text" name="title" value="<%out.print(title);%>" disabled></td>
  <td><input type="text" name="username" value="<%out.print(username);%>" disabled></td>
  <td><input type="password" name="password" value="<%out.print(password);%>" disabled></td>
  <td><input type="url" name="url" value="<%out.print(url);%>" disabled></td>
  <td></td>
  <td><input type="button" name="delete_button" value="Delete" id="delete_button" style="color:#8b1d8a; font-weight:bold;" onclick="show('delete_msg<%out.print(id);%>'); show('delete_yes<%out.print(id);%>'); show('delete_no<%out.print(id);%>')"></td>
  <td id="delete_msg<%out.print(id);%>" style="visibility:hidden"><h7>Sure?</h7></td>
  <td><input type="submit" value="Yes " id="delete_yes<%out.print(id);%>" style="visibility:hidden; color:#8b1d8a; font-weight:bold;"></td>
  <td><input type="button" value="No " id="delete_no<%out.print(id);%>" style="visibility:hidden; color:#8b1d8a; font-weight:bold;" onclick="hide('delete_msg<%out.print(id);%>'); hide('delete_yes<%out.print(id);%>'); hide('delete_no<%out.print(id);%>');"></td>
  <td><input type="hidden" name="id" value="<%out.print(id);%>"></td>
  </form>
  </tr>


<%


							}
						}else{ %> <h6>No passwords stored yet.</h6> <% }


%>
</table>
<%

					show_data = true;
					break;
                                }
				    else{ response.sendRedirect(response.encodeRedirectURL("/passmanager/login.jsp")); }
			}
			rs.close ();
			s.close ();
			}catch(Exception e){
				System.out.println("Exception is ;"+e);
			}
			if(!show_data){
                     	 %> <div id="intro"> <h1 align="center">An error occurred while we were retrieving your passwords.</h1> </div> <%                                           
			}  

	}
   %>
</div>
	

   
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