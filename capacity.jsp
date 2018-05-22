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
      <li><a href="managerdb.html">Manager Mode</a></li>
      <li><a href="customerdb.html" class="active-nav">Customer Mode</a></li>
      <li><a href="aboutdb.html">About</a></li>
      <li><a href="customerdb.html">Back</a></li>
      <li><img class="logo" src="images/logo.png"></li>
    </ul>

  <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver" url = "jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC" user = "ehotels"  password = "abcd"/>

  <sql:query dataSource = "${snapshot}" var = "result">
    SELECT *
    FROM Capacity
  </sql:query>


<table class="customer-employees">
  <tr>
    <th>Rooms ID</th>
    <th>Hotel ID</th>
    <th>Room Capacity</th>
  </tr>
  <tr>
      <c:forEach var="room" items="${result.rows}">
        <tr class="rower">
          <td><c:out value="${room.Room_ID}"/></td>
          <td><c:out value="${room.Hotel_ID}"/></td>
          <td><c:out value="${room.Capacity}"/></td>
        </tr>
      </c:forEach>
  </tr>
</table>


</body>
</html>
