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
  <li class="active-nav"><a href="managerdb.html">Manager Mode</a></li>
  <li><a href="customerdb.html">Customer Mode</a></li>
  <li><a href="aboutdb.html">About</a></li>
  <li><a href="managerooms.jsp">Back</a></li>
  <li><img class="logo" src="images/logo.png"></li>
</ul>
  <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver" url = "jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC" user = "ehotels"  password = "abcd"/>

  <sql:query dataSource = "${snapshot}" var = "result">
    SELECT DISTINCT Hotel_ID
    From Hotels
  </sql:query>

<div class="form_back">
    <form action="insertnewroom.jsp" method="GET">

    <ul class="form-style-1">
        <h1 class="form-intro">Room New Information</h1>

        <li>
            <label>Hotel ID<span class="required">*</span> </label>
            <input list="hotels" class="field-long" name="Hotel_ID" value="${param.Hotel_ID}" placeholder="Hotel ID">
            <datalist id="hotels">
                <c:forEach var="room" items="${result.rows}">
                    <option value="${room.Hotel_ID}"/>
                </c:forEach>
            </datalist>
        </li>

        <li>
            <label>Repairs Need</label>
            <input type="text" name="Repairs_Need" class="field-long" placeholder="${param.Repairs_Need}" />
        </li>
        <li>
            <label>Expandable</label>
            <input type="text" name="Expandable" class="field-long" placeholder="${param.Expandable}" />
        </li>
        <li>
            <label>View</label>
            <input type="text" name="View" class="field-divided" placeholder="${param.View}" />
        </li>
        <li>
            <label>Capacity</label>
            <input type="text" name="Capacity" class="field-divided" placeholder="${param.Cpacity}" >
        </li>
        <li>
            <label>Price <span class="required">*</span></label>
            <input type="text" name="Price" class="field-divided" placeholder="${param.Price}" required>&nbsp;
        </li>

        <li>
            <label><span>Amenities</span></label>
            <input type="text" class="field-long" name="Amenities" value="${param.Amenities}" placeholder="${param.Amenities}"/>
        </li>
        <li>
            <input type="submit" value="Submit" />
        </li>
    </ul>
    </form>
</div>

</body>
</html>
