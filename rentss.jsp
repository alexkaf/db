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
<body class="rents">
    <ul class="navmenu">
      <li><a href=".">Home</a></li>
      <li><a href="managerdb.html" class="active-nav">Manager Mode</a></li>
      <li><a href="customerdb.html">Customer Mode</a></li>
      <li><a href="addroom.jsp">Add a new Room</a></li>
      <li><a href="aboutdb.html">About</a></li>
      <li><a href="manage.jsp">Back</a></li>
      <li><img class="logo" src="images/logo.png"></li>
    </ul>

  <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver" url = "jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC" user = "ehotels"  password = "abcd"/>

  <sql:query dataSource = "${snapshot}" var = "result">
    SELECT *
    FROM Rents as R, Payment_Transaction as PT
    WHERE R.Payment_ID = PT.Payment_ID
  </sql:query>


<table class="customer-employees">
  <tr>
    <th>Emploee</th>
    <th>Customer</th>
    <th>Room ID</th>
    <th>Paid with</th>
    <th>From</th>
    <th>To</th>
  </tr>
  <tr>
      <c:forEach var="room" items="${result.rows}">
        <tr class="rower">
          <td><c:out value="${room.IRS_Number_E}"/></td>
          <td><c:out value="${room.IRS_Number_C}"/></td>
          <td><c:out value="${room.Room_ID}"/></td>
          <td><c:out value="${room.Payment_Method}"/></td>
          <td><c:out value="${room.Start_Date}"/></td>
          <td><c:out value="${room.Finish_Date}"/></td>
        </tr>
      </c:forEach>
  </tr>
</table>

</body>
</html>
