<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>BuyMe</title>
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
	<h1>BuyMe</h1> 
	

  <a href="home.jsp">Home</a>
  <a href="auctions.jsp">Auctions</a>
  <a href="FAQ.jsp">FAQ</a>
  <a href="createAuction.jsp">Create an Auction</a>
  <a href="userInbox.jsp">Inbox</a>
  <a href="login.html">Logout</a>
  <%
                  String username = "";
                  Cookie[] Cookies2 = request.getCookies();
                        		
                  if (Cookies2 != null){
                        for (Cookie tempCookie : Cookies2){
                        	if ("BuyMe.user".equals(tempCookie.getName())){
                        		username = tempCookie.getValue();
                        		break;
                        	}
                        }
                  } 
              %>
                        		
              <h2>Welcome, <%= username%> !</h2>
<form action="queryAuction.jsp">
Sort by Auction Properties: <br/>
<input type="text" placeholder="Search.." name="title"> <br/>
Size: <input size="5" name="size" maxlength="5" placeholder="32x32"> 
<select name="type">
<option value="type">Type</option>
<option value="tshirt">T-shirt</option>
<option value="sweater">Sweater</option>
<option value="sweatshirt">Sweatshirt</option>
<option value="jacket">Jacket/Outerwear</option>
<option value="jeans">Jeans</option>
<option value="formal pants">Formal Pants</option>
<option value="shorts">Shorts</option>
<option value="sneakers">Sneakers</option>
<option value="boots">Boots</option>
<option value="formal shoes">Formal Shoes</option>
<option value="belt">Belt</option>
<option value="scarf">Scarf</option>
<option value="hat">Hat</option>
<option value="jewlery">Jewlery</option>
</select><br/>

<select name="color">
<option value="color">Color</option>
<option value="red">Red</option>
<option value="orange">Orange</option>
<option value="yellow">Yellow</option>
<option value="green">Green</option>
<option value="blue">Blue</option>
<option value="indigo">Indigo</option>
<option value="violet">Violet</option>
<option value="white">White</option>
<option value="grey">Grey</option>
<option value="black">Black</option>
<option value="pink">Pink</option>
</select>
<select name="cond">
<option value="cond">Condition</option>
<option value="new">Brand New</option>
<option value="usedlikenew">Used - Like New</option>
<option value="usedgood">Used - Good</option>
<option value="acceptable">Used - Acceptable</option>
</select>
<br/>
Material: <input maxlength="50" name="material" size="10" placeholder="Cotton"> 
<br/>
Brand: <input maxlength="50" name="brand" size="10" placeholder="Brand name"> 
<br/>
<select name = "price">
<option value="price">Price</option>
<option value="25">Under $25</option>
<option value="50">$25 to $50</option>
<option value="100">$50 to $100</option>
<option value="150">$100 to $200</option>
<option value="200">$200 and above</option>
</select>
<br/>
<button>Get Auctions</button>
</form>
</body>
</html>