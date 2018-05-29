<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import = "java.io.*,java.util.*,java.sql.*"%>
<%@ page import = "javax.servlet.http.*,javax.servlet.*" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix = "c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix = "sql"%>
<%@ page session="true" %>
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
  <li><a href="customerdb.html">Back</a></li>
  <li><img class="logo" src="images/logo.png"></li>
</ul>

  <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver" url = "jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC" user = "ehotels"  password = "abcd"/>

  <sql:query dataSource = "${snapshot}" var = "result">
    SELECT DISTINCT City
    From Hotels
  </sql:query>

<div class="form_back">
    <form action="available_rooms.jsp" method="GET">
    <ul class="form-style-1">

        <h1 class="book-form">Booking preferences</h1>
        <li>
            <label><span>Region of Interest</span></label>
                <input list="cities" class="field-long" name="cities" value="${param.booknow_city}" placeholder="${param.booknow_city}">
                <datalist id="cities">
                    <c:forEach var="room" items="${result.rows}">
                        <option value="${room.City}"/>
                    </c:forEach>
                </datalist>
        </li>
        <li>
            <label><span>Category </span></label>
                <ul class="radios">
                    1
                    <input type="radio" name="stars" value="1">
                    2
                    <input type="radio" name="stars" value="2">
                    3
                    <input type="radio" name="stars" value="3">
                    4
                    <input type="radio" name="stars" value="4">
                    5
                    <input type="radio" name="stars" value="5">
                </ul>
        </li>
        <li>
            <label><span>Price per day</span></label>
            <div class="slidecontainer">
              <label><span>0</span></label><input type="range" min="0" max="50" value="28" class="slider" name="price" id="price"><label><span>50</span></label>
            </div>
        </li>
        <li>
            <label><span>Capacity</span></label>
            <input type="number" name="quantity" min="1" max="5">
        </li>
      <sql:query dataSource = "${snapshot}" var = "result">
        SELECT DISTINCT Hotel_Group_ID
        From Hotel_Group
      </sql:query>
        <li>
            <label><span>Hotel Group</span></label>
            <select name="hotel" size="1">
                 <c:forEach var="room" items="${result.rows}">
                    <option value="${room.Hotel_Group_ID}"/><c:out value="${room.Hotel_Group_ID}"/></option>
                </c:forEach>
                <option value="0">All</option>
            </select>
        </li>
        <li>
            <label>Book from <span class="required">*</span> </label>
            <input type="date" name="from_date" class="field-long" value="${param.from_date}" placeholder="From" required>&nbsp;
        </li>
        <li>
            <label>To <span class="required">*</span> </label>
            <input type="date" name="to_date" class="field-long" placeholder="To" required>&nbsp;
        </li>
        <li>
          <input type="hidden" name="IRS_Number" value="${param.IRS_Number}">
          <input type="hidden" name="First_Name" value="${param.First_Name}">
          <input type="hidden" name="Last_Name" value="${param.Last_Name}">
            
            <input type="submit" value="Submit" />
        </li>
    </ul>
    </form>
</div>

</body>
</html>
