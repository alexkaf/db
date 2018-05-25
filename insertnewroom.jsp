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
  <li><a href="managerdb.html" class="active-nav">Manager Mode</a></li>
  <li><a href="customerdb.html" >Customer Mode</a></li>
  <li><a href="aboutdb.html">About</a></li>
  <li><a href="addroom.jsp">Back</a></li>
  <li><img class="logo" src="images/logo.png"></li>
</ul>

<%
  Class.forName("com.mysql.jdbc.Driver");
  String url1 ="jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
  String insert1 = "SELECT COUNT(Hotel_ID) FROM Hotels WHERE Hotel_ID=";
  int flag1=0;
  int counter1 = 0;
  Connection conn1 = DriverManager.getConnection(url1,"ehotels", "abcd");
  Statement stmt1 = conn1.createStatement();
  String Hotel_ID1 = request.getParameter("Hotel_ID");
  if(Hotel_ID1.length() <= 6){

    insert1 = insert1 +Hotel_ID1 ;
    ResultSet rs1 = stmt1.executeQuery(insert1);

    if(rs1.next()){
      if(rs1.getString("COUNT(Hotel_ID)").equals("0")) {
        response.sendRedirect("error.html");
      }

    else{

      Class.forName("com.mysql.jdbc.Driver");
      String url ="jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
      String insert = "INSERT INTO Hotel_Room";
      String attr = "";
      String val = "";
      Connection conn = DriverManager.getConnection(url,"ehotels", "abcd");
      Statement stmt = conn.createStatement();
      String Hotel_ID = request.getParameter("Hotel_ID");
      String Repairs_Need = request.getParameter("Repairs_Need");
      String Expandable = request.getParameter("Expandable");
      String View = request.getParameter("View");
      String Capacity = request.getParameter("Capacity");
      String Amenities = request.getParameter("Amenities");
      String Price = request.getParameter("Price");



      if(Hotel_ID.length() <= 6){
          attr = attr + " (Hotel_ID";
          val = val + "(\'" + Hotel_ID + "\'";
      }

        if(Repairs_Need.length() <= 20){
            attr = attr + ",Repairs_Need";
            val = val + ",\'" + Repairs_Need + "\'";
        }

        if(Expandable.length() <= 30){
            attr = attr + ",Expandable";
            val = val + ",\'" + Expandable + "\'";
        }


        if(View.length() <= 15){
            attr = attr + ",View";
            val = val + ",\'" + View + "\'";
          }

        if (Capacity.equals("")){
          attr = attr + ",Capacity";
          val = val + ",NULL"  ;
        }
        else if(Capacity.length() <= 2 ){
            attr = attr + ",Capacity";
            val = val + "," + Capacity ;
          }

        if(Price.length() <= 7 ){
            attr = attr + ",Price";
            val = val + ",\'" + Price + "\'";
          }

          if(Amenities.length() <= 10 ){
              attr = attr + ",Amenities";
              val = val + ",\'" + Amenities + "\'";
            }



        String query = "";
        if(!val.equals("")){
          query = insert + attr + ")" + " VALUES " + val + ");";
        }


        PreparedStatement prpstmt = conn.prepareStatement(query);
        int i = prpstmt.executeUpdate(query);

        String max_Room_ID="";
        String query2 = "SELECT MAX(Room_ID) From Hotel_Room Where Hotel_ID="+Hotel_ID;
        Connection conn2 = DriverManager.getConnection(url,"ehotels", "abcd");
        Statement stmt2 = conn2.createStatement();
        ResultSet rs2 = stmt2.executeQuery(query2);

        if(rs2.next()){
          max_Room_ID = rs2.getString("MAX(Room_ID)");
        }


        String query3 = "INSERT INTO Has_Room (Hotel_ID,Room_ID) VALUES ("+Hotel_ID+","+max_Room_ID+")" ;
        PreparedStatement prpstmt3 = conn.prepareStatement(query3);
        int i3 = prpstmt3.executeUpdate(query3);

        int num_of_rooms=0;
        query2 = "SELECT * From Hotels Where Hotel_ID="+Hotel_ID;
        rs2 = stmt2.executeQuery(query2);
        if(rs2.next()){
          num_of_rooms = rs2.getInt("Number_Of_Rooms")+1;

        }

        query3 = "UPDATE  Hotels SET Number_Of_Rooms=\'"+num_of_rooms+"\'" +" WHERE Hotel_ID=\'"+Hotel_ID+"\'" ;
        
        prpstmt3 = conn.prepareStatement(query3);
        i3 = prpstmt3.executeUpdate(query3);

        response.sendRedirect("managerdb.html");
      }
    }
}
else {
    response.sendRedirect("error.html");
}

%>




</body>
</html>
