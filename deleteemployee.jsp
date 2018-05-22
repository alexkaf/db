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

  <c:set var = "irs_number" value = "${param.irs}"/>

  <sql:update dataSource = "${snapshot}" var = "irs_number">
     DELETE FROM Employees WHERE IRS_Number = ? 
     <sql:param value = "${irs_number}" />
  </sql:update>

  <sql:query dataSource = "${snapshot}" var = "result">
    SELECT * 
    FROM Employees
  </sql:query>


<table class="customer-employees">
  <tr>
    <th>First Name</th>
    <th>Last Name</th>
    <th>IRS Number</th>
    <th>SSN</th>
    <th>Update</th>
    <th>Delete</th>
    <th>Address</th>
  </tr>
  <tr>
      <c:forEach var="hotel" items="${result.rows}">
        <tr>
          <td><c:out value="${hotel.First_Name}"/></td>
          <td><c:out value="${hotel.Last_Name}"/></td>
          <td><c:out value="${hotel.IRS_Number}"/></td>
          <td><c:out value="${hotel.Social_Security_Number}"/></td>
          <form method="GET" action="updateemployee.jsp">
            <input type="hidden" name="last_name" value="${hotel.Last_Name}">
            <input type="hidden" name="first_name" value="${hotel.First_Name}">
            <input type="hidden" name="irs" value="${hotel.IRS_Number}">
            <input type="hidden" name="ssn" value="${hotel.Social_Security_Number}">
            <input type="hidden" name="city" value="${hotel.City}">
            <input type="hidden" name="street" value="${hotel.street}">
            <input type="hidden" name="number" value="${hotel.Number}">
            <input type="hidden" name="postal_code" value="${hotel.Postal_Code}">
            <td class="but"><input type="submit" class="submit-emp" value=""></td>
          </form>
          <form method="GET" action="deleteemployee.jsp">
            <input type="hidden" name="irs" value="${hotel.IRS_Number}">
            <td class="but"><input type="submit" class="submit-emp" value=""></td>
          </form>
          <form method="GET" action="contactemp.jsp">
            <input type="hidden" name="irs" value="${hotel.IRS_Number}">
            <td class="but"><input type="submit" class="submit-emp" value=""></td>
          </form>
        </tr>
      </c:forEach>
  </tr>
</table>  

</body>
</html>