<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>

<!DOCTYPE html>
<html>
<head>
  <title>eHotels</title>
  <link rel="stylesheet" type="text/css" href="css/ehotels.css">
  <link rel="stylesheet" type="text/css" href="css/buttons.css" />
</head>
<body>

<%
Class.forName("com.mysql.jdbc.Driver");
String url ="jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
Connection conn = DriverManager.getConnection(url,"ehotels", "abcd");
Statement stmt = conn.createStatement();

String Room_ID = request.getParameter("Room_ID");
String Hotel_ID = request.getParameter("Hotel_ID");
String IRS_Number = request.getParameter("IRS_Number");
String First_Name = request.getParameter("First_Name");
String Last_Name = request.getParameter("Last_Name");
String from_date = request.getParameter("from_date");
String to_date = request.getParameter("to_date");
String Paid = request.getParameter("Paid");


String query = " INSERT INTO Reserves (Room_ID,IRS_Number,Start_Date,Paid,Finish_Date,Hotel_ID) VALUES ("+"\'"+Room_ID+"\'"+","+"\'"+IRS_Number+"\'"+","+"\'"+from_date+"\'"+","+"\'"+Paid+"\'"+
","+"\'"+to_date+"\'"+","+"\'"+Hotel_ID+"\'"+")";
out.println(query);
PreparedStatement prpstmt = conn.prepareStatement(query);
int i = prpstmt.executeUpdate(query);

response.sendRedirect("customerdb.html");
%>

</body>
</html>
