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
  Connection conn = DriverManager.getConnection(url,"ehotels", "abcd");
  /***********************FOR REGISTRATION**************************/
  Statement stmt = conn.createStatement();
  String irs = request.getParameter("irs_number");
  String first_name = request.getParameter("first_name");
  String last_name = request.getParameter("last_name");
  String city = request.getParameter("city");
  String street = request.getParameter("street");
  String number = request.getParameter("number");
  String postal_code = request.getParameter("postal_code");
  String reg_date = request.getParameter("reg_date");
  /***************************FOR BOOKING***************************/
  String cities = request.getParameter("cities");
  String stars = request.getParameter("stars");
  String price = request.getParameter("price");
  String capacity = request.getParameter("quantity");
  String hotel = request.getParameter("hotel");
  String from_date = request.getParameter("from_date");
  String to_date = request.getParameter("to_date");  
%>

</body>
</html>
