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
  <a href="home.jsp">Profile</a>
  <a href="auctions.jsp">Auctions</a>
  <a href="createAuction.jsp">Create an Auction</a>
  <a href="home.jsp">Logout</a>
  <input type="text" placeholder="Search..">
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
                        		
              <h2><%= username%>'s profile!</h2>
			<br/>
  			<a href="home.jsp">Currently Selling</a>
  			<br/>
  			<a href="auctions.jsp">Seller's Past Auctions</a>
 

</body>
</html>