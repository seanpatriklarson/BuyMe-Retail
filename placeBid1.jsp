<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
		<%
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
			response.sendRedirect("loginNoCookie.jsp");
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
		int auctionid= (Integer)(session.getAttribute("aid"));
		
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();
		String str = "SELECT startPrice FROM newAuction WHERE aid=" + auctionid;
		
		//Run the query against the DB
		ResultSet result = stmt.executeQuery(str);
		result.next();
		float startPrice = result.getFloat("startPrice");
		//Format of float string
		String bid = request.getParameter("bidDollar") + "." + request.getParameter("bidCent");
		
		//Convert string to float for money representation
		float newBid = Float.parseFloat(bid);
		
		//must check against current bid not start price
		if(newBid < startPrice){
			session.setAttribute("bidFailId", auctionid);
			response.sendRedirect("bidfailure.jsp");
			return;
		}
		
		str = "SELECT * FROM bids WHERE bid_aid=" + auctionid;
		
		result = stmt.executeQuery(str);
		
		//First bid just add to bids table
		if(result.next() == false){
			str = "INSERT INTO bids(bidAmt, bid_aid, bid_user) "
					+ "VALUES(?,?,?)";
			PreparedStatement ps = con.prepareStatement(str);
			ps.setFloat(1, newBid);
			System.out.println(newBid);
			ps.setInt(2, auctionid);
			System.out.println(auctionid);
			ps.setString(3, username);
			System.out.println(username);
			ps.executeUpdate(); 
		}
		//If there is already a bid in the bids table remove it then add new bid
		else{
			str = "DELETE FROM bids "
					+ "WHERE bid_aid=" + auctionid;
			stmt.executeUpdate(str);
			str = "INSERT INTO bids(bidAmt, bid_aid, bid_user)"
					+ "VALUES(?,?,?)";
			PreparedStatement ps = con.prepareStatement(str);
			ps.setFloat(1, newBid);
			ps.setInt(2, auctionid);
			ps.setString(3, username);
			ps.executeUpdate(); 
		}
		response.sendRedirect("bidsuccess.jsp");
		/*if (!StringUtils.isNumeric(request.getParameter("startPriceDollar"))
				|| !StringUtils.isNumeric(request.getParameter("startPriceCent"))){
					out.write("not numeric");
					response.sendRedirect("placeBid.jsp");
					return;
				} */
		%>
</body>
</html>