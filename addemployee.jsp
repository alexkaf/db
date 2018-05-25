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

<div class="form_back">
    <form action="doaddemployee.jsp" method="GET">

    <ul class="form-style-1">
        <h1 class="form-intro">New Employee</h1>
        <li><label>IRS Number<span class="required">*</span></label><input type="text" name="irs" value="" placeholder="IRS Number" required/>&nbsp;</li>
        <li><label>Social Security Number<span class="required">*</span></label><input type="text" name="ssn" value="" placeholder="Social Security Number" required/>&nbsp;</li>
        <li><label>Full Name <span class="required">*</span></label><input type="text" name="first_name" value="" class="field-divided" placeholder="First Name" required />&nbsp;<input type="text" name="last_name" value="" class="field-divided" placeholder="Last Name" required /></li>
        <li><label>Works At Hotel<span class="required">*</span></label><input type="text" name="works_at" value="" placeholder="works_at" required/>&nbsp;</li>
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
