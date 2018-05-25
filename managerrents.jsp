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
    <li><a href="aboutdb.html">About</a></li>
    <li><a href="manage.jsp">Back</a></li>
    <li><img class="logo" src="images/logo.png"></li>
  </ul>

  <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver" url = "jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC" user = "ehotels"  password = "abcd"/>

  <sql:query dataSource = "${snapshot}" var = "result">
    SELECT R.Room_ID,C.Last_Name,C.First_Name,C.IRS_Number,R.Start_Date,R.Finish_Date,Reservation_ID
    FROM Reserves as R,Customers as C
    WHERE C.IRS_Number = R.IRS_Number
    ORDER BY Last_Name
  </sql:query>

<table class="customer-rents">
  <tr>
    <th>IRS Number</th>
    <th>Last Name</th>
    <th>First Name</th>
    <th>Start Date</th>
    <th>Finish Date</th>
    <th>Room Number</th>
    <th>Pay with Cash</th>
    <th>Pay with Card</th>
  </tr>
  <tr>
      <c:forEach var="hotel" items="${result.rows}">
        <tr>
          <td><c:out value="${hotel.IRS_Number}"/></td>
          <td><c:out value="${hotel.Last_Name}"/></td>
          <td><c:out value="${hotel.First_Name}"/></td>
          <td><c:out value="${hotel.Start_Date}"/></td>
          <td><c:out value="${hotel.Finish_Date}"/></td>
          <td><c:out value="${hotel.Room_ID}"/></td>
          <form method="GET" action="approverent.jsp">
            <input type="hidden" name="Room_ID" value="${hotel.Room_ID}">
            <input type="hidden" name="IRS_Number" value="${hotel.IRS_Number}">
            <input type="hidden" name="start" value="${hotel.Start_Date}">
            <input type="hidden" name="fin" value="${hotel.Finish_Date}">
            <input type="hidden" name="emp_IRS" value="${sessionScope.irs_emp}">
            <input type="hidden" name="pay" value="cash">
            <input type="hidden" name="id" value="${hotel.Reservation_ID}">
            <td class="but"><input type="submit" class="submit-emp" value=""></td>
          </form>
          <form method="GET" action="approverent.jsp">
            <input type="hidden" name="Room_ID" value="${hotel.Room_ID}">
            <input type="hidden" name="IRS_Number" value="${hotel.IRS_Number}">
            <input type="hidden" name="start" value="${hotel.Start_Date}">
            <input type="hidden" name="fin" value="${hotel.Finish_Date}">
            <input type="hidden" name="emp_IRS" value="${sessionScope.irs_emp}">
            <input type="hidden" name="pay" value="card">
            <input type="hidden" name="id" value="${hotel.Reservation_ID}">
            <td class="but"><input type="submit" class="submit-emp" value=""></td>
          </form>
        </tr>
      </c:forEach>
  </tr>
</table>  


</body>
</html>