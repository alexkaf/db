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
      <li><a href="addemployee.jsp">Add a new Hotel</a></li>
      <li><a href="manage.jsp">Back</a></li>
      <li><img class="logo" src="images/logo.png"></li>
    </ul>

<%
  Class.forName("com.mysql.jdbc.Driver");
  String url ="jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
  String update = "UPDATE Hotels";
  String set = "";
  int counter = 0;
  int flag = 0;
  Connection conn = DriverManager.getConnection(url,"ehotels", "abcd");
  Statement stmt = conn.createStatement();
  String hotel_id = request.getParameter("hotel_id");
  String stars = request.getParameter("stars");
  String email = request.getParameter("email");
  String number_rooms = request.getParameter("number-of-rooms");
  String city = request.getParameter("city");
  String street = request.getParameter("street");
  String number = request.getParameter("number");
  String postal_code = request.getParameter("postal_code");
  String phone_number = request.getParameter("phone_number");

  if(hotel_id.length() <= 6){
    if(counter == 0){
      set = set + " Set Hotel_ID=" + "\'" + hotel_id + "\'";
      counter = counter + 1;
    }else{
      set = set + ",Hotel_ID=" + "\'" + hotel_id + "\'";
    }
  }else{
    flag = 1;
  }
  if(number_rooms.length() <= 3){
    if(counter == 0){
      set = set + " Set Number_Of_rooms=" + "\'" + number_rooms+ "\'";
      counter = counter + 1;
    }else{
      set = set + ",Number_Of_rooms="+ "\'" + number_rooms+ "\'";
    }
  }else{
    flag = 1;
  }
  if(stars.length() <= 1){
    if(counter == 0){
      set = set + " Set Stars="+ "\'"  + stars + "\'";
      counter = counter + 1;
    }else{
      set = set + ",Stars="+ "\'" +  stars+ "\'";
    }
  }else{
    flag = 1;
  }
  if(email.length() <= 50){
    if(counter == 0){
      set = set + " Set Email=" + "\'" + email + "\'";
      counter = counter + 1;
    }else{
      set = set + ",Email=" + "\'" + email + "\'";
    }
  }else{
    flag = 1;
  }
  if(street.length() <= 25){
    if(counter == 0){
      set = set + " Set Street=" + "\'" + street + "\'";
      counter = counter + 1;
    }else{
      set = set + ",Street=" + "\'" + street + "\'";
    }
  }else{
    flag = 1;
  }
  if(number.length() <= 3){
    if(counter == 0){
      set = set + " Set Number="+ "\'"  + number+ "\'";
      counter = counter + 1;
    }else{
      set = set + ",Number="+ "\'" +  number+ "\'";
    }
  }else{
    flag = 1;
  }
  if(postal_code.length() <= 5){
    if(counter == 0){
      set = set + " Set Postal_Code="+"\'" + postal_code + "\'";
      counter = counter + 1;
    }else{
    set = set + ",Postal_Code=" + "\'" + postal_code+ "\'" ;
    }
  }else{
    flag = 1;
  }
  if(city.length() <= 30){
    if(counter == 0){
      set = set + " Set City=" + "\'" + city + "\'";
      counter = counter + 1;
    }else{
    set = set + ",City=" + "\'" + city + "\'";
    }
  }else{
    flag = 1;
  }

  if(phone_number.length() <= 55){
    if(counter == 0){
      set = set + " Set Phone_Number=" + "\'" + phone_number + "\'";
      counter = counter + 1;
    }else{
      set = set + ",Phone_Number=" + "\'" + phone_number + "\'";
    }
  }else{
    flag = 1;
  }


  String where = " WHERE Hotel_ID=" + hotel_id;
  String query = update + set + where;
  PreparedStatement prpstmt = conn.prepareStatement(query);
  int i = prpstmt.executeUpdate(query);
  %>

  <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver" url = "jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC" user = "ehotels"  password = "abcd"/>

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
