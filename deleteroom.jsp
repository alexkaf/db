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
    <li class="active-nav"><a href="managerdb.html">Manager Mode</a></li>
    <li><a href="customerdb.html">Customer Mode</a></li>
    <li><a href="aboutdb.html">About</a></li>
    <li><a href="managerooms.jsp">Back</a></li>
    <li><img class="logo" src="images/logo.png"></li>
  </ul>

  <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver" url = "jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC" user = "ehotels"  password = "abcd"/>

  <c:set var = "Room_ID" value = "${param.Room_ID}"/>
  <c:set var = "Hotel_ID" value = "${param.Hotel_ID}"/>

  <sql:update dataSource = "${snapshot}" var = "Room_ID">
     DELETE FROM Hotel_Room WHERE Room_ID = ? AND Hotel_ID = ?
     <sql:param value = "${Room_ID}" />
     <sql:param value = "${Hotel_ID}" />
  </sql:update>

<%
Class.forName("com.mysql.jdbc.Driver");
String url ="jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
Connection conn = DriverManager.getConnection(url,"ehotels", "abcd");
Statement stmt = conn.createStatement();

String Hotel_ID = request.getParameter("Hotel_ID");
String query="SELECT Number_Of_Rooms FROM Hotels WHERE Hotel_ID="+Hotel_ID;
ResultSet rs = stmt.executeQuery(query);
int num_of_rooms=0;

if(rs.next()){
  num_of_rooms = rs.getInt("Number_Of_Rooms")-1;
}

query = "UPDATE  Hotels SET Number_Of_Rooms=\'"+num_of_rooms+"\'" +" WHERE Hotel_ID=\'"+Hotel_ID+"\'" ;
PreparedStatement prpstmt = conn.prepareStatement(query);
int i = prpstmt.executeUpdate(query);
response.sendRedirect("managerooms.jsp");
%>

</body>
</html>
