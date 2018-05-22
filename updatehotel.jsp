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
    <form action="doupdatehotels.jsp" method="GET">

    <ul class="form-style-1">
        <h1 class="form-intro">Hotel New Information</h1>
        <li><label>Hotel ID<span class="required">*</span></label><input type="text" name="hotel_id" value="${param.hotel_id}" placeholder="${param.hotel_id}" required>&nbsp;</li>
        <li>
            <label>City</label>
            <input type="text" name="city" class="field-long" value="${param.city}" placeholder="${param.city}" />
        </li>
        <li>
            <label><span>Address</span></label> <input type="text" class="address-field" name="street" value="${param.street}" placeholder="${param.street}"/> <input type="text" class="address-field" name="number" value="${param.number}" placeholder="${param.number}"/>
             <input type="text" class="address-field" name="postal_code" value="${param.postal_code}" placeholder="${param.postal_code}"/>
        </li>
        <li>
            <label>Stars</label>
            <input type="text" name="stars" class="field-divided" value="${param.stars}" placeholder="${param.stars}" />
        </li>
        <li>
            <label>Number Of Rooms<span class="required">*</span></label>
            <input type="text" name="number-of-rooms" class="field-divided" value="${param.number-of-rooms}" placeholder="${param.number-of-rooms}" required>
        </li>
        <li>
            <label>Phone Number</label>
            <input type="text" name="phone_number" class="field-long" value="${param.phone_number}" placeholder="${param.phone_number}" />
        </li>
        <li>
            <label>Email</label>
            <input type="text" name="email" class="field-long" value="${param.email}" placeholder="${param.email}" />
        </li>
        <li>

            <input type="submit" value="Submit" />
        </li>
    </ul>
    </form>
</div>

</body>
</html>
