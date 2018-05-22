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
    <li class="active-nav"><a href="managerdb.html">Manager Mode</a></li>
    <li><a href="customerdb.html">Customer Mode</a></li>
    <li><a href="aboutdb.html">About</a></li>
    <li><a href="managerooms.jsp">Back</a></li>
    <li><img class="logo" src="images/logo.png"></li>
  </ul>

  <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver" url = "jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC" user = "ehotels"  password = "abcd"/>

  <sql:query dataSource = "${snapshot}" var = "result" >
     SELECT View,Capacity,Amenities,Expandable
     FROM Hotel_Room
     WHERE Room_ID=<%= request.getParameter("Room_ID") %> AND Hotel_ID=<%= request.getParameter("Hotel_ID") %>
  </sql:query>

<table class="customer-employees">
  <tr>
    <th>View</th>
    <th>Capacity</th>
    <th>Amenities</th>
    <th>Expandable</th>
  </tr>
  <tr>
      <c:forEach var="room" items="${result.rows}">
        <tr>
          <td><c:out value="${room.View}"/></td>
          <td><c:out value="${room.Capacity}"/></td>
          <td><c:out value="${room.Amenities}"/></td>
          <td><c:out value="${room.Expandable}"/></td>
        </tr>
      </c:forEach>
  </tr>
</table>

</body>
</html>
