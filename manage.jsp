<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ page session="true" %>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/ehotels.css">
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

<div class="buttons-wrapper manager">
  <div class="box bg-1">
    <a href="rentss.jsp"><button class="buttonan button--antiman button--round-l button--text-medium"><span>Rents</span></button></a>
    <a href="managerrents.jsp"><button class="buttonan button--antiman button--round-l button--text-medium"><span>Reservations</span></button></a>
    <a href="manageemps.jsp"><button class="buttonan button--antiman button--round-l button--text-medium"><span>Employees</span></button></a>
    <a href="managecustomers.jsp"><button class="buttonan button--antiman button--round-l button--text-medium"><span>Customers</span></button></a>
    <a href="managerooms.jsp"><button class="buttonan button--antiman button--round-l button--text-medium"><span>Rooms</span></button></a>
    <a href="managehotels.jsp"><button class="buttonan button--antiman button--round-l button--text-medium"><span>Hotels</span></button></a>
  </div>
</div>

<%
  Class.forName("com.mysql.jdbc.Driver");
  String url ="jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
  String sql = "Select IRS_Number,Password From Logins Where User_Name=\"" + request.getParameter("username") + "\"";
  Connection conn = DriverManager.getConnection(url,"ehotels", "abcd");
  Statement stmt = conn.createStatement();
  ResultSet rs = stmt.executeQuery(sql);
  if (rs != null && rs.next()){
    String input = request.getParameter("pswd");
    String password = rs.getString("Password");
    if(password.equals(input)){
      session.setAttribute("irs_emp",rs.getString("IRS_Number"));
    }else{
      response.sendRedirect("index.html");
    }
  }else{
    response.sendRedirect("index.html");
  }
%>

</body>
</html>
