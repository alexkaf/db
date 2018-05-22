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
  String insert = "INSERT IGNORE INTO Employees";
  String attr = "";
  String val = "";
  int counter = 0;
  int flag = 0;
  Connection conn = DriverManager.getConnection(url,"ehotels", "abcd");
  Statement stmt = conn.createStatement();
  String irs = request.getParameter("irs");
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
      attr = attr + " (IRS_Number";
      val = val + "(\'" + irs + "\'";
      counter = counter + 1;
    }else{
      attr = attr + ",IRS_Number";
      val = val + ",\'" + irs + "\'";
    }
  }else{
    flag = 1;
  } 
  if(ssn.length() <= 10){
    if(counter == 0){
      attr = attr + " (Social_Security_Number";
      val = val + "(\'" + ssn + "\'";
      counter = counter + 1;
    }else{
      attr = attr + ",Social_Security_Number";
      val = val + ",\'" + ssn + "\'";    
    }
  }else{
    flag = 1;
  }
  if(first_name.length() <= 20){
    if(counter == 0){
      attr = attr + " (First_Name";
      val = val + "(\'" + first_name + "\'";    
      counter = counter + 1;
    }else{
      attr = attr + ",First_Name";
      val = val + ",\'" + first_name + "\'";    
    }
  }else{
    flag = 1;
  }
  if(last_name.length() <= 25){
    if(counter == 0){
      attr = attr + " (Last_Name";
      val = val + "(\'" + last_name + "\'"; 
    }else{
      attr = attr + ",Last_Name";
      val = val + ",\'" + last_name + "\'";  
    }
  }else{
    flag = 1;
  }
  if(street.length() <= 25 && street.length() != 0){
    if(counter == 0){
      attr = attr + " (Street";
      val = val + "(\'" + street + "\'"; 
      counter = counter + 1;
    }else{
      attr = attr + ",Street";
      val = val + ",\'" + street + "\'";
    }
  }else{
    flag = 1;
  }
  if(number.length() <= 3 && number.length() != 0){
    if(counter == 0){
      attr = attr + " (Number";
      val = val + "(\'" + number + "\'"; 
      counter = counter + 1;
    }else{
      attr = attr + ",Number";
      val = val + ",\'" + number + "\'";
    }
  }else{
    flag = 1;
  }
  if(postal_code.length() <= 5 && postal_code.length() != 0){
    if(counter == 0){
      attr = attr + " (Postal_Code";
      val = val + "(\'" + postal_code + "\'";
      counter = counter + 1;
    }else{
      attr = attr + ",Postal_Code";
      val = val + ",\'" + postal_code + "\'";
    }
  }else{
    flag = 1;
  }
  if(city.length() <= 25 && city.length() != 0){
    if(counter == 0){
      attr = attr + " (City";
      val = val + "(\'" + city + "\'";
      counter = counter + 1;
    }else{
      attr = attr + ",City";
      val = val + ",\'" + city + "\'";
    }
  }else{
    flag = 1;
  }
  String query = "";
  if(!val.equals("")){
    query = insert + attr + ")" + " VALUES " + val + ")";
  }

  PreparedStatement prpstmt = conn.prepareStatement(query);
  int i = prpstmt.executeUpdate(query);
  %>  

  <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver" url = "jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC" user = "ehotels"  password = "abcd"/>

  <sql:query dataSource = "${snapshot}" var = "result">
    SELECT * 
    FROM Employees
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