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
  String insert_vals = "INSERT IGNORE INTO Customer_Wants_To(";
  String values = "";
  Connection conn = DriverManager.getConnection(url,"ehotels", "abcd");
  /***********************FOR REGISTRATION**************************/
  Statement stmt = conn.createStatement();
  String irs = request.getParameter("irs_number");
  String ssn = request.getParameter("ssn");
  String first_name = request.getParameter("first_name");
  String last_name = request.getParameter("last_name");
  String city = request.getParameter("city");
  String street = request.getParameter("street");
  String number = request.getParameter("number");
  String postal_code = request.getParameter("postal_code");
  String reg_date = request.getParameter("reg_date");
  /***************************FOR BOOKING***************************/
  String cities = request.getParameter("cities");
  String stars = request.getParameter("stars");
  String price = request.getParameter("price");
  String capacity = request.getParameter("quantity");
  String hotel = request.getParameter("hotel");
  String from_date = request.getParameter("from_date");
  String to_date = request.getParameter("to_date"); 

  // IRS Number
  if(irs.length() != 10){
    response.sendRedirect("error.html");
  }
  insert_vals = insert_vals + "IRS_Number,";
  values = values + "VALUES ("+ "'" + irs + "',";
  // Last Name
  if(last_name.length() >25){
    response.sendRedirect("error.html");
  }
  insert_vals = insert_vals + "Last_Name,"; 
  values = values + "'" + last_name + "',";
  // First Name
  if(first_name.length() > 20){
    response.sendRedirect("error.html");
  }
  insert_vals = insert_vals + "First_Name";
  values = values + "'" + first_name + "'";
  // Street
  if(!street.equals("")){
    if(street.length() > 25){
      response.sendRedirect("error.html");
    }
  insert_vals = insert_vals + ",Street";
  values = values + "," + "'" + street + "'";
  }
  // Number
  if(!number.equals("")){
    if(number.length() > 3){
      response.sendRedirect("error.html");
    }
  insert_vals = insert_vals + ",Number";
  values = values + "," + "'" + number + "'";
  }
  // Postal Code
  if(!postal_code.equals("")){
    if(postal_code.length() > 5){
      response.sendRedirect("error.html");
    }
  insert_vals = insert_vals + ",Postal_Code";
  values = values + "," + "'" + postal_code + "'";
  }
  // City
  if(!city.equals("")){
    if(city.length() > 20){
      response.sendRedirect("error.html");
    }
  insert_vals = insert_vals + ",City";
  values = values + "," + "'" + city + "'";
  }
  // First Registration
  stmt = conn.createStatement();
  String sql = "Select CURDATE()";
  ResultSet rs = stmt.executeQuery(sql);
  rs.next();
  reg_date = rs.getString("CURDATE()");
  insert_vals = insert_vals + ",First_Registration";
  values = values + ",'" + reg_date + "'";
  // SSN
  if(ssn.length() != 10){
    response.sendRedirect("error.html");
  }
  insert_vals = insert_vals + ",Social_Security_Number)";
  values = values + ",'" + ssn + "')";

  String new_customer = insert_vals + " " + values;
  //out.println("<h1>" + new_customer +"</h1>");
  PreparedStatement prpstmt = conn.prepareStatement(new_customer);
  int i = prpstmt.executeUpdate(new_customer);
  // Now check for the correct room
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
  String query = "SELECT * FROM Hotels as H, Has_Hotels as HH, Reserves as R, Hotel_Room as HR WHERE H.Hotel_ID = R.Hotel_ID AND HR.Hotel_ID = R.Hotel_ID AND HH.Hotel_ID = H.Hotel_ID AND HR.Room_ID = R.Room_ID";
  if(!where.equals("")){
    query = query + " AND " + where;
    //out.println("<h1>"+ query +"</h1>");
  }
%>

  <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver" url = "jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC" user = "ehotels"  password = "abcd"/>

  <sql:query dataSource = "${snapshot}" var = "result">
    <% out.print(query); %> ;
  </sql:query>

  <table class="customer-rents">
  <tr>
    <th>Room_ID</th>
    <th>Book</th>
  </tr>
  <tr>
      <c:forEach var="hotel" items="${result.rows}">
        <tr>
          <td><c:out value="${hotel.Room_ID}"/></td>
          <form method="GET" action="bookroom.jsp">
            <input type="hidden" name="Room_ID" value="${room.Room_ID}">
            <td class="but"><input type="submit" class="submit-emp" value=""></td>
          </form>
        </tr>
      </c:forEach>
  </tr>
</table>  

</body>
</html>
