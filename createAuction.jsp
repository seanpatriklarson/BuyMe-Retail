<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
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
<a href="home.jsp">Home</a>
  <a href="home.jsp">Profile</a>
  <a href="auctions.jsp">Auctions</a>
  <a href="createAuction.jsp">Create an Auction</a>
  <a href="login.jsp">Logout</a>
	<h1>Create an Auction</h1>
	<h3>Select a category for your item:</h3>
	<a href="createTopAuction1.jsp">Tops</a><br/>
  <a href="createBottomAuction1.jsp">Bottoms</a><br/>
  <a href="createShoeAuction1.jsp">Shoes</a><br/>
  <a href="createAccessoryAuction1.jsp">Accessories</a><br/><br/>
  <a href="home.jsp">Cancel</a>
</body>
</html>