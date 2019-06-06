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
  <a href="home.jsp">Auctions</a>
  <a href="createAuction.jsp">Create an Auction</a>
  <a href="home.jsp">Logout</a>
<form action="searchAgain.jsp">
  Sort by Auction Properties: <br/>
<input type="text" placeholder="Search.." name="title">
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
</select>
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
Material: <input maxlength="50" name="material" size="10" placeholder="Cotton"> 
Brand: <input maxlength="50" name="brand" size="10" placeholder="Brand name"> 
<select name = "price">
<option value="price">Price</option>
<option value="25">Under $25</option>
<option value="50">$25 to $50</option>
<option value="100">$50 to $100</option>
<option value="150">$100 to $200</option>
<option value="200">$200 and above</option>
</select>
<button>Get Auctions</button>
</form>
  <br/>
  <br/>
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
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();

	//Create a SQL statement
	Statement stmt = con.createStatement();
	System.out.println("hello1");
	String str = "SELECT * FROM newAuction";
	System.out.println("hello");
	//Run the query against the DB
	ResultSet result = stmt.executeQuery(str);
	%>
	<table>
  <tr>
    <th>Title</th>
    <th>Description</th>
    <th>Price</th>
    <th>Size</th>
    <th>Color</th>
    <th>Brand</th>
    <th>Condition</th>
    <th>Material</th>
    <th>End Date/Time</th>
    <th>Seller</th>
  </tr>
  <%

	//Start parsing out the result of the query. Don't forget this statement. It opens up the result set.
	while(result.next()){
		int aid = result.getInt("aid");
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
  <tr>
    <td><a href=<%= "\"viewAuction.jsp?Id=" + aid + "\"" %>><%=title %></a></td>
    <td><%=desc %></td>
    <td><%=currentPrice %></td>
    <td><%=size %></td>
    <td><%=color %></td>
    <td><%=brand %></td>
    <td><%=condition %></td>
    <td><%=material %></td>
    <td><%=datetime %></td>
    <td><%=user %></td>
  </tr>
		<%
	}
  %>
  </table>
  <%
	
}
catch(Exception ex){
	out.print(ex);
}	
			%>
  
</body>
</html>