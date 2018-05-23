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
  <li><a href="newbookform.html">Back</a></li>
  <li><img class="logo" src="images/logo.png"></li>
</ul>

<%
  Class.forName("com.mysql.jdbc.Driver");
  String url1 ="jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
  String insert1 = "SELECT IRS_Number FROM Customers WHERE IRS_Number=";

  int counter1 = 0;
  Connection conn1 = DriverManager.getConnection(url1,"ehotels", "abcd");
  Statement stmt1 = conn1.createStatement();
  String irs1 = request.getParameter("irs_number");

  // IRS_Number
  if(irs1.length() <= 10){
    insert1 = insert1 + irs1 ;
    ResultSet rs1 = stmt1.executeQuery(insert1);
    rs1.next();
    if(rs1.next()){
      if(rs1.getString("IRS_Number").equals(irs1)){
        response.sendRedirect("error.jsp");
      }
    }
    Class.forName("com.mysql.jdbc.Driver");
    String url ="jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
    String insert = "INSERT IGNORE INTO Customers";
    String attr = "";
    String val = "";
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

    attr = attr+",First_Registration";
    val = val+",(SELECT CURDATE())";


    String query = "";
    if(!val.equals("")){
      query = insert + attr + ")" + " VALUES " + val + ")";
    }


    PreparedStatement prpstmt = conn.prepareStatement(query);
    int i = prpstmt.executeUpdate(query);
    response.sendRedirect("newbookform.html?booknow_city=" + request.getParameter("booknow_city"));
  }
  else if(irs1.length() > 10){
      response.sendRedirect("error.html");
  }
%>




</body>
</html>
