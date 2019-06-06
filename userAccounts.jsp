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
		<h1> BuyMe</h1>
		<a href="custRepHome.html">Home</a>
  		<a href="custRepHome.html">Profile</a>
 		<a href="auctions.jsp">View Auctions</a>
 		<a href="custRepInbox.jsp">Inbox</a>
  		<a href="userAccounts.jsp">view/edit end-users</a>
  		<a href="login.html">Logout</a>
        <h2>End-User Accounts</h2>
                             
     <%

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			String str = "SELECT COUNT(*) as cnt FROM user";
			
			ResultSet result = stmt.executeQuery(str);
			
			result.next();
			
			int countUser = result.getInt("cnt");
			
			//Get table of customer representatives from db into an array
			str = "SELECT * FROM user";
			
			result = stmt.executeQuery(str);
			
			String[] usernames = new String[countUser];
			String[] passwords = new String[countUser];
			String[] emails = new String[countUser];
			
			int count = 0;
			out.write("<table>");
			out.write("<tr><th style=\"text-align:center\">Username</th><th style=\"text-align:center\">Email</th><th style=\"text-align:center\">Password</th><th style=\"text-align:center\">Edit Password</th><th style=\"text-align:center\">Remove account?</th></tr>");
			while(result.next()){
				usernames[count] = result.getString("username");
				passwords[count] = result.getString("password");
				emails[count] = result.getString("email");
				out.write("<tr><td align=\"center\">"+ usernames[count]+"</td><td align=\"center\">"+ emails[count]
						+"</td><td align=\"center\">"+ passwords[count]+"</td><td align=\"center\"><form action=\"passwordChangeForm.jsp\" method=\"post\">"
						+"<input id=\"id_anything123\" type=\"hidden\" name=\"val\" value=\"" + usernames[count] + "\"/>"
						+ "<input id=\"" + usernames[count] +"\" type=\"submit\" value=\"Change Password\" /></form></td>"
						+"<td align=\"center\"><form action=\"deleteUserAccount.jsp\" method=\"post\">"
						+"<input id=\"id_anything123\" type=\"hidden\" name=\"user\" value=\"" + usernames[count] + "\"/>"
						+ "<input id=\"" + usernames[count] +"\" type=\"submit\" value=\"Delete\"/></form></td>");
				count++;
			}
			out.write("</table>");
			}catch(Exception e){
				
			}
		%>
</body>
</html>