<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>

<html>
<head>
<link rel="stylesheet" type="text/css" href="css/ehotels.css">
</head>
<body class="rents">
  <ul class="navmenu">
    <li><a href=".">Home</a></li>
    <li><a href="managerdb.html" class="active-nav">Manager Mode</a></li>
    <li><a href="customerdb.html">Customer Mode</a></li>
    <li><a href="aboutdb.html">About</a></li>
    <li><a href="manage.jsp">Back</a></li>
    <li><img class="logo" src="images/logo.png"></li>
  </ul>

  <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver" url = "jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC" user = "ehotels"  password = "abcd"/>

  <sql:query dataSource = "${snapshot}" var = "result">
    SELECT * 
    FROM Rents
  </sql:query>

<table class="customer-rents">
  <tr>
    <th>Employer</th>
    <th>Customer</th>
    <th>Room ID</th>
    <th>Start Date</th>
    <th>Finish Date</th>
    <th>Payment ID</th>
  </tr>
  <tr>
      <c:forEach var="hotel" items="${result.rows}">
        <tr>
          <td><c:out value="${hotel.IRS_Number_E}"/></td>
          <td><c:out value="${hotel.IRS_Number_C}"/></td>
          <td><c:out value="${hotel.Room_ID}"/></td>
          <td><c:out value="${hotel.Start_Date}"/></td>
          <td><c:out value="${hotel.Finish_Date}"/></td>
          <td><c:out value="${hotel.Payment_ID}"/></td>
        </tr>
      </c:forEach>
  </tr>
</table>  


</body>
</html>