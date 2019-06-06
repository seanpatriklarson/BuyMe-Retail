<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>BuyMe</title>
</head>
<body>
	<% 
			try {
				
			/* String user = request.getParameter("val");
			System.out.println(user); */

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//String oldpass = request.getParameter("old_password");
			String newpass = request.getParameter("new_password");
			String user = request.getParameter("user");
			//Get table of customer representatives from db into an array
			String str = "UPDATE user SET password='" + newpass + "' WHERE username='"+ user + "'";
			stmt.executeUpdate(str);
			response.sendRedirect("userAccounts.jsp");
			}catch(Exception e){
			}
			%>	
</body>
</html>