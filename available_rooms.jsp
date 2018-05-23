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

String cities = request.getParameter("cities");
String stars = request.getParameter("stars");
String price = request.getParameter("price");
String capacity = request.getParameter("quantity");
String hotel = request.getParameter("hotel");
String from_date = request.getParameter("from_date");
String to_date = request.getParameter("to_date");

String where = "";
int counter = 0;
if(!cities.equals("")){
  where = where + "City =\"" + cities + "\"";
  counter = counter + 1;
}
if(stars != null){
  if(counter != 0){
    where = where + " AND Stars =\"" + stars + "\"";
  }else{
    counter = counter + 1;
    where = where + "Stars=\"" + stars + "\"";
  }
}
if(!price.equals("")){
  if(counter != 0){
    where = where + " AND Price <=\"" + price + "\"";
  }else{
    counter = counter + 1;
    where = where + "Price<=\"" + price + "\"";
  }
}
if(!capacity.equals("")){
  if(counter != 0){
    where = where + " AND Capacity=\"" + capacity + "\"";
  }else{
    counter = counter + 1;
    where = where + "Capacity=\"" + capacity + "\"";
  }
}
if(!hotel.equals("") && !hotel.equals("0")){
  if(counter != 0){
    where = where + " AND HH.Hotel_Group_ID=\"" + hotel + "\"";
  }else{
    counter = counter + 1;
    where = where + "HH.Hotel_Group_ID=\"" + hotel + "\"";
  }
}

if(counter != 0){
  where = where + " AND R.Start_Date>="+"\""+ to_date+"\"" + " OR R.Finish_Date<="+"\""+from_date+"\"";
}else{
  counter = counter + 1;
  where = where + " AND R.Start_Date>="+"\""+ to_date+"\"" + " OR R.Finish_Date<="+"\""+from_date+"\"";
}



String query = "SELECT * FROM Hotels as H, Has_Hotels as HH, Reserves as R, Hotel_Room as HR WHERE H.Hotel_ID = R.Hotel_ID AND HR.Hotel_ID = R.Hotel_ID AND HH.Hotel_ID = H.Hotel_ID AND HR.Room_ID = R.Room_ID";
if(!where.equals("")){
  query = query + " AND " + where;
  out.println("<h1>"+ query +"</h1>");
}

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
