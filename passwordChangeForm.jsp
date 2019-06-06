<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BuyMe</title>
</head>
<body>
	<div><h1> BuyMe</h1></div>
		<a href="custRepHome.html">Home</a>
  		<a href="custRepHome.html">Profile</a>
 		<a href="auctions.jsp">View Auctions</a>
 		<a href="custRepInbox.jsp">Inbox</a>
  		<a href="userAccounts.jsp">view/edit end-users</a>
  		<a href="login.html">Logout</a>
                <div><h2>Change End-User Password</h2></div>
                
			<%
			String user = request.getParameter("val");
			out.write("<form action=\"passwordChange.jsp\"> Username:<br><input type=\"text\" name=\"user\" value=\"" + user + "\">" 
			+"<br>"
			+ "New password:<br><input type=\"text\" name=\"new_password\"<br><br><input type=\"submit\" value=\"Submit\"></form>"
			+ "<a href=\"userAccounts.jsp\">Cancel</a>");
			%>
</body>
</html>