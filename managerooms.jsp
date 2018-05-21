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
    FROM Hotel_Room
  </sql:query>


<table class="customer-employees">
  <tr>
    <th>Room_ID</th>
    <th>Hotel_ID</th>
    <th>Repairs_Need</th>
    <th>Price</th>
    <th>Update</th>
    <th>Delete</th>
    <th>More Info</th>
  </tr>
  <tr>
      <c:forEach var="room" items="${result.rows}">
        <tr class="rower">
          <td><c:out value="${room.Room_ID}"/></td>
          <td><c:out value="${room.Hotel_ID}"/></td>
          <td><c:out value="${room.Repairs_Need}"/></td>
          <td><c:out value="${room.Price}"/></td>
          <form method="GET" action="updateroom.jsp">
            <input type="hidden" name="Hotel_ID" value="${room.Hotel_ID}">
            <input type="hidden" name="Room_ID" value="${room.Room_ID}">
            <input type="hidden" name="Repairs_Need" value="${room.Repairs_Need}">
            <input type="hidden" name="Expandable" value="${room.Expandable}">
            <input type="hidden" name="View" value="${room.View}">
            <input type="hidden" name="Capacity" value="${room.Capacity}">
            <input type="hidden" name="Amenities" value="${room.Amenities}">
            <input type="hidden" name="Price" value="${room.Price}">
            <td class="but"><input type="submit" class="submit-emp" value=""></td>
          </form>
          <form method="GET" action="deleteroom.jsp">
            <input type="hidden" name="Room_ID" value="${room.Room_ID}">
            <input type="hidden" name="Hotel_ID" value="${room.Hotel_ID}">
            <td class="but"><input type="submit" class="submit-emp" value=""></td>
          </form>
          <form method="GET" action="contactroom.jsp">
            <input type="hidden" name="Room_ID" value="${room.Room_ID}">
            <input type="hidden" name="Hotel_ID" value="${room.Hotel_ID}">
            <td class="but"><input type="submit" class="submit-emp" value=""></td>
          </form>
        </tr>
      </c:forEach>
  </tr>
</table>

</body>
</html>
