import java.io.*;
import java.util.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class Logout extends HttpServlet{

	private ServletConfig config;
        PrintWriter out;
	
	public void init(ServletConfig config)
	  throws ServletException{
		 this.config=config;
	   }
       
	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException,IOException{
			
                HttpSession session = request.getSession(true);
		out = response.getWriter();
		String connectionURL = "jdbc:mysql://localhost/passmanager";
		Connection connection = null;
		ResultSet rs;
                String email = new String("");
                String token = new String("");
		String session_email = (String)session.getAttribute("email");
                String session_token = (String)session.getAttribute("token");
                String AES_key = new String("passmanager727645300");
                boolean logout = false;
                
                if(session_email == null || session_token == null){ response.sendRedirect(response.encodeRedirectURL("/passmanager/login.jsp")); return; }
                
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
                                    
                                    sql = "UPDATE users SET token=NULL WHERE email = AES_ENCRYPT('" + session_email + "','" + session_email + AES_key + "')";
                                    
                                    s.executeUpdate(sql);
                                    logout = true;
                                    
                                    break;
                                }
			}
			rs.close ();
			s.close ();
			}catch(Exception e){
			System.out.println("Exception is ;"+e);
			}
			if(logout){
                            
                                session.removeAttribute("email");
                                session.removeAttribute("token");
                                
                                
			}
                        
                        response.sendRedirect(response.encodeRedirectURL("/passmanager/login.jsp"));
                        
	}
        
        public void destroy() {
 
        }
        
}	