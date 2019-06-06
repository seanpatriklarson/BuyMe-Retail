<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Create Auction</title>
</head>
<body>
<a href="home.html">Home</a>
  <a href="home.html">Profile</a>
  <a href="auctions.jsp">View Auctions</a>
  <a href="custRepInbox.html">Inbox</a>
  <a href="home.html">view/edit end-users</a>
  <a href="login.html">Logout</a>
	<%
	int qid = Integer.parseInt(request.getParameter("Id"));
	//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String str = "SELECT * FROM newFAQ WHERE qIndex=" + qid;
		ResultSet result = stmt.executeQuery(str);

		//Start parsing out the result of the query. Don't forget this statement. It opens up the result set.
		result.next();
		String question = result.getString("question");
		String user = result.getString("user");
		String cid = result.getString("cIndex");
	%>
  	<form action="addAnswer.jsp">
  	<input type='hidden' id= 'hiddenField' name='id' value="<%=qid %>">
    <h1>Question: <%=question%></h1>
    <p>
    <label><b>Your answer:</b></label><br/>
    <textarea rows="4" cols="50" name="answer"></textarea>
  <div style="background-color:#f1f1f1">
  	<input type="submit" value="Submit Answer">
    <a href="custRepInbox.jsp"><button type="button">Cancel</button></a>
  </div>
  </form>
 <%--  <% response.sendRedirect("custRepInbox.jsp");%> --%>
</body>
<%-- <% response.sendRedirect("custRepInbox.jsp");%> --%>
</html>