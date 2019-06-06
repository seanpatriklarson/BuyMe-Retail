<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
table {
    font-family: arial, sans-serif;
    border-collapse: collapse;
    width: 100%;
}

td, th {
    border: 1px solid #dddddd;
    text-align: left;
    padding: 8px;
}

tr:nth-child(even) {
    background-color: #dddddd;
}
</style>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BuyMe</title>
</head>
<body>
	<h1>BuyMe</h1> 
	

  <a href="home.jsp">Home</a>
  <a href="home.jsp">Profile</a>
  <a href="auctions.jsp">Auctions</a>
  <a href="createAuction.jsp">Create an Auction</a>
  <a href="login.jsp">Logout</a>
  <br>
  <br>
<% 

try {
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
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	//Create a SQL statement
	Statement stmt = con.createStatement();
	String getTitle = "SELECT title FROM newAuction WHERE aid=" + aid;
	ResultSet result = stmt.executeQuery(getTitle);
	result.next();
	String title = result.getString("title");
	%><h1><%=title%></h1><%
	String getCount = "SELECT COUNT(*) as cnt FROM bids WHERE bid_aid=" + aid;
	result = stmt.executeQuery(getCount);
	result.next();
	int currCount = result.getInt("cnt");
	if(currCount == 0){
		%><h2>No current bids</h2><%
	}
	else{
	String str = "SELECT * FROM bids WHERE bid_aid=" + aid;
	result = stmt.executeQuery(str);
	result.next();
	String bidder = result.getString("bid_user");
	String bidAmount = result.getString("bidAmt");
	%><h3>Current Bid:</h3>
	<table>
	<tr>
		<th>Bidder Username</th>
		<th>Bid Amount</th>
	</tr>
	<tr>
	<td><%=bidder %></td>
	<td><%=bidAmount %></td>
	</tr>
	</table>
	<%
	getCount = "SELECT COUNT(*) as cnt FROM pastBids WHERE pastbid_aid=" + aid;
	result = stmt.executeQuery(getCount);
	result.next();
	int pastCount = result.getInt("cnt");
	if(pastCount == 0){
		%><h2>No past bids</h2><%
	}
	else{
	str = "SELECT * FROM pastBids WHERE pastBid_aid=" + aid;
	
	//Run the query against the DB
	result = stmt.executeQuery(str);
	%>
	<h3>Past Bids:</h3>
	<table>
  <tr>
    <th>Bidder Username</th>
    <th>Bid Amount</th>
  </tr>
  <%

	//Start parsing out the result of the query. Don't forget this statement. It opens up the result set.
	while(result.next()){
		bidAmount = result.getString("pastBid_Amt");
		bidder = result.getString("bidder");
		%>
  <tr>
    <td><%=bidder %></td>
    <td><%=bidAmount %></td>
  </tr>
		<%
	}
  %>
  </table>
  <%} }%>
  <a href=<%= "\"placeBid.jsp?Id=" + aid + "\"" %>><button type="button">Place Bid</button></a>
  <a href="auctions.jsp"><button type="button">Back to bids</button></a>
  <%
	
		}
		catch(Exception ex){
		out.print(ex);
		}	
			%>
  
</body>
</html>