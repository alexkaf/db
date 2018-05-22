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
      <li><a href="addemployee.jsp">Add a new Employee</a></li>
      <li><a href="manage.jsp">Back</a></li>
      <li><img class="logo" src="images/logo.png"></li>
    </ul>

<%
  Class.forName("com.mysql.jdbc.Driver");
  String url ="jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
  String update = "UPDATE Employees";
  String set = "";
  int counter = 0;
  int flag = 0;
  Connection conn = DriverManager.getConnection(url,"ehotels", "abcd");
  Statement stmt = conn.createStatement();
  String irs = request.getParameter("irs_number");
  String ssn = request.getParameter("ssn");
  String first_name = request.getParameter("first_name");
  String last_name = request.getParameter("last_name");
  String city = request.getParameter("city");
  String street = request.getParameter("street");
  String number = request.getParameter("number");
  String postal_code = request.getParameter("postal_code");
  // IRS_Number 
  if(irs.length() <= 10){
    if(counter == 0){
      set = set + " Set IRS_Number=" + "\'" + irs + "\'";
      counter = counter + 1;
    }else{
      set = set + ",IRS_Number=" + "\'" + irs + "\'";
    }
  }else{
    flag = 1;
  } 
  if(ssn.length() <= 10){
    if(counter == 0){
      set = set + " Set Social_Security_Number=" + "\'" + ssn + "\'";
      counter = counter + 1;
    }else{
      set = set + ",Social_Security_Number=" + "\'" + ssn + "\'";
    }
  }else{
    flag = 1;
  }
  if(first_name.length() <= 20){
    if(counter == 0){
      set = set + " Set First_Name=" + "\'" + first_name + "\'";
      counter = counter + 1;
    }else{
      set = set + ",First_Name=" + "\'" + first_name + "\'";
    }
  }else{
    flag = 1;
  }
  if(last_name.length() <= 25){
    if(counter == 0){
      set = set + " Set Last_Name=" + "\'" + last_name + "\'";
      counter = counter + 1;
    }else{
      set = set + ",Last_Name=" + "\'" + last_name + "\'";
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
      set = set + " Set Number=" + "\'" + number + "\'";
      counter = counter + 1;
    }else{
      set = set + ",Number=" + "\'" + number + "\'";
    }
  }else{
    flag = 1;
  }
  if(postal_code.length() <= 5){
    if(counter == 0){
      set = set + " Set Postal_Code=" + "\'" + postal_code + "\'";
      counter = counter + 1;
    }else{
    set = set + ",Postal_Code=" + "\'" + postal_code + "\'";
    }
  }else{
    flag = 1;
  }
  if(city.length() <= 25){
    if(counter == 0){
      set = set + " Set City=" + "\'" + city + "\'";
      counter = counter + 1;
    }else{
    set = set + ",City=" + "\'" + city + "\'";
    }
  }else{
    flag = 1;
  }
  String where = " WHERE IRS_Number=" + irs;
  String query = update + set + where;
  PreparedStatement prpstmt = conn.prepareStatement(query);
  int i = prpstmt.executeUpdate(query);
  %>  

  <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver" url = "jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC" user = "ehotels"  password = "abcd"/>

  <sql:query dataSource = "${snapshot}" var = "result">
    SELECT * 
    FROM Customers
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
        <tr class="rower">
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