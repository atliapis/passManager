import java.io.*;
import java.util.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

import net.tanesha.recaptcha.ReCaptchaImpl;
import net.tanesha.recaptcha.ReCaptchaResponse;

public class Registration extends HttpServlet{

	private ServletConfig config;
        PrintWriter out;
	
	public void init(ServletConfig config)
	  throws ServletException{
		 this.config=config;
	   }
        
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
		
                HttpSession session;
		out = response.getWriter();
		String connectionURL = "jdbc:mysql://localhost/passmanager";
		Connection connection = null;
		ResultSet rs;
                
                String email = new String("");
		String passwrd = new String("");
                String remoteAddr = new String("");
                String AES_key = new String("passmanager727645300");
                
                int error = 0;
		try {
                        session = request.getSession(true);
                        
                        if(email.equalsIgnoreCase(request.getParameter("email")))
                        { 
                            session.setAttribute("email_error", "Email field is empty."); 
                            error = 1; 
                        }
                        if(passwrd.equalsIgnoreCase(request.getParameter("pass")))
                        { 
                            session.setAttribute("password_error", "Password field is empty."); 
                            error = 1; 
                        }
                        if(error == 1){ response.sendRedirect(response.encodeRedirectURL("/passmanager/register.jsp")); return; }
                    
			 // Load the database driver
			Class.forName("com.mysql.jdbc.Driver");
			// Get a Connection to the database
			connection = DriverManager.getConnection(connectionURL, "passmanager", "passmanager727645300");
			//Add the data into the database
			String sql = "SELECT AES_DECRYPT(email,'" + request.getParameter("email") + AES_key + "')  FROM users";
                        //out.println("SELECT AES_DECRYPT(email,'" + request.getParameter("email") + AES_key + "')  FROM users");
			Statement s = connection.createStatement();
			s.executeQuery (sql);
			rs = s.getResultSet();
                        
			while (rs.next ()){
                                email=rs.getString(1);
                                if(email == null){ continue; }
                                if(email.equals(request.getParameter("email")))
                                { 
                                    session.setAttribute("email_error", "Email already exists."); 
                                    error = 1; 
                                }
                                if(error == 1){ break; }
			}
                        
                        passwrd = request.getParameter("pass");
                        if(!passwrd.equalsIgnoreCase(request.getParameter("pass2")))
                        { 
                            session.setAttribute("password_error", "Passwords don't match."); 
                            error = 1; 
                        }
                        
                        remoteAddr = request.getRemoteAddr();
                        ReCaptchaImpl reCaptcha = new ReCaptchaImpl();
                        reCaptcha.setPrivateKey("6LeehNgSAAAAAP2nv9YmfNprFns5YX_6_rv-svzs ");

                        String challenge = request.getParameter("recaptcha_challenge_field");
                        String uresponse = request.getParameter("recaptcha_response_field");
                        ReCaptchaResponse reCaptchaResponse = reCaptcha.checkAnswer(remoteAddr, challenge, uresponse);
                        
                        if (!reCaptchaResponse.isValid()) 
                        { 
                            session.setAttribute("recaptcha_error", "Validation code is wrong."); 
                            error = 1; 
                        }
                        
                        if(error == 1){
                            
                            response.sendRedirect(response.encodeRedirectURL("/passmanager/register.jsp"));
                            rs.close ();
                            s.close (); 
                            return; 
                        }else{
                            
                            String token = new String("");
                            
                            sql = "INSERT INTO passmanager.users (email, password, password_img) VALUES (AES_ENCRYPT('" + request.getParameter("email") + "','" + request.getParameter("email") + AES_key + "'), AES_ENCRYPT('" + request.getParameter("pass") + "','" + request.getParameter("email") + AES_key + "'), NULL)";
                            //out.print("INSERT INTO `passmanager`.`users` (`email`, `password`, `password_img`) VALUES (AES_ENCRYPT('" + request.getParameter("email") + "','" + request.getParameter("email") + AES_key + "'), AES_ENCRYPT('" + request.getParameter("pass") + "','" + request.getParameter("email") + AES_key + "'), NULL)");
                            s.executeUpdate(sql);
                            
                            for(int i=0; i<5; i++){
                                Random rand = new Random();
                                token = token.concat(new Integer(rand.nextInt(9999 - 1000) + 1000).toString());
                            }
                                    
                            sql = "UPDATE users SET token=" + token + " WHERE email = AES_ENCRYPT('" + request.getParameter("email") + "','" + request.getParameter("email") + AES_key + "')";
                            //out.println("UPDATE users SET token=" + token + " WHERE email = AES_ENCRYPT('" + request.getParameter("email") + "','" + request.getParameter("email") + AES_key + "')");
                            s.executeUpdate(sql);
                            
                            
                            session.setAttribute("email", request.getParameter("email"));
                            session.setAttribute("token", token);
                            session.removeAttribute("email_error");
                            session.removeAttribute("password_error");
                            session.removeAttribute("recaptcha_error");
                            response.sendRedirect(response.encodeRedirectURL("/passmanager/home.jsp"));
                        }

                        
			rs.close ();
			s.close ();
			}catch(Exception e){
                            System.out.println("Unexpected error: " + e);
			}
			
	}
        
        public void destroy() {
 
        }
        
}