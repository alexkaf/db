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

  <c:set var = "hotel_id" value = "${param.hotel_id}"/>

  <sql:update dataSource = "${snapshot}" var = "irs_number">
     DELETE FROM Hotels WHERE Hotel_ID = ? 
     <sql:param value = "${hotel_id}" />
  </sql:update>

  <sql:query dataSource = "${snapshot}" var = "result">
    SELECT * 
    FROM Hotels
  </sql:query>


<table class="customer-employees">
  <tr>
    <th>Hotel_ID</th>
    <th>City</th>
    <th>Street</th>
    <th>Number</th>
    <th>Contact Info</th>
    <th>Update</th>
    <th>Delete</th>
  </tr>
  <tr>
      <c:forEach var="hotel" items="${result.rows}">
        <tr class="rower">
          <td><c:out value="${hotel.Hotel_ID}"/></td>
          <td><c:out value="${hotel.City}"/></td>
          <td><c:out value="${hotel.Street}"/></td>
          <td><c:out value="${hotel.Number}"/></td>
          <form method="GET" action="contacthotel.jsp">
            <input type="hidden" name="hotel_id" value="${hotel.Hotel_ID}">
            <td class="but"><input type="submit" class="submit-emp" value=""></td>
          </form>
          <form method="GET" action="updatehotel.jsp">
            <input type="hidden" name="hotel_id" value="${hotel.Hotel_ID}">
            <input type="hidden" name="city" value="${hotel.City}">
            <input type="hidden" name="street" value="${hotel.Street}">
            <input type="hidden" name="ssn" value="${hotel.Social_Security_Number}">
            <input type="hidden" name="city" value="${hotel.City}">
            <input type="hidden" name="street" value="${hotel.street}">
            <input type="hidden" name="number" value="${hotel.Number}">
            <td class="but"><input type="submit" class="submit-emp" value=""></td>
          </form>
          <form method="GET" action="deletehotel.jsp">
            <input type="hidden" name="hotel_id" value="${hotel.Hotel_ID}">
            <td class="but"><input type="submit" class="submit-emp" value=""></td>
          </form>
        </tr>
      </c:forEach>
  </tr>
</table>   

</body>
</html>