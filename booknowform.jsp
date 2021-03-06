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

<div class="form_back">
    <form action="makereservation.jsp" method="GET">
    <ul class="form-style-1">
        <h1 class="form-intro">Please fill your info and booking preferences</h1>
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
        <h1 class="book-form">Booking preferences</h1>
        <li>
            <label><span>Region of Interest</span></label>
                <input list="cities" class="field-long" name="cities" value="${param.booknow_city}" placeholder="${param.booknow_city}">
                <datalist id="cities">
                    <option value="Nauplio"></option>
                    <option value="Peiraias"></option>
                    <option value="Naxos"></option>
                    <option value="Amorgos"></option>
                    <option value="Rethimno"></option>
                    <option value="Skiathos"></option>
                    <option value="Athens"></option>
                    <option value="Thessaloniki"></option>
                    <option value="Leukada"></option>
                    <option value="Rodos"></option>
                    <option value="Xalkida"></option>
                    <option value="Alepoxori"></option>
                    <option value="Volos"></option>
                    <option value="Nea Makri"></option>
                    <option value="Marathonas"></option>
                    <option value="Karditsa"></option>
                    <option value="Santorini"></option>
                    <option value="Iraklio"></option>
                    <option value="Samothraki"></option>
                    <option value="Samothaki"></option>
                    <option value="Hania"></option>
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
        <li>
            <label><span>Hotel</span></label>
            <select name="hotel" size="1">
                <option value="12000">12000</option>
                <option value="13000">13000</option>
                <option value="16000">16000</option>
                <option value="17000">17000</option>
                <option value="19000">19000</option>
                <option value="0">All</option>
            </select>
        </li>
        <li>
            <label>Book from</label>
            <input type="date" name="from_date" class="field-long" placeholder="From" />
        </li>
        <li>
            <label>To</label>
            <input type="date" name="to_date" class="field-long" placeholder="To" />
        </li>
        <li>
            <input type="submit" value="Submit" />
        </li>
    </ul>
    </form>
</div>

</body>
</html>