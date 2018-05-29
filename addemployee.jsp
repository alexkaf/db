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
  <li><a href="manageemps.jsp">Back</a></li>
  <li><img class="logo" src="images/logo.png"></li>
</ul>
  <sql:setDataSource var = "snapshot" driver = "com.mysql.jdbc.Driver" url = "jdbc:mysql://localhost/ehotels?useSSL=false&useUnicode=true&useJDBCCompliantTimezoneShift=true&useLegacyDatetimeCode=false&serverTimezone=UTC" user = "ehotels"  password = "abcd"/>

  <sql:query dataSource = "${snapshot}" var = "result">
    SELECT DISTINCT Hotel_ID
    From Hotels
  </sql:query>

<div class="form_back">
    <form action="doaddemployee.jsp" method="GET">

    <ul class="form-style-1">
        <h1 class="form-intro">New Employee</h1>
        <li><label>IRS Number<span class="required">*</span></label><input type="text" name="irs" value="" placeholder="IRS Number" required/>&nbsp;</li>
        <li><label>Social Security Number<span class="required">*</span></label><input type="text" name="ssn" value="" placeholder="Social Security Number" required/>&nbsp;</li>
        <li><label>Full Name <span class="required">*</span></label><input type="text" name="first_name" value="" class="field-divided" placeholder="First Name" required />&nbsp;<input type="text" name="last_name" value="" class="field-divided" placeholder="Last Name" required /></li><br>
        <label>Hotel ID<span class="required">*</span> </label>
        <input list="hotels" class="field-long" name="Hotel_ID" value="${param.Hotel_ID}" placeholder="Hotel ID">
        <datalist id="hotels">
            <c:forEach var="room" items="${result.rows}">
                <option value="${room.Hotel_ID}"/>
            </c:forEach>
        </datalist>
        <li>
            <label>City</label>
            <input type="text" name="city" value="" class="field-long" placeholder="City" />
        </li>
        <li>
            <label><span>Address</span></label><input type="text" class="address-field" name="street" value="" placeholder="Street"/> <input type="text" class="address-field" name="number" value="" placeholder="Number"/> <input type="text" class="address-field" name="postal_code" value=""  placeholder="Postal Code"/>
        </li>
        <li>
            <input type="submit" value="Submit" />
        </li>
    </ul>
    </form>
</div>

</body>
</html>
