<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>To Post a Question</title>
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
            
            
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();
			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			String str = "SELECT COUNT('qIndex') as cnt FROM FAQ";
	
			
			//Run the query against the DB
			ResultSet result = stmt.executeQuery(str);

			//Start parsing out the result of the query. Don't forget this statement. It opens up the result set.
			result.next();
			//Parse out the result of the query
			int countQuestions = result.getInt("cnt");
			
			str = "SELECT COUNT('qIndex') as cnt FROM newFAQ";
			result = stmt.executeQuery(str);
			result.next();
			
			countQuestions += result.getInt("cnt");
			
			//Populate SQL statement with an actual query. It returns a single number. The number of users in the DB.
			//str = "SELECT * as number FROM cs336db.FAQ";
			//Run the query against the DB
			//result = stmt.executeQuery(str);
			//int countQuestions = result.getInt( );
			
			String cate = request.getParameter("category");
			//String cate = "Auction Items";
			
			String quest = request.getParameter("questions");
			
			str = "SELECT cIndex FROM categoryListFAQ WHERE category=\"" + cate + "\"";
			result = stmt.executeQuery(str);
			result.next();
			int catIndex = result.getInt("cIndex");
			
			
			
			//Make an insert statement for the Sells table:
			String insert = "INSERT INTO newFAQ(cIndex, qIndex, question, user)"
					+ "VALUES (?, ?, ?, ?)";
			//Create a Prepared SQL statement allowing you to introduce the parameters of the query
			PreparedStatement ps = con.prepareStatement(insert);
			
			//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
			ps.setInt(1, catIndex);
			
			ps.setInt(2, countQuestions+1);
			
			ps.setString(3, quest);
			
			ps.setString(4, username);
			//Run the query against the DB
			ps.executeUpdate();
			
		
	} catch (Exception ex){
		out.print(ex);
	}

	response.sendRedirect("FAQ.jsp"); 
	
	%>
	
	<form id="questions" method ="post" action="updateFAQ.jsp">
		
		<script>
			
			document.getElementById("questions").submit();
			
	    </script>
	
	</form>	
	
	
	

</body>
</html>