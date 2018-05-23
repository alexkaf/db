<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>

<!DOCTYPE html>
<html>
<head>
  <title>eHotels</title>
  <link rel="stylesheet" type="text/css" href="css/ehotels.css">
  <link rel="stylesheet" type="text/css" href="css/buttons.css" />
</head>
<body>

<ul class="navmenu">
  <li><a href=".">Home</a></li>
  <li><a href="managerdb.html">Manager Mode</a></li>
  <li><a href="customerdb.html" class="active-nav">Customer Mode</a></li>
  <li><a href="aboutdb.html">About</a></li>
  <li><a href="customerdb.html">Back</a></li>
  <li><img class="logo" src="images/logo.png"></li>
</ul>

<%
Class.forName("com.mysql.jdbc.Driver");
String url ="jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
Connection conn = DriverManager.getConnection(url,"ehotels", "abcd");
Statement stmt = conn.createStatement();

String cities = request.getParameter("booknow_city");
String query = "SELECT * FROM Hotels as H, Has_Hotels as HH, Reserves as R, Hotel_Room as HR WHERE H.Hotel_ID = R.Hotel_ID AND HR.Hotel_ID = R.Hotel_ID AND HH.Hotel_ID = H.Hotel_ID AND HR.Room_ID = R.Room_ID AND R.Start_Date=(SELECT CURDATE()) AND H.City='"+cities + "'";
%>
<sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver" url = "jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC" user = "ehotels"  password = "abcd"/>

<sql:query dataSource = "${snapshot}" var = "result">
  <% out.print(query); %> ;
</sql:query>

<table class="customer-rents">
<tr>
  <th>Room_ID</th>
  <th>Hotel_ID</th>
  <th>City</th>
  <th>Price</th>
  <th>Book until</th>
  <th>More Info</th>
  <th>BOOK IT!</th>
</tr>
<tr>
    <c:forEach var="hotel" items="${result.rows}">
      <tr>
        <td><c:out value="${hotel.Room_ID}"/></td>
        <td><c:out value="${hotel.Hotel_ID}"/></td>
        <td><c:out value="${hotel.City}"/></td>
        <td><c:out value="${hotel.Price}"/></td>
        <td><c:out value="${hotel.Finish_Date}"/></td>
    <form method="GET" action="contactroom.jsp">
      <input type="hidden" name="Room_ID" value="${hotel.Room_ID}">
      <input type="hidden" name="Hotel_ID" value="${hotel.Hotel_ID}">
      <td class="but"><input type="submit" class="submit-emp" value=""></td>
    </form>
    <form method="GET" action="aprove.jsp">
      <input type="hidden" name="Room_ID" value="${hotel.Room_ID}">
      <input type="hidden" name="Hotel_ID" value="${hotel.Hotel_ID}">
      <td class="but"><input type="submit" class="submit-emp" value=""></td>
    </form>

  </tr>
  </c:forEach>
</tr>
</table>

</body>
</html>
