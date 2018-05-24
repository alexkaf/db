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

<div class="form_back">
    <form action="insertnewroom.jsp" method="GET">

    <ul class="form-style-1">
        <h1 class="form-intro">Room New Information</h1>

        <li>
            <label>Hotel ID<span class="required">*</span> </label>
            <input type="text" name="Hotel_ID" class="field-long" placeholder="${param.Hotel_ID}" required>&nbsp;
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
