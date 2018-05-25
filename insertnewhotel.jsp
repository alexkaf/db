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
  String insert1 = "SELECT COUNT(Hotel_Group_ID) FROM Hotel_Group WHERE Hotel_Group_ID=";
  int flag1=0;
  int counter1 = 0;
  Connection conn1 = DriverManager.getConnection(url1,"ehotels", "abcd");
  Statement stmt1 = conn1.createStatement();
  String Hotel_Group_ID1 = request.getParameter("hotel_group");
  if(Hotel_Group_ID1.length() <= 6){

    insert1 = insert1 +Hotel_Group_ID1 ;
    ResultSet rs1 = stmt1.executeQuery(insert1);

    if(rs1.next()){
      if(rs1.getString("COUNT(Hotel_Group_ID)").equals("0")) {
        response.sendRedirect("error.html");
      }

      else{

        insert1 = "SELECT COUNT(Hotel_ID) FROM Hotels WHERE Hotel_ID=";
        String Hotel_ID1 = request.getParameter("hotel_id");

        if(Hotel_ID1.length() <= 6){

          insert1 = insert1 +Hotel_ID1 ;
          rs1 = stmt1.executeQuery(insert1);

          if(rs1.next()){
            if(rs1.getString("COUNT(Hotel_ID)").equals("1")) {
              //mi egkiro Hotel_ID afou iparxei idi!!
              response.sendRedirect("error.html");
            }
            else{
              Class.forName("com.mysql.jdbc.Driver");
              String url ="jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC";
              String insert = "INSERT INTO Hotels";
              String attr = "";
              String val = "";
              Connection conn = DriverManager.getConnection(url,"ehotels", "abcd");
              Statement stmt = conn.createStatement();

              String Hotel_Group_ID = request.getParameter("hotel_group");
              String Hotel_ID = request.getParameter("hotel_id");
              String City = request.getParameter("city");
              String Street = request.getParameter("street");
              String Number = request.getParameter("number");
              String Postal_Code = request.getParameter("postal_code");
              String Number_Of_Rooms = request.getParameter("number-of-rooms");
              String Stars = request.getParameter("stars");
              String Phone_Number = request.getParameter("phone_number");
              String Email = request.getParameter("email");

                  attr = attr + " (Hotel_ID";
                  val = val + "(\'" + Hotel_ID + "\'";


                if(City.length() <= 30){
                    attr = attr + ",City";
                    val = val + ",\'" + City + "\'";
                }

                if(Street.length() <= 25){
                    attr = attr + ",Street";
                    val = val + ",\'" + Street + "\'";
                }

                if(Number.equals("")){
                  attr = attr + ",Number";
                  val = val + "," + "NULL" ;
                }
                else if(Number.length() <= 3){
                    attr = attr + ",Number";
                    val = val + ",\'" + Number + "\'";
                  }

                if (Postal_Code.equals("")){
                  attr = attr + ",Postal_Code";
                  val = val + ",NULL"  ;
                }
                else if(Postal_Code.length() <= 5 ){
                    attr = attr + "Postal_Code";
                    val = val + "," + Postal_Code ;
                  }

                if(Number_Of_Rooms.length() <= 3 ){
                    attr = attr + ",Number_Of_Rooms";
                    val = val + ",\'" + Number_Of_Rooms + "\'";
                  }

                  if (Stars.equals("")){
                    attr = attr + ",Stars";
                    val = val + ",NULL"  ;
                  }
                  else if(Stars.length() <= 1 ){
                    attr = attr + ",Stars";
                    val = val + "," + Stars ;
                  }

                  if(Phone_Number.length() <= 55 ){
                      attr = attr + ",Phone_Number";
                      val = val + ",\'" + Phone_Number + "\'";
                  }

                  if(Email.length() <= 50 ){
                      attr = attr + ",Email";
                      val = val + ",\'" + Email + "\'";
                  }



                String query = "";
                if(!val.equals("")){
                  query = insert + attr + ")" + " VALUES " + val + ");";
                }


                PreparedStatement prpstmt = conn.prepareStatement(query);
                int i = prpstmt.executeUpdate(query);



                String query3 = "INSERT INTO Has_Hotels (Hotel_Group_ID,Hotel_ID) VALUES ("+Hotel_Group_ID+","+Hotel_ID+")" ;
                PreparedStatement prpstmt3 = conn.prepareStatement(query3);
                int i3 = prpstmt3.executeUpdate(query3);

                int num_of_hotels=0;
                String query2 = "SELECT * From Hotel_Group Where Hotel_Group_ID="+Hotel_Group_ID;
                Connection conn2 = DriverManager.getConnection(url,"ehotels", "abcd");
                Statement stmt2 = conn2.createStatement();
                ResultSet rs2 = stmt2.executeQuery(query2);
                if(rs2.next()){
                  num_of_hotels= rs2.getInt("Number_Of_Hotels")+1;
                }

                query3 = "UPDATE  Hotel_Group SET Number_Of_Hotels=\'"+num_of_hotels+"\'" +" WHERE Hotel_Group_ID=\'"+Hotel_Group_ID+"\'" ;


                prpstmt3 = conn.prepareStatement(query3);
                i3 = prpstmt3.executeUpdate(query3);

                String query4="INSERT INTO Hotel_Room (Hotel_ID,Price) VALUES ("+Hotel_ID+",0)";

                String max_Room_ID="";
                String query5 = "SELECT MAX(Room_ID) From Hotel_Room";
                String query6 = "";
                stmt2 = conn2.createStatement();


                for (int j=1;j<=Integer.parseInt(Number_Of_Rooms);j++ ) {
                  prpstmt3 = conn.prepareStatement(query4);
                  i3 = prpstmt3.executeUpdate(query4);

                  rs2 = stmt2.executeQuery(query5);
                  if(rs2.next()){
                    max_Room_ID = rs2.getString("MAX(Room_ID)");
                  }
                  query6="INSERT INTO Has_Room (Hotel_ID,Room_ID) VALUES ("+Hotel_ID+","+max_Room_ID+")" ;
                  prpstmt3 = conn.prepareStatement(query6);
                  i3 = prpstmt3.executeUpdate(query6);


                }

                response.sendRedirect("managerdb.html");
            }
          }
      }
      else{//mi egkiro Hotel_ID pairnaei ta 6 grammata
        response.sendRedirect("error.html");
      }
    }
  }
}
else {//mi egkiro Hotel_Group_ID pairnaei ta 6 grammata
    response.sendRedirect("error.html");
}

%>




</body>
</html>
