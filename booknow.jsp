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

  SELECT Hotel_Room.Room_ID,Hotel_Room.Hotel_ID,Reserves.Start_Date,Reserves.Finish_Date
  FROM Hotel_Room
  INNER JOIN Reserves ON Reserves.Room_ID=Hotel_Room.Room_ID AND Reserves.Hotel_ID=Hotel_Room.Hotel_ID
  <!---WHERE Reserves.Start_Date NOT BETWEEN #17/07/2002# AND #29/07/2002#;-->
  </sql:query>


<table class="customer-employees">
  <tr>
    <th>Room ID</th>
    <th>Hotel ID</th>
    <th>Start Date</th>
    <th>Finish Date</th>
    <th>Update</th>
    <th>Delete</th>
    <th>Address</th>
  </tr>
  <tr>
      <c:forEach var="room" items="${result.rows}">
        <tr class="rower">
          <td><c:out value="${room.Room_ID}"/></td>
          <td><c:out value="${room.Hotel_ID}"/></td>
          <td><c:out value="${room.Start_Date}"/></td>
          <td><c:out value="${room.Finish_Date}"/></td>
          <form method="GET" action="updateemployee.jsp">
            <td class="but"><input type="submit" class="submit-emp" value=""></td>
          </form>
          <form method="GET" action="deleteemployee.jsp">
            <td class="but"><input type="submit" class="submit-emp" value=""></td>
          </form>
          <form method="GET" action="contactemp.jsp">
            <td class="but"><input type="submit" class="submit-emp" value=""></td>
          </form>
        </tr>
      </c:forEach>
  </tr>
</table>
-->
</body>
</html>
