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
  <li><a href="newbookform.html">Back</a></li>
  <li><img class="logo" src="images/logo.png"></li>
</ul>

<div class="form_back">
    <form action="nowinsert_customer.jsp" method="GET">
    <ul class="form-style-1">
        <h1 class="form-intro">Please fill your info for registration</h1>
        <li><label>IRS Number<span class="required">*</span></label><input type="text" name="irs_number" placeholder="IRS Number" required>&nbsp;</li>
        <li>
            <label>Social Security Number<span class="required">*</span></label>
            <input type="text" name="ssn" class="field-long" placeholder="Social Security Number" required />
        </li>
        <li><label>Full Name <span class="required">*</span></label><input type="text" name="first_name" class="field-divided" placeholder="First" required>&nbsp;<input type="text" name="last_name" class="field-divided" placeholder="Last" required></li>
        <li>
            <label>City</label>
            <input type="text" name="city" class="field-long" placeholder="City" />
        </li>
        <li>
            <label><span>Address</span></label><input type="text" class="address-field" name="street" placeholder="Street"/> <input type="text" class="address-field" name="number" placeholder="Number"/> <input type="text" class="address-field" name="postal_code" placeholder="Postal Code"/>
        </li>

        <li>
            <input type="hidden" name="booknow_city" value="${param.booknow_city}"/>
            <input type="submit" value="Submit" />
        </li>
      </ul>
      </form>
  </div>

  </body>
  </html>
