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
  <li class="active-nav"><a href="customerdb.html">Customer Mode</a></li>
  <li><a href="aboutdb.html">About</a></li>
  <li><a href="manageemps.jsp">Back</a></li>
  <li><img class="logo" src="images/logo.png"></li>
</ul>

<div class="form_back">
    <form action="doupdatecustomer.jsp" method="GET">

    <ul class="form-style-1">
        <h1 class="form-intro">Customer New Information</h1>
        <li><label>IRS Number<span class="required">*</span></label><input type="text" name="irs_number" value="${param.irs}" placeholder="${param.irs}" required/>&nbsp;</li>
        <li><label>Social Security Number<span class="required">*</span></label><input type="text" name="ssn" value="${param.ssn}" placeholder="${param.ssn}" required/>&nbsp;</li>
        <li><label>Full Name <span class="required">*</span></label><input type="text" name="first_name" value="${param.first_name}" class="field-divided" placeholder="${param.first_name}" required/>&nbsp;<input type="text" name="last_name" value="${param.last_name}" class="field-divided" placeholder="${param.last_name}" required/></li>
        <li>
            <label>City</label>
            <input type="text" name="city" value="${param.city}" class="field-long" placeholder="${param.city}" />
        </li>
        <li>
            <label><span>Address</span></label><input type="text" class="address-field" name="street" value="${param.street}" placeholder="${param.street}"/> <input type="text" class="address-field" name="number" value="${param.number}"  placeholder="${param.number}"/> <input type="text" class="address-field" name="postal_code" value="${param.postal_code}" placeholder="${param.postal_code}"/>
        </li>
        <li>
            <input type="submit" value="Submit" />
        </li>
    </ul>
    </form>
</div>

</body>
</html>