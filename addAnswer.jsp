<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Add Answer</title>
</head>
<body>
	<%
	int qid = Integer.parseInt(request.getParameter("id"));
	String answer = request.getParameter("answer");
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
		int cid = result.getInt("cIndex");
		
		str = "INSERT INTO FAQ(cIndex, qIndex, question, answer, user)"
				+ "VALUES(?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(str);
		ps.setInt(1,cid);
		ps.setInt(2, qid);
		ps.setString(3, question);
		ps.setString(4, answer);
		ps.setString(5, user);
		
		ps.executeUpdate();
		
		str = "DELETE FROM newFAQ WHERE qIndex=" + qid;
		stmt.executeUpdate(str);
		response.sendRedirect("custRepInbox.jsp");
		
	%>
</body>
</html>