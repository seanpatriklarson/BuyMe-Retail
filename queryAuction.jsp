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
	
	String cookieUser = "";
	Cookie[] Cookies = request.getCookies();
	
	if (Cookies != null){
		for (Cookie tempCookie : Cookies){
			if ("BuyMe.user".equals(tempCookie.getName())){
				cookieUser = tempCookie.getName();
				break;
			}
		}
	}
	if (cookieUser.isEmpty()){
		response.sendRedirect("loginNoCookie.html");
	}
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();

	//Take in values from form
	String title = request.getParameter("title");
	String size = request.getParameter("size");
	String type = request.getParameter("type");
	String color = request.getParameter("color");
	String cond = request.getParameter("cond");
	String material = request.getParameter("material");
	String brand = request.getParameter("brand");
	String price = request.getParameter("price");
	
	System.out.println(title);
	System.out.println(size);
	System.out.println(type);
	System.out.println(color);
	System.out.println(cond);
	System.out.println(material);
	System.out.println(brand);
	System.out.println(price);

	
	//Create a SQL statement
	boolean check = false;
	Statement stmt = con.createStatement();
	String str = "SELECT * FROM newAuction ";
	if (!title.isEmpty()){
		str += "where title like '" + title + "%" + "' ";
		check = true;
	}
	if (!size.isEmpty()){
		if (!check){
			str += "where size like '" + size + "%" + "' ";
			check = true;
		}
		else{
			str += "and size like '" + size + "%" + "' ";
		}
	}
	if (type.compareTo("type") != 0){
		if (!check){
			str += "where type like '" + type + "%" + "' ";
			check = true;
		}
		else{
			str += "and type like '" + type + "%" + "' ";
		}
	}
	if (color.compareTo("color") != 0){
		if (!check){
			str += "where color like '" + color + "%" + "' ";
			check = true;
		}
		else{
			str += "and color like '" + color + "%" + "' ";
		}
	}
	if (cond.compareTo("cond") != 0){
		if (!check){
			str += "where `condition` like '" + cond + "%" + "' ";
			check = true;
		}
		else{
			str += "and `condition` like '" + cond + "%" + "' ";
		}
	}
	if (!material.isEmpty()){
		if (!check){
			str += "where material like '" + material + "%" + "' ";
			check = true;
		}
		else{
			str += "and material like '" + material + "%" + "' ";
		}
	}
	if (!brand.isEmpty()){
		if (!check){
			str += "where brand like '" + brand + "%" + "' ";
			check = true;
		}
		else{
			str += "and brand like '" + brand + "%" + "' ";
		}
	}
	if (price.equals("25")){
		if (!check){
			str += "where startPrice between 0 and 25";
			check = true;
		}
		else{
			str += "and startPrice between 0 and 25";
		}
	}
	else if (price.equals("50")){
		if (!check){
			str += "where startPrice between 25 and 50";
			check = true;
		}
		else{
			str += "and startPrice between 25 and 50";
		}
	}
	else if (price.equals("100")){
		if (!check){
			str += "where startPrice between 50 and 100";
			check = true;
		}
		else{
			str += "and startPrice between 50 and 100";
		}
	}
	else if (price.equals("150")){
		if (!check){
			str += "where startPrice between 100 and 200";
			check = true;
		}
		else{
			str += "and startPrice between 100 and 200";
		}
	}
	else if (price.equals("200")){
		if (!check){
			str += "where startPrice > 200";
			check = true;
		}
		else{
			str += "and startPrice > 200";
		}
	}
	System.out.println(str);
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
		String title2 = result.getString("title");
		String desc = result.getString("desc");
		float currentPrice = result.getFloat("startPrice");
		String size2 = result.getString("size");
		String color2 = result.getString("color");
		String brand2 = result.getString("brand");
		String condition = result.getString("condition");
		String material2 = result.getString("material");
		String datetime = result.getString("endDateTime");
		String user = result.getString("auc_user");
		
		%>
  <tr>
    <td><a href=<%= "\"viewAuction.jsp?Id=" + aid + "\"" %>><%=title2 %></a></td>
    <td><%=desc %></td>
    <td>$<%=currentPrice %></td>
    <td><%=size2 %></td>
    <td><%=color2 %></td>
    <td><%=brand2 %></td>
    <td><%=condition %></td>
    <td><%=material2 %></td>
    <td><%=datetime %></td>
    <td><%=user %></td>
  </tr>
		<%
	}
  %>
  </table>
  <%
	if (con != null)
		con.close();
  	if (stmt != null)
  		stmt.close();
  	if (result != null)
  		result.close();
}
catch(Exception ex){
	out.print(ex);
}	
			%>
  
</body>
</html>