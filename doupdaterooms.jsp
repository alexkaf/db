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
      <li><a href="addroom.jsp">Add a new Room</a></li>
      <li><a href="manage.jsp">Back</a></li>
      <li><img class="logo" src="images/logo.png"></li>
    </ul>

<%
  Class.forName("com.mysql.jdbc.Driver");
  String url ="jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
  String update = "UPDATE Hotel_Room";
  String set = "";
  int counter = 0;
  int flag = 0;
  Connection conn = DriverManager.getConnection(url,"ehotels", "abcd");
  Statement stmt = conn.createStatement();
  String Room_ID = request.getParameter("Room_ID");
  String Hotel_ID = request.getParameter("Hotel_ID");
  String Price = request.getParameter("Price");
  String Repairs_Need = request.getParameter("Repairs_Need");
  String Expandable = request.getParameter("Expandable");
  String Capacity = request.getParameter("Capacity");
  String View = request.getParameter("View");
  String Amenities= request.getParameter("Amenities");

  if(Hotel_ID.length() <= 6){
    if(counter == 0){
      set = set + " Set Hotel_ID=" + "\'" +Hotel_ID + "\'";
      counter = counter + 1;
    }else{
      set = set + ",Hotel_ID=" + "\'" + Hotel_ID + "\'";
    }
  }else{
    flag = 1;
  }

  if(Room_ID.length() <= 5){
    if(counter == 0){
      set = set + " Set Room_ID=" + "\'" + Room_ID + "\'";
      counter = counter + 1;
    }else{
      set = set + ",Room_ID=" + "\'" + Room_ID + "\'";
    }
  }else{
    flag = 1;
  }


  if(Repairs_Need.length() <= 20){
    if(counter == 0){
      set = set + " Set Repairs_Need=" + "\'" + Repairs_Need+ "\'";
      counter = counter + 1;
    }else{
      set = set + ",Repairs_Need="+ "\'" + Repairs_Need+ "\'";
    }
  }else{
    flag = 1;
  }
  if(Expandable.length() <= 30){
    if(counter == 0){
      set = set + " Set Expandable="+ "\'"  + Expandable + "\'";
      counter = counter + 1;
    }else{
      set = set + ",Expandable="+ "\'" +  Expandable+ "\'";
    }
  }else{
    flag = 1;
  }
  if(View.length() <= 15){
    if(counter == 0){
      set = set + " Set View=" + "\'" + View + "\'";
      counter = counter + 1;
    }else{
      set = set + ",View=" + "\'" + View + "\'";
    }
  }else{
    flag = 1;
  }
  if(Capacity.length() <= 2){
    if(counter == 0){
      set = set + " Set Capacity=" + "\'" + Capacity + "\'";
      counter = counter + 1;
    }else{
      set = set + ",Capacity=" + "\'" + Capacity + "\'";
    }
  }else{
    flag = 1;
  }
  if(Amenities.length() <= 3){
    if(counter == 0){
      set = set + " Set Amenities="+ "\'"  + Amenities+ "\'";
      counter = counter + 1;
    }else{
      set = set + ",Amenities="+ "\'" +  Amenities+ "\'";
    }
  }else{
    flag = 1;
  }
  if(Price.length() <= 8){
    if(counter == 0){
      set = set + " Set Price="+"\'" + Price + "\'";
      counter = counter + 1;
    }else{
    set = set + ",Price=" + "\'" + Price+ "\'" ;
    }
  }else{
    flag = 1;
  }


  String where = " WHERE Hotel_ID=" + Hotel_ID+" AND Room_ID="+Room_ID;
  String query = update + set + where;
  PreparedStatement prpstmt = conn.prepareStatement(query);
  int i = prpstmt.executeUpdate(query);
  %>

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
