import java.io.*;
import java.util.*;
import java.util.Random;
import java.lang.Math;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;

public class Login extends HttpServlet{

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
		String password = new String("");
                String password_img = new String("");
                String token = new String("");
                String AES_key = new String("passmanager727645300");
                boolean login = false;
		response.setContentType("text/html");
		try {
			 // Load the database driver
			Class.forName("com.mysql.jdbc.Driver");
			// Get a Connection to the database
			connection = DriverManager.getConnection(connectionURL, "passmanager", "passmanager727645300");
			//Add the data into the database
			String sql = "SELECT AES_DECRYPT(email,'" + request.getParameter("email") + AES_key + "'), AES_DECRYPT(password,'" + request.getParameter("email") + AES_key + "'), AES_DECRYPT(password_img,'" + request.getParameter("email") + AES_key + "') FROM users";
			Statement s = connection.createStatement();
			//out.println("SELECT AES_DECRYPT(email,'" + request.getParameter("email") + AES_key + "'), AES_DECRYPT(password,'" + request.getParameter("email") + AES_key + "') FROM users");
                        s.executeQuery (sql);
			rs = s.getResultSet();
			while (rs.next ()){
				email=rs.getString("AES_DECRYPT(email,'" + request.getParameter("email") + AES_key + "')");
				password=rs.getString("AES_DECRYPT(password,'" + request.getParameter("email") + AES_key + "')");
                                password_img=rs.getString("AES_DECRYPT(password_img,'" + request.getParameter("email") + AES_key + "')");
                                if(email == null || password == null){ continue; }
                                
                                if(email.equals(request.getParameter("email")) && (password.equals(request.getParameter("password")) || verify_img_password(password_img, request.getParameter("img_password"))) ){
                                    
                                    for(int i=0; i<5; i++){
                                        Random rand = new Random();
                                        token = token.concat(new Integer(rand.nextInt(9999 - 1000) + 1000).toString());
                                    }
                                    
                                    sql = "UPDATE users SET token=" + token + " WHERE email = AES_ENCRYPT('" + request.getParameter("email") + "','" + request.getParameter("email") + AES_key + "')";
                                    //out.println("UPDATE users SET token=" + token + " WHERE email = AES_ENCRYPT('" + request.getParameter("email") + "','" + request.getParameter("email") + AES_key + "')");
                                    s.executeUpdate(sql);
                                    login = true;
                                    
                                    break;
                                }
			}
			rs.close ();
			s.close ();
			}catch(Exception e){
			System.out.println("Exception is ;"+e);
			}
			if(login){
                            
                            
                                session = request.getSession(true);
                                session.setAttribute("email", email);
                                session.setAttribute("token", token);
                                session.removeAttribute("login_error");
                                response.sendRedirect(response.encodeRedirectURL("/passmanager/home.jsp"));
				//out.println("<h2 align=\"center\">Login was successful.</h2>");
                                //out.println("<h2 align=\"center\">Token: " + token + "</h2>");
			}
			else{
                                session = request.getSession(true);
                                session.setAttribute("login_error", "true");
                                response.sendRedirect(response.encodeRedirectURL("/passmanager/login.jsp"));
			}
	}
        
        public void destroy() {
 
        }
        
        private boolean verify_img_password(String storedPassword, String givenPassword){
            
            //out.println(givenPassword);
            
            if(givenPassword == null || storedPassword == null ){ return false; }
            
            char[] sPass = storedPassword.toCharArray();
            char[] gPass = givenPassword.toCharArray();
            
            if(sPass.length != gPass.length){ return false; }
            else {
            
                    for(int i=0; i<3; i++){
                        
                        int sX = (sPass[i*6] - '0')*100 + (sPass[i*6 + 1] - '0')*10 + (sPass[i*6 + 2] - '0');
                        int sY = (sPass[i*6 + 3] - '0')*100 + (sPass[i*6 + 4] - '0')*10 + (sPass[i*6 + 5] - '0');
                        int gX = (gPass[i*6] - '0')*100 + (gPass[i*6 + 1] - '0')*10 + (gPass[i*6 + 2] - '0');
                        int gY = (gPass[i*6 + 3] - '0')*100 + (gPass[i*6 + 4] - '0')*10 + (gPass[i*6 + 5] - '0');
                        
                        double distance = Math.sqrt(Math.pow(gX - sX, 2) + Math.pow(gY - sY, 2));
                        
                        if(distance > 7){ return false; }
                        
                    }
            }
            
            return true;
        }
}	