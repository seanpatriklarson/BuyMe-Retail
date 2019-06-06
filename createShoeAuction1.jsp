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
	<form action="createShoeAuction.jsp">
	<h1>Create Auction</h1>
	<h2>Category: Shoes</h2>
  <p>
  
    <label><b>Title </b></label><br/>
    <input type="text" placeholder="Enter Title" name="title" required>
	<br/>
    <label for="desc"><b>Description </b></label><br/>
    <textarea rows="4" cols="50" name="desc" placeholder="Description"></textarea>
    <br/>
    <label><b>Type </b></label><br/>
    <select name="type">
  		<option value="sneakers">Sneakers</option>
  		<option value="boots">Boots</option>
  		<option value="formal">Formal</option>
  		<option value="Other">Other</option>
	</select>
	<br/>
	<label><b>Size (US) </b></label><br/>
		<select name="shoeSize">
			<option value="4">4</option>
    		<option value="4.5">4.5</option>
    		<option value="5">5</option>
    		<option value="5.5">5.5</option>
    		<option value="6">6</option>
    		<option value="6.5">6.5</option>
    		<option value="7">7</option>
   	 		<option value="7.5">7.5</option>
    		<option value="8">8</option>
    		<option value="8.5">8.5</option>
    		<option value="9">9</option>
    		<option value="9.5">9.5</option>
    		<option value="10">10</option>
    		<option value="10.5">10.5</option>
    		<option value="11">11</option>
    		<option value="11.5">11.5</option>
    		<option value="12">12</option>
    		<option value="12.5">12.5</option>
    		<option value="13">13</option>
    	 	<option value="13.5">13.5</option>
   	 		<option value="14">14</option>
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
    <label><b>End Date/Time </b></label><br/>
    Date(mm/dd/yyy): <input name="mm" placeholder="mm" size="2" type="text" maxlength="2" required>-<input name="dd" placeholder="dd" size="3" type="text" maxlength="2" required>-<input name="yyyy" placeholder="yyyy" size="4" type="text" maxlength="4" required> /
    24-Hour Time: <input name="hh" placeholder="hr" size="2" type="text" maxlength="2" required>:<input name="mi" placeholder="min" size="3" type="text" maxlength="2" required>
    <br/>
    
</p>
  <div style="background-color:#f1f1f1">
  	<button type="submit">Create</button>
    <a href="createAuction.html"><button type="button">Cancel</button></a>
  </div>
</form>
</body>
</html>