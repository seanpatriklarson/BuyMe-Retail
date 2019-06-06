<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%!
	public int binarySearch(String[] arr, String entity){
		//binary search to look for user in database
		int low = 0;
		int high = arr.length - 1;
		int mid;
		int searchIndex = -1;
				
		while(low <= high){
			mid = (low+high)/2;
					
			if(arr[mid].compareTo(entity) < 0)
				low = mid + 1;
			else if(arr[mid].compareTo(entity) > 0)
				high = mid - 1;
			else{
				searchIndex =  mid;
				break;
			}
		}
		return searchIndex;
	}
	%>
	<%
	try {

		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		String str = "SELECT COUNT(*) as cnt FROM user";

		//Run the query against the DB
		ResultSet result = stmt.executeQuery(str);

		//Start parsing out the result of the query. Don't forget this statement. It opens up the result set.
		result.next();
		//Parse out the result of the query
		int countUsers = result.getInt("cnt");
		
		//Populate SQL statement with an actual query. It returns a single number. The number of users in the DB.
		str = "SELECT username FROM user ORDER BY username";
		//Run the query against the DB
		result = stmt.executeQuery(str);
						
		String[] users = new String[countUsers];
		String[] emails = new String[countUsers];
			
		int count = 0;
		while(result.next()){
			users[count] = result.getString("username").toLowerCase();
			count++;
		}
		
		str = "SELECT email FROM user ORDER BY email";
		result = stmt.executeQuery(str);
		count = 0;
		
		while(result.next()){
			emails[count] = result.getString("email").toLowerCase();
			count++;
		}
		
		int searchIndex = 0;
		int emailIndex = 0;
		String username = request.getParameter("uname").toLowerCase();
		String pass = request.getParameter("psw");
		String email = request.getParameter("email").toLowerCase();
		
		searchIndex = binarySearch(users, username);
		
		emailIndex = binarySearch(emails, email);
		
		
		if(searchIndex != -1 || emailIndex != -1){
			response.sendRedirect("createAccount.html");
			return;
		}

		//Make an insert statement for the Sells table:
		String insert = "INSERT INTO user(username, password, email)"
				+ "VALUES (?, ?, ?)";
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, username);
		ps.setString(2, pass);
		ps.setString(3, email);
		//Run the query against the DB
		ps.executeUpdate();
		
		
		
	}catch(Exception ex){
		out.print(ex);
		out.print("insert failed");
	}
	response.sendRedirect("home.jsp");
	%>
</body>
</html>