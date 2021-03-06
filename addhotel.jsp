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
  <li><a href="managehotels.jsp">Back</a></li>
  <li><img class="logo" src="images/logo.png"></li>
</ul>

<div class="form_back">
    <form action="insertnewhotel.jsp" method="GET">

    <ul class="form-style-1">
        <h1 class="form-intro">Hotel New Information</h1>

        <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver" url = "jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC" user = "ehotels"  password = "abcd"/>

        <sql:query dataSource = "${snapshot}" var = "result">
        SELECT DISTINCT Hotel_Group_ID
        From Hotel_Group
        </sql:query>
        <li>
            <label><span>Hotel Group</span></label>
            <select name="hotel_group" size="1">
                 <c:forEach var="room" items="${result.rows}">
                    <option value="${room.Hotel_Group_ID}"/><c:out value="${room.Hotel_Group_ID}"/></option>
                </c:forEach>
            </select>
        </li>

        <li><label>Hotel ID<span class="required">*</span></label><input type="text" name="hotel_id" placeholder="${param.hotel_id}" required>&nbsp;</li>
        <li>
            <label>City</label>
            <input type="text" name="city" class="field-long" placeholder="${param.city}" />
        </li>
        <li>
            <label><span>Address</span></label><input type="text" class="address-field" name="street" placeholder="Street"/> <input type="text" class="address-field" name="number" placeholder="Number"/> <input type="text" class="address-field" name="postal_code" placeholder="Postal Code"/>
        </li>
        <li>
            <label>Stars</label>
            <input type="text" name="stars" class="field-divided" placeholder="Stars" />
        </li>
        <li>
            <label>Number Of Rooms<span class="required">*</span></label>
            <input type="text" name="number-of-rooms" class="field-divided" placeholder="Rooms" required>
        </li>
        <li>
            <label>Phone Number</label>
            <input type="text" name="phone_number" class="field-long" placeholder="Phone Number" />
        </li>
        <li>
            <label>Email</label>
            <input type="text" name="email" class="field-long" placeholder="Email" />
        </li>
        <li>
            <input type="submit" value="Submit" />
        </li>
    </ul>
    </form>
</div>

</body>
</html>
