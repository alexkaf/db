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
String nors = request.getParameter("nors");

String where = "";
int counter = 0;
//wheredate = wheredate + " (R.Start_Date<="+"\""+ from_date+"\"" + " AND R.Finish_Date>="+"\""+to_date+"\")";


if(!cities.equals("")){
  if(counter!=0){
    where = where + " AND H.City =\"" + cities + "\"";
    counter = counter + 1;
  }
  else{
    where = where + "H.City =\"" + cities + "\"";
    counter = counter + 1;
  }

}
if(stars != null){
  if(counter != 0){
    where = where + " AND H.Stars =\"" + stars + "\"";
  }else{
    counter = counter + 1;
    where = where + "H.Stars=\"" + stars + "\"";
  }
}
if(!price.equals("")){
  if(counter != 0){
    where = where + " AND HR.Price <=\"" + price + "\"";
  }else{
    counter = counter + 1;
    where = where + "HR.Price<=\"" + price + "\"";
  }
}
if(!capacity.equals("")){
  if(counter != 0){
    where = where + " AND HR.Capacity=\"" + capacity + "\"";
  }else{
    counter = counter + 1;
    where = where + "HR.Capacity=\"" + capacity + "\"";
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

String query = "SELECT * FROM Hotel_Room as HR,(SELECT * FROM Hotel_Room as HR WHERE HR.Room_ID NOT IN (SELECT R.Room_ID FROM Reserves as R WHERE CAST('" + from_date + "' AS DATE) <= CAST('" + to_date + "' AS DATE) AND ((CAST('" + from_date + "' AS DATE)) BETWEEN R.Start_Date AND R.Finish_Date OR (CAST('" + to_date + "' AS DATE)) BETWEEN R.Start_Date AND R.Finish_Date OR ((CAST('" + from_date + "' AS DATE)) <= R.Start_Date AND (CAST('" + to_date + "' AS DATE)) >= R.Finish_Date))) AND HR.Room_ID NOT IN (SELECT R.Room_ID FROM Rents as R WHERE CAST('" + from_date + "' AS DATE) <= CAST('" + to_date + "' AS DATE) AND((CAST('" + from_date + "' AS DATE)) BETWEEN R.Start_Date AND R.Finish_Date OR (CAST('" + to_date + "' AS DATE)) BETWEEN R.Start_Date AND R.Finish_Date OR ((CAST('" + from_date + "' AS DATE)) <= R.Start_Date AND (CAST('" + to_date + "' AS DATE)) >= R.Finish_Date)))) AS G, Has_Hotels as HH, Hotels as H WHERE CAST('" + from_date + "' AS DATE) <= CAST('" + to_date + "' AS DATE) AND " + "HR.Room_ID = G.Room_ID AND HH.Hotel_ID = G.Hotel_ID AND H.Hotel_ID = G.Hotel_ID";


if(!where.equals("")){
  query = query + " AND " + where;
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
  <th>BOOK AND PAY!</th>
  <th>BOOK AND PAY LATER!</th>
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
      <input type="hidden" name="Paid" value="yes">
      <input type="hidden" name="IRS_Number" value="${param.IRS_Number}">
      <input type="hidden" name="First_Name" value="${param.First_Name}">
      <input type="hidden" name="Last_Name" value="${param.Last_Name}">
      <input type="hidden" name="from_date" value="${param.from_date}">
      <input type="hidden" name="to_date" value="${param.to_date}">
      <input type="hidden" name="Room_ID" value="${hotel.Room_ID}">
      <input type="hidden" name="Hotel_ID" value="${hotel.Hotel_ID}">
      <td class="but"><input type="submit" class="submit-emp" value=""></td>
    </form>

    <form method="GET" action="aprove.jsp">
      <input type="hidden" name="Paid" value="no">
      <input type="hidden" name="IRS_Number" value="${param.IRS_Number}">
      <input type="hidden" name="First_Name" value="${param.First_Name}">
      <input type="hidden" name="Last_Name" value="${param.Last_Name}">
      <input type="hidden" name="from_date" value="${param.from_date}">
      <input type="hidden" name="to_date" value="${param.to_date}">
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
