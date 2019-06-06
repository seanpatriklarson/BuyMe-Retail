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
</head>
<body>
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
	
	String username = "";
    Cookie[] Cookies2 = request.getCookies();
          		
    if (Cookies2 != null){
          for (Cookie tempCookie : Cookies2){
          	if ("BuyMe.user".equals(tempCookie.getName())){
          		username = tempCookie.getValue();
          		break;
          	}
          }
    } 
    
    int qid = Integer.parseInt(request.getParameter("id"));
    //Get the database connection
 	ApplicationDB db = new ApplicationDB();	
 	Connection con = db.getConnection();
	//Create a SQL statement
 	Statement stmt = con.createStatement();
	String str = "DELETE FROM userInbox WHERE qid=" + qid;
 		
 	stmt.executeUpdate(str);
 	response.sendRedirect("userInbox.jsp");
 		
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