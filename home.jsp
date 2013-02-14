<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta charset="UTF-8">
	<title>passManager</title>
	
	<link rel="icon" href="images/favicon.gif" type="image/x-icon"/>
	<!--[if lt IE 9]>
		<script src="http://html5shiv.googlecode.com/svn/trunk/html5.js"></script>
	<![endif]-->

	<link rel="shortcut icon" href="images/favicon.gif" type="image/x-icon"/> 
	<link rel="stylesheet" type="text/css" href="css/styles.css"/>
	<link type="text/css" href="css/css3.css" rel="stylesheet" />
	<script type="text/javascript" src=" https://ajax.googleapis.com/ajax/libs/jquery/1.6/jquery.js"></script>
	
	<script src="js/generator.js"></script>

<script type="text/javascript" src="ZeroClipboard.js"></script>
<script language="JavaScript">
////copy to clip
    var clip = null;
 
   function $(id) { return document.getElementById(id); }
 
   function init()
   {
      clip = new ZeroClipboard.Client();
      clip.setHandCursor( true );
   }
 
   function move_swf(ee)
   {
      copything = document.getElementById(ee.id+"_text").value;
      clip.setText(copything);
 
         if (clip.div)
         {
            clip.receiveEvent('mouseout', null);
            clip.reposition(ee.id);
         }
         else{ clip.glue(ee.id);   }
 
         clip.receiveEvent('mouseover', null);
 
   }    
 
</script>
	
</head>

<body onload="init();">
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
    <li><a href="home.jsp" class="current">Home</a></li>
    <li><a href="controlpanel.jsp">Control Panel</a></li>
    <li><a href="contact.jsp">Contact</a></li>
    <li><a href="about.jsp">About</a></li>
    <li><a href="logout">Logout</a></li>
    </ul>
    </nav>
	<!--menu to be continued-->

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
    

	<!--end menu-->
   
   <h4>Store a new password</h4>
   <hr/>
   <form name="storenewpass" method="post" action="store_entry">

<table cellspacing="1" cellpadding="1" border="0" width="100%">
  <tr>
  <td><b>Title:</b></td>
  <td><b>Username:</b></td>
  <td><b>Password:</b></td>
  <td><b>URL:</b></td>
  <td></td>
  <td></td>
  <td></td>
  </tr>
  <tr>
  <td width="13%"><input type="text" name="new_title" value="" ></td>
  <td width="18%"><input type="text" name="new_username" value=""></td>
  <td width="18%"><input type="password" name="new_password" value=""></td>
  <td width="27%"><input type="url" name="new_url" value=""></td>
  <td width="10%"><input type="button" value="Generate" OnClick="returnPassword(new_password);" id="submit"></td>
  <td width="7%"><input type="submit" name="submit" value="Store" id="submit"></td>
  <td width="7%"><input type="reset" name="reset" value="Reset" id="reset"></td>
  </tr>
</table>

</form>



	


   
   <!--end intro-->

   
   <!--start holder-->


    <!--end holder-->
<div class="holder_content1">
	<h4>Stored passwords</h4>
	<hr/>
	
   <%

						sql = "SELECT id, AES_DECRYPT(email,'" + session_email + AES_key + "'), AES_DECRYPT(title,'" + session_email + AES_key + "'), AES_DECRYPT(username,'" + session_email + AES_key + "'), AES_DECRYPT(password,'" + session_email + AES_key + "'), AES_DECRYPT(url,'" + session_email + AES_key + "') FROM user_data WHERE AES_DECRYPT(email,'" + session_email + AES_key + "')='" + session_email + "'";						
						s.executeQuery(sql);
						//out.println(sql);
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
  <td><input type="text" name="title" value="<%out.print(title);%>" disabled></td>
  <td><input type="text" name="username" value="<%out.print(username);%>" disabled></td>
  <td><input type="password" name="password" id='textid<%out.print(id);%>_text' value="<%out.print(password);%>" disabled"></td>
  <td><input type="url" name="url" value="<%out.print(url);%>" disabled></td>
  <td></td>
  <td><div id="textid<%out.print(id);%>" onMouseOver="move_swf(this)" class="clip_button" id="submit" style="background-image: url(images/copybutton.png); height: 33px; width: 63px; border: 0px solid black;""></div></td>
  <td><a href="<%out.print(url);%>" target="_blank"><input type="submit" name="gotourl" value="Link" id="submit"></a></td>

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
   <div ="container">  
   <div id="FooterTwo"> © 2013 passManager </div>
   <div id="FooterTree"> This is a <a href="http://texwww.wordpress.com">texwww</a> term project, <a href="http://www.inf.uth.gr">UTH</a>   </div> 
   </div>
   </footer>
   <!--end footer-->

</body>
</html>