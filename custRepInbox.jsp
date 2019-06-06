<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Answers</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<!-- <style> 
input[type=submit] {
    padding:5px 15px; 
    background:#ccc; 
    border:0 none;
    cursor:pointer;
    -webkit-border-radius: 5px;
    border-radius: 5px; 
} -->
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
</style>
</head>
<body>
	

<h1>BuyMe</h1> 

  <a href="custRepHome.html">Home</a>
  <a href="custRepHome.html">Profile</a>
  <a href="auctions.jsp">View Auctions</a>
  <a href="custRepInbox.html">Inbox</a>
  <a href="userAccounts.jsp">view/edit end-users</a>
  <a href="login.html">Logout</a>
  <br/>
  <br/>
<% 

try {
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();

	//Create a SQL statement
	Statement stmt = con.createStatement();
	
	String count = "SELECT COUNT(*) as cnt FROM newFAQ";
	ResultSet res = stmt.executeQuery(count);
	res.next();
	int cnt = res.getInt("cnt");
	if(cnt == 0){
		%><h2>Inbox is empty!</h2><%
	}
	%>
	<table>
  <tr>
    <th>Category</th>
    <th>Asked by</th>
    <th>Question</th>
    <th>Answer?</th>
  </tr>
  <%
  Statement stmt1 = con.createStatement();
  String str = "SELECT * FROM newFAQ";

	//Run the query against the DB
	ResultSet result = stmt1.executeQuery(str);
	//Start parsing out the result of the query. Don't forget this statement. It opens up the result set.
	while(result.next()){
		int catIndex = result.getInt("cIndex");
		int qIndex = result.getInt("qIndex");
		String question = result.getString("question");
		String username = result.getString("user");
		Statement stmt2 = con.createStatement();
		System.out.println(catIndex);
		str = "SELECT * FROM categoryListFAQ WHERE cIndex= "+ catIndex;
		ResultSet cat = stmt2.executeQuery(str);
		cat.next();
		String category = cat.getString("category");
		
		%>
  <tr>
    <td><%=category %></td>
    <td><%=username %></td>
    <td><textarea name="answer" cols="40" rows="5" readonly><%=question %></textarea></td>
    <td><a href=<%= "\"answer.jsp?Id=" + qIndex + "\"" %>>answer?</a></td>
  	 
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
<!-- 
	<p> Refresh to see the posted answer.</p>
	<form action="FAQ.jsp"><input type="submit" value="Refresh"></form>	 -->
	
</body>
</html>