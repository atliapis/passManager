import java.io.*;
import java.util.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class ChangePassword extends HttpServlet{

	private ServletConfig config;
        PrintWriter out;
	
	public void init(ServletConfig config)
	  throws ServletException{
		 this.config=config;
	   }
       
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
			
                HttpSession session = request.getSession(true);
		out = response.getWriter();
		String connectionURL = "jdbc:mysql://localhost/passmanager";
		Connection connection = null;
		ResultSet rs;
                String email = new String("");
                String password = new String("");
                String password_img = new String("");
                String token = new String("");
		String session_email = (String)session.getAttribute("email");
                String session_token = (String)session.getAttribute("token");
                String AES_key = new String("passmanager727645300");
                
                String changePass_oldPass_error = "";
                String changePass_newPass_error = "";
                
                boolean change_password = false;
                
                if(session_email == null || session_token == null){ response.sendRedirect(response.encodeRedirectURL("/passmanager/login.jsp")); return; }
                
		try {
                    
                        
			 // Load the database driver
			Class.forName("com.mysql.jdbc.Driver");
			// Get a Connection to the database
			connection = DriverManager.getConnection(connectionURL, "passmanager", "passmanager727645300");
			//Add the data into the database
                        //SELECT AES_DECRYPT(email,'vaanasta@hotmail.compassmanager727645300'), token FROM users WHERE AES_DECRYPT(email,'vaanasta@hotmail.compassmanager727645300')='vaanasta@hotmail.com'
			String sql = "SELECT AES_DECRYPT(email,'" + session_email + AES_key + "'), AES_DECRYPT(password,'" + session_email + AES_key + "'), AES_DECRYPT(password_img,'" + session_email + AES_key + "'), token FROM users WHERE AES_DECRYPT(email,'" + session_email + AES_key + "')='" + session_email + "'";
			Statement s = connection.createStatement();
                        s.executeQuery (sql);
                        
			rs = s.getResultSet();
			while (rs.next ()){
				email=rs.getString("AES_DECRYPT(email,'" + session_email + AES_key + "')");
                                password=rs.getString("AES_DECRYPT(password,'" + session_email + AES_key + "')");
                                password_img=rs.getString("AES_DECRYPT(password_img,'" + session_email + AES_key + "')");
                                token=rs.getString("token");
				
                                
                                
                                if(email == null){ continue; }
                                
                                if(email.equals(session_email) && token.equals(session_token) ){
                                    
                                    if(password.equals(request.getParameter("old_password"))){
                                        
                                        if(request.getParameter("new_password_1") != null && request.getParameter("new_password_2") != null){
                                        
                                            //Change Normal password
                                            if(request.getParameter("new_password_1").equals(request.getParameter("new_password_2"))){

                                                //UPDATE users SET password = AES_ENCRYPT('test','vaanasta@hotmail.compassmanager727645300') WHERE email = AES_ENCRYPT('vaanasta@hotmail.com','vaanasta@hotmail.compassmanager727645300')
                                                sql = "UPDATE users SET password = AES_ENCRYPT('" + request.getParameter("new_password_1") + "','" + session_email + AES_key + "') WHERE email = AES_ENCRYPT('" + session_email + "','" + session_email + AES_key + "')";
                                                //out.println(sql);
                                                s.executeUpdate(sql);

                                                change_password = true;
                                            }else{

                                                session.setAttribute("new_pass_error", "Passwords don't match.");
                                                //out.println("Passwords don't match.");

                                            }
                                        }else{
                                            //Change Image password
                                            
                                            String new_img_password = request.getParameter("new_img_password");
                                            
                                            //if(new_img_password == null){ out.println("new_img_password is null"); }
                                            
                                            if(new_img_password.length() == 24){
                                            
                                                sql = "UPDATE users SET password_img = AES_ENCRYPT('" + request.getParameter("new_img_password") + "','" + session_email + AES_key + "') WHERE email = AES_ENCRYPT('" + session_email + "','" + session_email + AES_key + "')";
                                                //out.println(sql);
                                                s.executeUpdate(sql);
                                                
                                                change_password = true;
                                                
                                            }else{
                                                session.setAttribute("new_img_pass_error", "Image password consists of exactly four points.");
                                                //out.println("Image password consists of exactly four points.");
                                            }
                                        }
                                    
                                    }else{
									
										if(request.getParameter("new_password_1") == null && request.getParameter("new_password_2") == null) {
											session.setAttribute("pass_error", "Wrong password.");
										}
										else{
											session.setAttribute("old_pass_error", "Wrong password.");
											//out.println("Wrong password.");
										}
                                    
                                    }
                                    
                                    /*else if(password_img.equals(request.getParameter("old_password"))){
                                    
                                        if(request.getParameter("new_password_1").equals(request.getParameter("new_password_2"))){
                                            
                                            sql = "UPDATE users SET AES_DECRYPT(password_img,'" + session_email + AES_key + "')='" + request.getParameter("new_password_1") + "' WHERE email = AES_ENCRYPT('" + session_email + "','" + session_email + AES_key + "')";
                                    
                                            s.executeUpdate(sql);
                                            change_password = true;
                                        }
                                    }*/
                                    
                                    break;
                                }
			}
			rs.close ();
			s.close ();
			}catch(Exception e){
			System.out.println("Exception is ;"+e);
			}
			if(change_password){
                            
                                session.setAttribute("change_pass_success", "Password change was successful");
                                //out.println("Password change was successful");
                                //response.sendRedirect(response.encodeRedirectURL("/passmanager/controlpanel.jsp"));
                                
			}
                        
                        response.sendRedirect(response.encodeRedirectURL("/passmanager/controlpanel.jsp"));
                        
	}
        
        public void destroy() {
 
        }
        
}	