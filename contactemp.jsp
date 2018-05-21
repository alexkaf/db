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
      <li><a href="manageemps.jsp">Back</a></li>
      <li><img class="logo" src="images/logo.png"></li>
    </ul>

  <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver" url = "jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC" user = "ehotels"  password = "abcd"/>

  <sql:query dataSource = "${snapshot}" var = "irs_number">
     SELECT Street,Number,Postal_Code,City
     FROM Employees
     WHERE IRS_Number=<%= request.getParameter("irs") %>
  </sql:query>

<table class="customer-employees">
  <tr>
    <th>Street</th>
    <th>Number</th>
    <th>Postal Code</th>
    <th>City</th>
  </tr>
  <tr>
      <c:forEach var="hotel" items="${irs_number.rows}">
        <tr>
          <td><c:out value="${hotel.Street}"/></td>
          <td><c:out value="${hotel.Number}"/></td>
          <td><c:out value="${hotel.Postal_Code}"/></td>
          <td><c:out value="${hotel.City}"/></td>
        </tr>
      </c:forEach>
  </tr>
</table>  

</body>
</html>