<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@page import="java.io.*, java.util.Date, java.util.Enumeration, java.text.*" %> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Auction</title>
</head>
<body>
<a href="home.jsp">Home</a>
  <a href="home.jsp">Profile</a>
  <a href="home.jsp">Auctions</a>
  <a href="createAuction.jsp">Create an Auction</a>
  <a href="home.jsp">Logout</a>
	<%
	boolean cookieChecker = false;
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
	System.out.println(aid);
	//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String str = "SELECT * FROM newAuction WHERE aid=" + aid;
		ResultSet result = stmt.executeQuery(str);

		//Start parsing out the result of the query. Don't forget this statement. It opens up the result set.
		result.next();
		String title = result.getString("title");
		String desc = result.getString("desc");
		String type = result.getString("type");
		String size = result.getString("size");
		String color = result.getString("color");
		String brand = result.getString("brand");
		String cond = result.getString("condition");
		String material = result.getString("material");
		String price = result.getString("startPrice");
		String datetime = result.getString("endDateTime");
		String user = result.getString("auc_user");
	%>
  
    <h1> <%=title%></h1>
    <p>
    <label for="desc"><b>Description </b></label><br/>
    <textarea rows="4" cols="50" readonly><%=desc%></textarea>
    <br/>
    <br/>
    <label><b>Type: </b><%=type %></label><br/>
    <br/>
	<label><b>Size </b><%=size %></label><br/>
    <br/>
	<label><b>Color </b><%=color %></label><br/>
	<br/>
	<label><b>Brand </b><%=brand %></label><br/>
	<br/>
	<label><b>Condition </b><%=cond %></label><br/>
    <br/>
    <label><b>Material </b><%=material %></label><br/>
    <br/>
    <label><b>Current Price </b>$<%=price %></label><br/>
    <br/>
    <label><b>End Date/Time </b><%=datetime %></label><br/>
    <br/>
    <label><b>Seller </b><%=user %></label><br/>
    <br/>
    <a href="pastBids.jsp?Id=<%=aid %>">Past bids</a>
</p>
  <div style="background-color:#f1f1f1">
  	<a href=<%= "\"placeBid.jsp?Id=" + aid + "\"" %>><button type="button">Place Bid</button></a>
    <a href="auctions.jsp"><button type="button">Back to Auction List</button></a>
    <a href="home.jsp"><button type="button">Home</button></a>
  </div>
</body>
</html>