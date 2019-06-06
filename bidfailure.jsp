<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
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
			String getAid = String.valueOf(session.getAttribute("bidFailId"));
			System.out.println("hello " + getAid);
			int aid = Integer.parseInt(getAid);
			%>
	<h1>BuyMe</h1> 
	

  <a href="home.jsp">Home</a>
  <a href="home.jsp">Profile</a>
  <a href="auctions.jsp">Auctions</a>
  <a href="createAuction.jsp">Create an Auction</a>
  <a href="home.jsp">Logout</a>
  <input type="text" placeholder="Search..">

                        		
             <h2>Failed to place bid. Bid must be higher than current bid.</h2>
             <a href=<%= "\"viewAuction.jsp?Id=" + aid + "\"" %>>Return to Auction</a>
             <a href="auctions.jsp">Return to Auction List</a>

</body>
</html>