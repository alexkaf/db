<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="css/ehotels.css">
    <title></title>
</head>
<body>
<ul class="navmenu">
  <li><a href=".">Home</a></li>
  <li><a href="managerdb.html" class="active-nav">Manager Mode</a></li>
  <li><a href="customerdb.html">Customer Mode</a></li>
  <li><a href="aboutdb.html">About</a></li>
  <li><a href=".">Back</a></li>
  <li><img class="logo" src="images/logo.png"></li>
</ul>

    <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver" url = "jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC" user = "ehotels"  password = "abcd"/>
  <sql:query dataSource = "${snapshot}" var = "result">
    SELECT IRS_Number,First_Name,Last_Name
    FROM Customers
    WHERE First_Name='<%= request.getParameter("first_name")%>'
    AND Last_Name='<%= request.getParameter("last_name")%>';
  </sql:query>

      <table class="customer-rents">
      <tr>
        <th>First Name</th>
        <th>Last Name</th>
        <th>IRS Number</th>
        <th>Choose</th>
      </tr>
      <tr>
          <c:forEach var="hotel" items="${result.rows}">
            <tr>
              <td><c:out value="${hotel.First_Name}"/></td>
              <td><c:out value="${hotel.Last_Name}"/></td>
              <td><c:out value="${hotel.IRS_Number}"/></td>
              <form method="GET" action="booknowform.jsp">
                <input type="hidden" name="room_id" value="${hotel.IRS_Number}">
                <td class="but"><input type="submit" class="submit-emp" value=""></td>
              </form>
            </tr>
          </c:forEach>
      </tr>
    </table>  

    </body>
</html>