<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
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
			int aid = Integer.parseInt(request.getParameter("Id"));
			
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();

			//Create a SQL statement
			Statement stmt = con.createStatement();
			String str = "SELECT * FROM newAuction WHERE aid=" + aid;
			
			//Run the query against the DB
			ResultSet result = stmt.executeQuery(str);
			result.next();
			String title = result.getString("title");
			String desc = result.getString("desc");
			float currentPrice = result.getFloat("startPrice");
			String size = result.getString("size");
			String color = result.getString("color");
			String brand = result.getString("brand");
			String condition = result.getString("condition");
			String material = result.getString("material");
			String datetime = result.getString("endDateTime");
			String user = result.getString("auc_user");
			%>
<a href="home.html">Home</a>
  <a href="home.html">Profile</a>
  <a href="home.html">Auctions</a>
  <a href="createAuction.html">Create an Auction</a>
  <a href="home.html">Logout</a>
	<h1>Place Bid</h1>
	<form action="placeBid1.jsp">

 
  
    <h2>Title: <%=title %></h2><br/>
    
    <label><b>Current Price: </b></label>$<%=currentPrice %>
    <br/>
    <!-- <label><b>Minimum Bid Increment </b></label><br/>
    <select name="minBid">
    	<option value="0.50">$0.50</option>
        <option value="1.00">$1.00</option>
        <option value="1.50">$1.50</option>
        <option value="2.00">$2.00</option>
        <option value="2.50">$2.50</option>
    </select>
    <br/> -->
    <label><b>Your bid: </b></label>$
    <input type="text" name="bidDollar" size="5" maxlength="5" required>.<input type="text" name="bidCent" size="2" maxlength="2" required>
    <br/>
    <label><b>End Date/Time of Auction: </b></label><%=datetime %><br/>
    
  <div style="background-color:#f1f1f1">
  	<button type="submit">Place Bid</button>
  	<%session.setAttribute("aid", aid); %>
    <a href="auctions.jsp"><button type="button">Cancel</button></a>
  </div>
</form>
</body>
</html>