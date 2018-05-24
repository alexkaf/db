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
      <li><a href="manage.jsp">Back</a></li>
      <li><img class="logo" src="images/logo.png"></li>
    </ul>



  <%
  Class.forName("com.mysql.jdbc.Driver");
  String url ="jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
  Connection conn = DriverManager.getConnection(url,"ehotels", "abcd");
  Statement stmt = conn.createStatement();

  String Hotel_Group_ID="aa";
  String Hotel_ID = request.getParameter("hotel_id");
  String query="SELECT Hotel_Group_ID FROM Has_Hotels WHERE Hotel_ID="+"\'"+Hotel_ID+"\'";
  ResultSet rs = stmt.executeQuery(query);
  if(rs.next()){
    Hotel_Group_ID = rs.getString("Hotel_Group_ID");
  }


  query="SELECT Number_Of_Hotels FROM Hotel_Group WHERE Hotel_Group_ID=\'"+Hotel_Group_ID+"\'";
  rs = stmt.executeQuery(query);
  int num_of_hotels=0;

  if(rs.next()){
    num_of_hotels = rs.getInt("Number_Of_Hotels")-1;
  }

  query = "UPDATE  Hotel_Group SET Number_Of_Hotels=\'"+num_of_hotels+"\'" +" WHERE Hotel_Group_ID=\'"+Hotel_Group_ID+"\'" ;
  PreparedStatement prpstmt = conn.prepareStatement(query);
  int i = prpstmt.executeUpdate(query);

  %>


  <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver" url = "jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC" user = "ehotels"  password = "abcd"/>

  <c:set var = "hotel_id" value = "${param.hotel_id}"/>

  <sql:update dataSource = "${snapshot}" var = "irs_number">
     DELETE FROM Hotels WHERE Hotel_ID = ?
     <sql:param value = "${hotel_id}" />
  </sql:update>
<% response.sendRedirect("managehotels.jsp"); %>

</body>
</html>
