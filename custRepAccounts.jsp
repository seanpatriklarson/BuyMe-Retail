 <%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<h1>BuyMe</h1>
	<h3>Navigation:</h3>
  <a href="home.html">Home</a><br/>
  <a href="home.html">Profile</a><br/>
  <a href="home.html">Auctions</a><br/>
  <a href="home.html">Manage Customer Representative Accounts</a><br/>
  <a href="home.html">Generate Sales Report</a><br/>
  <a href="home.html">Logout</a>
  
  <h2>Customer Representative Accounts</h2>
  <%

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			String str = "SELECT COUNT(*) as cnt FROM customerRep";
			
			ResultSet result = stmt.executeQuery(str);
			
			result.next();
			
			int countCustRep = result.getInt("cnt");
			
			
			//Get table of customer representatives from db into an array
			str = "SELECT * FROM customerRep";
			
			result = stmt.executeQuery(str);
			
			String[] custRepUsername = new String[countCustRep];
			String[] custRepPassword = new String[countCustRep];
			String[] custRepEmail = new String[countCustRep];
			
			int count = 0;
			out.write("<table>");
			out.write("<tr><th style=\"text-align:center\">Username</th><th style=\"text-align:center\">Email</th>");
			while(result.next()){
				custRepUsername[count] = result.getString("username");
				custRepPassword[count] = result.getString("password");
				custRepEmail[count] = result.getString("email");
				out.write("<tr><td align=\"center\">"+custRepUsername[count]+"</td><td align=\"center\">"+custRepEmail[count]
						+"</td> <td align=\"center\"><form action=\"custRepPasswordChange.jsp\" method=\"post\">");
				count++;
			}
			out.write("</table>");
			out.write("<a href=\"addCustRep.html\" class=\"button\">Add Account</a>");
			}catch(Exception e){
				
			}
		%>
  
</body>
</html>