<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/ehotels.css">
    <title></title>
</head>
<body>
<ul class="navmenu">
  <li><a href=".">Home</a></li>
  <li><a href="managerdb.html" class="active-nav">Manager Mode</a></li>
  <li><a href="customerdb.html">Customer Mode</a></li>
  <li><a href="aboutdb.html">About</a></li>
  <li><a href=".">Back</a></li>
  <li><img class="logo" src="images/logo.png"></li>
</ul>

<%
  Class.forName("com.mysql.jdbc.Driver");
  String url ="jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
  String check_customer = "SELECT count(IRS_Number)FROM Customers WHERE ";
  String values = "";
  Connection conn = DriverManager.getConnection(url,"ehotels", "abcd");
  /***********************FOR REGISTRATION**************************/
  Statement stmt = conn.createStatement();
  String first_name = request.getParameter("first_name");
  String last_name = request.getParameter("last_name");
  /***************************FOR BOOKING***************************/
  String cities = request.getParameter("booknow_city");
  String stars = request.getParameter("stars");
  String price = request.getParameter("price");
  String capacity = request.getParameter("quantity");
  String hotel = request.getParameter("hotel");
  String from_date = request.getParameter("from_date");
  String to_date = request.getParameter("to_date"); 

  // Last Name
  if(last_name.length() >25){
    response.sendRedirect("error.html");
  }
  values = values + "Last_Name=\"" + last_name + "\" AND ";
  // First Name
  if(first_name.length() > 20){
    response.sendRedirect("error.html");
  }
  values = values + "First_Name=\"" + first_name + "\"";
  String query = check_customer + values;
  ResultSet rs = stmt.executeQuery(query);
  rs.next();

  if(rs.getInt("count(IRS_Number)") == 0){
    response.sendRedirect("nowcustomerreg.jsp?"+"booknow_city=" + cities);
  }
  else if(rs.getInt("count(IRS_Number)") > 0){
    response.sendRedirect("nowshowirrs.jsp?first_name="+first_name + "&last_name=" + last_name + "&booknow_city=" + cities);
  }
%> 
</body>
</html>

