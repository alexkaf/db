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
  <li><a href="managehotels.jsp">Back</a></li>
  <li><img class="logo" src="images/logo.png"></li>
</ul>


<%
  Class.forName("com.mysql.jdbc.Driver");
  String url ="jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
  Connection conn = DriverManager.getConnection(url,"ehotels", "abcd");
  /***********************FOR UPDATE**************************/
  Statement stmt = conn.createStatement();
  String Hotel_ID = request.getParameter("hotel_id");
  String City = request.getParameter("city");
  String Stars = request.getParameter("stars");
  String Street = request.getParameter("street");
  String Number = request.getParameter("number");
  String Postal_Code = request.getParameter("postal_code");
  String Number_of_rooms = request.getParameter("number-of-rooms");
  String Phone_number = request.getParameter("phone_number");
  String Email = request.getParameter("email");

  String query_Hotels = "UPDATE Hotels SET Number_Of_Rooms=";


  if(Hotel_ID.length() != 6){
    response.sendRedirect("error.html");
  }

  query_Hotels = query_Hotels+"'"+Number_of_rooms+"'";

   if(!City.equals("")){
     if(City.length() > 30){
       response.sendRedirect("error.html");
     }
     query_Hotels = query_Hotels+", City="+"'"+City+"'";
   }

   if(!Stars.equals("")){
     query_Hotels = query_Hotels+", Stars="+"'"+Stars+"'";
   }

   if(!Street.equals("")){
     if(Street.length() > 25){
       response.sendRedirect("error.html");
     }
     query_Hotels = query_Hotels+", Street="+"'"+Street+"'";
   }

   if(!Number.equals("")){
     if(Number.length() > 3){
       response.sendRedirect("error.html");
     }
     query_Hotels = query_Hotels+", Number="+"'"+Number+"'";
   }

   if(!Postal_Code.equals("")){
     if(Postal_Code.length() > 5){
       response.sendRedirect("error.html");
     }
     query_Hotels = query_Hotels+", Postal_Code="+"'"+Postal_Code+"'";
   }


   if(!Phone_number.equals("")){
     query_Hotels = query_Hotels+", Phone_Number="+"'"+Phone_number+"'";
   }

   if(!Email.equals("")){
     query_Hotels = query_Hotels+", Email="+"'"+Email+"'";
   }

   query_Hotels = query_Hotels + " WHERE Hotel_ID="+Hotel_ID;
  %>

  <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver" url = "jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC" user = "ehotels"  password = "abcd"/>

  <sql:query dataSource = "${snapshot}" var = "result">
    <% out.print(query_Hotels); %> ;
  </sql:query>

  <table class="customer-rents">
  <tr>
    <th>Hotel_ID</th>
  </tr>
  <tr>
      <c:forEach var="hotel" items="${result.rows}">
        <tr>
          <td><c:out value="${hotel.Hotel_ID}"/></td>
        </tr>
      </c:forEach>
  </tr>
</table>

  </body>
  </html>
