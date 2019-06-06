<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">

<style>
	p {
    	text-indent: 20px;
	}
	
	body {
	
		background: white;
	
	}
	
	input[type=submit] {
    padding:5px 15px; 
    background:#ccc; 
    border:0 none;
    cursor:pointer;
    -webkit-border-radius: 5px;
    border-radius: 5px; 
}
</style>



<title>FAQ</title>

</head>
<body>
<h1>BuyMe</h1> 
	

  <a href="home.jsp">Home</a>
  <a href="home.jsp">Profile</a>
  <a href="auctions.jsp">Auctions</a>
  <a href="FAQ.jsp">FAQ</a>
  <a href="createAuction.jsp">Create an Auction</a>
  <a href="login.html">Logout</a>

<h1>FAQ</h1> 
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
		
		//Get the database connection
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		//Create a SQL statement
		Statement stmt = con.createStatement();
		
		//count category 

				String str = "SELECT MAX(cIndex) as categ FROM categoryListFAQ ";
				ResultSet result = stmt.executeQuery(str);
				result.next();
				int countCat = result.getInt("categ");

		for (int x = 1; x<= countCat; x++){
				
				
				str = "SELECT COUNT('qIndex') as cnt FROM FAQ WHERE cIndex=? ";
				PreparedStatement ps = con.prepareStatement(str);
				ps.setInt(1, x);
				
				str = ps.toString();
				str = str.substring(str.indexOf(':')+1);
				
				result = stmt.executeQuery(str);
				result.next();
				int countQuestionsInEachCat = result.getInt("cnt");
				
				
				//to output data in FAQ.jsp
				
				
				String q = null;
				String ans = null;
				String output = null;
				String newline = System.getProperty("line.separator");
				String chunk = newline;
				//ArrayList<String> eachQ = new ArrayList<String>();
				
				String strr = "SELECT question, answer FROM FAQ WHERE cIndex=?";
				PreparedStatement ps2 = con.prepareStatement(strr);
				ps2.setInt(1, x);
				strr = ps2.toString();
				strr = strr.substring(strr.indexOf(':')+1);
				
				
				String strrr = "SELECT category FROM categoryListFAQ WHERE cIndex=?";
				PreparedStatement ps3 = con.prepareStatement(strrr);
				ps3.setInt(1, x);
				strrr = ps3.toString();
				strrr = strrr.substring(strrr.indexOf(':')+1);
				ResultSet rslt2 = stmt.executeQuery(strrr);
				rslt2.next();
				String category = rslt2.getString("category");
				/* session.setAttribute("category", category); */
				
				
				%>
				
					<h3> <%=category%></h3>
				
				<%
				
				ResultSet rslt = stmt.executeQuery(strr);
				for (int a=1; a<=countQuestionsInEachCat;a++){
				
					rslt.next();
					q = rslt.getString("question");
					ans = rslt.getString("answer");
					
					output = a + ". "+ q + newline;
					session.setAttribute("test", output);
					
					/* if (ans != null){ */
						session.setAttribute("test2", "Ans: " + ans);
					/* } */ /* else {
						session.setAttribute("test2", "Our Customer Rep will get back to you.");
					} */
					
					%>
					
					<div> <%=session.getAttribute("test") %></div> 
					<i><p> <%=session.getAttribute("test2") %></p> <br></i>
					
					
					<%
					chunk = chunk + output;
					//eachQ.add(output);
					//session.setAttribute("qIndex", a);
					//session.setAttribute("questions", output);
					//response.sendRedirect("FAQ.jsp"); 
				}

		}
 } catch (Exception ex){
		out.print(ex);
	}

 
 %>
 
 <br>
	
<form class="w3-container w3-card-4 w3-light-grey" action="newFAQ.jsp"> 

	<h2>Can't find your answer? </h2> <br>
	<h5>Ask us! </h5>
	<select class="w3-select w3-border" name="category" id="category" value="category">
		<option value="" disabled selected>Choose the category</option>
  		<option value="Auction Items">Auction Items</option>
  		<option value="Returns">Returns</option>
  		<option value="Shipping">Shipping</option>
  		<option value="Others">Others</option>
	</select>
	<br>
	<br>
	<h5> Type your question here!</h5> 
	<div class="w3-row w3-section">
  		<div class="w3-col" style="width:50px"><i class="w3-xxlarge fa fa-pencil"></i></div>
    		<div class="w3-rest">
      		<input class="w3-input w3-border w3-round-large" type="text" name="questions" placeholder="What is it about?"><br>
    		</div>
	</div>
	<input type="submit" value="Submit Question"> (average answer wait time: 1-2 days)
	
</form>
	
</body>
</html>