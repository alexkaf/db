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

<%
  Class.forName("com.mysql.jdbc.Driver");
  String url ="jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
  String check_customer = "SELECT count(IRS_Number)FROM Customers WHERE ";
  String values = "";
  Connection conn = DriverManager.getConnection(url,"ehotels", "abcd");
  /***********************FOR REGISTRATION**************************/
  Statement stmt = conn.createStatement();
  String first_name = request.getParameter("first_name");
  String last_name = request.getParameter("last_name");
  /***************************FOR BOOKING***************************/
  String cities = request.getParameter("cities");
  String stars = request.getParameter("stars");
  String price = request.getParameter("price");
  String capacity = request.getParameter("quantity");
  String hotel = request.getParameter("hotel");
  String from_date = request.getParameter("from_date");
  String to_date = request.getParameter("to_date"); 

  // Last Name
  if(last_name.length() >25){
    response.sendRedirect("error.html");
  }
  values = values + "Last_Name=\"" + last_name + "\" AND ";
  // First Name
  if(first_name.length() > 20){
    response.sendRedirect("error.html");
  }
  values = values + "First_Name=\"" + first_name + "\"";
  String query = check_customer + values;
  ResultSet rs = stmt.executeQuery(query);
  rs.next();

  if(rs.getInt("count(IRS_Number)") == 0){
    response.sendRedirect("customerreg.jsp");
  }
  else if(rs.getInt("count(IRS_Number)") > 1){
    response.sendRedirect("showirrs.jsp?first_name="+first_name + "&last_name=" + last_name);
  }
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
  query = "SELECT * FROM Hotels as H, Has_Hotels as HH, Reserves as R, Hotel_Room as HR WHERE H.Hotel_ID = R.Hotel_ID AND HR.Hotel_ID = R.Hotel_ID AND HH.Hotel_ID = H.Hotel_ID AND HR.Room_ID = R.Room_ID";
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
    <th>Hotel_ID</th>
    <th>Capacity</th>
    <th>View</th>
    <th>Price</th>
    <th>Amenities</th>
    <th>Book!</th>
  </tr>
  <tr>
      <c:forEach var="hotel" items="${result.rows}">
        <tr>
          <td><c:out value="${hotel.Hotel_ID}"/></td>
          <td><c:out value="${hotel.Capacity}"/></td>
          <td><c:out value="${hotel.View}"/></td>
          <td><c:out value="${hotel.Price}"/></td>
          <td><c:out value="${hotel.Amenities}"/></td>
          <form method="GET" action="confirmbook.jsp">
            <input type="hidden" name="room_id" value="${hotel.Room_ID}">
            <td class="but"><input type="submit" class="submit-emp" value=""></td>
          </form>
        </tr>
      </c:forEach>
  </tr>
</table>  

</body>
</html>
