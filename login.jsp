<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>
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
	try{
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		String str = "SELECT COUNT(*) as cnt FROM customerRep";
		
		ResultSet result = stmt.executeQuery(str);
		
		result.next();
		
		int countCustRep = result.getInt("cnt");
		
		//Populate SQL statement with an actual query. It returns a single number. The number of users in the DB.
		str = "SELECT COUNT(*) as cnt FROM user";

		//Run the query against the DB
		result = stmt.executeQuery(str);

		//Start parsing out the result of the query. Don't forget this statement. It opens up the result set.
		result.next();
		//Parse out the result of the query
		int countUsers = result.getInt("cnt");
		
		//Get table of customer representatives from db into an array
		str = "SELECT * FROM customerRep";
		
		result = stmt.executeQuery(str);
		
		String[] custRepUsername = new String[countCustRep];
		String[] custRepPassword = new String[countCustRep];
		
		int count = 0;
		
		while(result.next()){
			custRepUsername[count] = result.getString("username").toLowerCase();
			custRepPassword[count] = result.getString("password");
			count++;
		}
		
		//Get table of users from db into an array
		str = "SELECT * FROM user";
		//Run the query against the DB
		result = stmt.executeQuery(str);
				
		String[] users = new String[countUsers];
		String[] passwords = new String[countUsers];
		
		count = 0;
		while(result.next()){
			users[count] = result.getString("username").toLowerCase();
			passwords[count] = result.getString("password");
			count++;
		}
		
		//Get parameters from the HTML form at the index.jsp
		String username = request.getParameter("uname").toLowerCase();
		String password = request.getParameter("psw");
			
		//Check if user is the admin
		if(username.compareTo("admin") == 0 && password.compareTo("password") == 0){
			response.sendRedirect("adminHome.html");
			return;
		}
		// Check if user is a customer representative
		int searchIndex = binarySearch(custRepUsername, username);
		
		if(searchIndex != -1){
			if(custRepPassword[searchIndex].compareTo(password) == 0)
				response.sendRedirect("custRepHome.html");
				return;
		}

		searchIndex = binarySearch(users, username);
	
		// if the username or password is not found in the database, prompt user to reenter
		if(searchIndex == -1){
			response.sendRedirect("login.html");
			return;
		}

		if(passwords[searchIndex].compareTo(password) != 0){
			response.sendRedirect("login.html");
			return;
		}	
		
			//Create Cookie before successful login with the valid info
			String cookieTempName = "";
			Cookie[] Cookies = request.getCookies();
			
			if (Cookies != null){
				for (Cookie tempCookie : Cookies){
					if ("BuyMe.user".equals(tempCookie.getName())){
						cookieTempName = tempCookie.getValue();
						break;
					}
				}
			}
			if (cookieTempName.isEmpty()){
				//Create cookie called "BuyMe.user" with value of getParameter("username")
				Cookie cookie = new Cookie("BuyMe.user", username);
				//Set age of cookie to 1 year
				cookie.setMaxAge(60*60*24*365);
				//send to browser
				response.addCookie(cookie);
			}
			if (username != cookieTempName){
				 Cookie killMyCookie = new Cookie("BuyMe.user", null);
			     killMyCookie.setMaxAge(0);
			     killMyCookie.setPath("/");
			     response.addCookie(killMyCookie);
			     
				//Create cookie called "BuyMe.user" with value of getParameter("username")
				Cookie cookie = new Cookie("BuyMe.user", username);
				//Set age of cookie to 1 year
				cookie.setMaxAge(60*60*24*365);
				//send to browser
				response.addCookie(cookie);
			}
				
			
			response.sendRedirect("home.jsp");
	
		
		
	} catch (Exception ex){
		out.write("help");
		out.print(ex);
	}

	%>
</body>
</html>