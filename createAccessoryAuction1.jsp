<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<% boolean cookieChecker = false;
			Cookie[] Cookies = request.getCookies();
			
			if (Cookies != null){
				for (Cookie tempCookie : Cookies){
					if ("BuyMe.user".equals(tempCookie.getName())){
						cookieChecker = true;
						break;
					}
				}
			}
			if (!cookieChecker){
				response.sendRedirect("loginNoCookie.html");
			}
			%>
<a href="home.jsp">Home</a>
  <a href="auctions.jsp">Auctions</a>
  <a href="createAuction.jsp">Create an Auction</a>
  <a href="login.html">Logout</a>
	<form action="createAccessoryAuction.jsp">
	<h1>Create Auction</h1>
	<h2>Category: Accessories</h2>
  <p>
  
    <label><b>Title </b></label><br/>
    <input type="text" placeholder="Enter Title" name="title" required>
	<br/>
    <label for="desc"><b>Description </b></label><br/>
    <textarea rows="4" cols="50" name="desc" placeholder="Description"></textarea>
    <br/>
    <label><b>Type </b></label><br/>
    <select name="type">
  		<option value="belt">Belt</option>
  		<option value="scarf">Scarf</option>
  		<option value="hat">Hat</option>
  		<option value="jewlery">jewlery</option>
  		<option value="other">Other</option>
	</select>
    <br/>
	<label><b>Color </b></label><br/>
    <input type="text" placeholder="Enter Color" name="color" required>
	<br/>
	<label><b>Brand </b></label><br/>
    <input type="text" placeholder="Enter Brand" name="brand" required>
	<br/>
	<label><b>Condition </b></label><br/>
    <select name="condition">
        <option value="new">Brand New</option>
        <option value="usedlikenew">Used - Like New</option>
        <option value="usedgood">Used - Good</option>
        <option value="acceptable">Used - Acceptable</option>
    </select>
    <br/>
    <label><b>Material </b></label><br/>
    <input type="text" name="material" placeholder="Enter Material Type" maxlength="50" required>
    <br/>
    <label><b>Starting Price </b></label><br/>$
    <input type="text" name="startPriceDollar" size="5" maxlength="5" required>.<input type="text" name="startPriceCent" size="2" maxlength="2" required>
    <br/>
    <label><b>Minimum Bid Increment </b></label><br/>
    <select name="minBid">
    	<option value="0.50">$0.50</option>
        <option value="1.00">$1.00</option>
        <option value="1.50">$1.50</option>
        <option value="2.00">$2.00</option>
        <option value="2.50">$2.50</option>
    </select>
    <br/>
    <label><b>Minimum Sale Price </b></label><br/>$
    <input type="text" name="minPriceDollar" size="5" maxlength="5" required>.<input type="text" name="minPriceCent" size="2" maxlength="2" required>
    <br/>
    <label><b>End Date/Time (Time duration MUST be equal to or less than 30 days) </b></label><br/>
    Date(mm/dd/yyy): <input name="mm" placeholder="mm" size="2" type="text" maxlength="2" required>-<input name="dd" placeholder="dd" size="3" type="text" maxlength="2" required>-<input name="yyyy" placeholder="yyyy" size="4" type="text" maxlength="4" required> /
    24-Hour Time: <input name="hh" placeholder="hr" size="2" type="text" maxlength="2" required>:<input name="mi" placeholder="min" size="3" type="text" maxlength="2" required>
    <br/>
    
</p>
  <div style="background-color:#f1f1f1">
  	<button type="submit">Create</button>
    <a href="createAuction.jsp"><button type="button">Cancel</button></a>
  </div>
</form>
</body>
</html>