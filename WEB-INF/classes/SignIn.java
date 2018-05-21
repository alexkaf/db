import java.io.*;
import java.sql.*;
import javax.servlet.*;
import javax.servlet.http.*;
 
public class SignIn extends HttpServlet {  // JDK 1.6 and above only
 
   // The doGet() runs once per HTTP GET request to this servlet.
   @Override
   public void doGet(HttpServletRequest request, HttpServletResponse response)
               throws ServletException, IOException {
      // Set the MIME type for the response message
      response.setContentType("text/html");
      // Get a output writer to write the response message into the network socket
      PrintWriter out = response.getWriter();
 
      Connection conn = null;
      Statement stmt = null;
      try {
         // Step 1: Allocate a database Connection object
         Class.forName("com.mysql.jdbc.Driver");  // Needed for JDK9/Tomcat9
         conn = DriverManager.getConnection(
            "jdbc:mysql://localhost:3306/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC", "ehotels", "abcd"); // <== Check!
            // database-URL(hostname, port, default database), username, password
        stmt = conn.createStatement();
         // Step 2: Allocate a Statement object within the Connection
 
         // Step 3: Execute a SQL SELECT query
         String username = request.getParameter("user");
         String password = request.getParameter("passwd");
        String query = "select Password from Logins where user_name=\""+username+"\"";
         
         // Print an HTML page as the output of the query
         ResultSet rset = stmt.executeQuery(query);  // Send the query to the server
         // Step 4: Process the query result set
         rset.next();
         String real_password = rset.getString("Password");
         if(real_password.equals(password)){
          response.sendRedirect("http://localhost:9999/ehotelsdb/dbmanager/manager/manager.jsp?user="+username);
         }else{
          response.sendRedirect("http://localhost:9999/ehotelsdb");
         }
                    
      }
       catch (SQLException ex) {
        ex.printStackTrace();
     } catch (ClassNotFoundException ex) {
        ex.printStackTrace();
     } finally {
        out.close();  // Close the output writer
        try {
           // Step 5: Close the resources
           if (stmt != null) stmt.close();
           if (conn != null) conn.close();
        } catch (SQLException ex) {
           ex.printStackTrace();
        }
     }
   }
}