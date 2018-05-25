<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ page session="true" %>

<html>
<head>
</head>
<body>
    <%
  Class.forName("com.mysql.jdbc.Driver");
  String url ="jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
  String query = "SELECT MAX(Payment_ID) FROM Rents";
  Connection conn = DriverManager.getConnection(url,"ehotels", "abcd");
  Statement stmt = conn.createStatement();
  ResultSet rs = stmt.executeQuery(query);
  rs.next();
  int new_id = rs.getInt("MAX(Payment_ID)") + 1;
  String irs_e = request.getParameter("emp_IRS");
  String irs_c = request.getParameter("IRS_Number");
  String room_id = request.getParameter("Room_ID");
  String sd = request.getParameter("start");
  String fd = request.getParameter("fin");
  String res_id = request.getParameter("id");
  query = "INSERT INTO Rents (Payment_ID,IRS_Number_C,IRS_Number_E,Room_ID,Start_Date,Finish_Date) VALUES ('" + new_id + "','" + irs_c + "','" + irs_e + "','" + room_id + "','" + sd + "','" + fd +"')";
  PreparedStatement p = conn.prepareStatement(query);
  int i = p.executeUpdate(query);
  query = "DELETE FROM Reserves WHERE Reservation_ID="+res_id;
  p = conn.prepareStatement(query);
  i = p.executeUpdate(query);
  query = "INSERT INTO Payment_Transaction(Payment_ID,Payment_Method,Payment_Amount) VALUES ('" + new_id + "','" + request.getParameter("pay") + "','" ;
  String diff = "SELECT DATEDIFF(Finish_Date,Start_Date) FROM Rents WHERE IRS_Number_C=" + irs_c + " AND Room_ID=" + room_id;
  rs = stmt.executeQuery(diff);
  rs.next();
  int days = rs.getInt("DATEDIFF(Finish_Date,Start_Date)");
  String price = "SELECT Price FROM Hotel_Room WHERE Room_ID=" + room_id;
  rs = stmt.executeQuery(price);
  rs.next();
  int pric = rs.getInt("Price");
  long amount = pric * days;
  String uery = "";
  uery = query + amount + "')";
  p = conn.prepareStatement(uery);
  i = p.executeUpdate(uery);
  response.sendRedirect("managerrents.jsp");
  %>

</body>
</html>