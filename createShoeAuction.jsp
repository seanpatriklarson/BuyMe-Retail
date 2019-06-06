<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%@ page import="org.apache.commons.lang3.StringUtils" %>
<%@page import="java.io.*, java.util.Date, java.util.Enumeration, java.text.*" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

<%
try {

	//Get the database connection
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();

	//Create a SQL statement
	Statement stmt = con.createStatement();
	
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

	//Get parameters from createAuction.jsp
	//String img = request.getParameter("userImg").toLowerCase();
	String title = request.getParameter("title");
	String description = request.getParameter("desc");
	String type = request.getParameter("type");
	//String cat = request.getParameter("category");
	String color = request.getParameter("color");
	String size = request.getParameter("shoeSize");
	String brand = request.getParameter("brand");
	String condition = request.getParameter("condition");
	String material = request.getParameter("material");
	String minBidIncr = request.getParameter("minBid");
	
	//Check if img is jpg, jpeg, png format (doesn't formally verify the file's type in any way)
	/* if (!( img.endsWith(".jpg") || img.endsWith(".jpeg") || img.endsWith(".png"))){
			response.sendRedirect("badTopAuction.jsp");
			return;
	} */

	//If any of the number based field requirements are not numeric, then redirect to resubmit the form properly
	if (!StringUtils.isNumeric(request.getParameter("dd")) || !StringUtils.isNumeric(request.getParameter("mm"))
	||  !StringUtils.isNumeric(request.getParameter("yyyy")) || !StringUtils.isNumeric(request.getParameter("hh"))
	|| !StringUtils.isNumeric(request.getParameter("mi")) || !StringUtils.isNumeric(request.getParameter("minPriceDollar"))
	|| !StringUtils.isNumeric(request.getParameter("minPriceCent")) || !StringUtils.isNumeric(request.getParameter("startPriceDollar"))
	|| !StringUtils.isNumeric(request.getParameter("startPriceCent"))){
		response.sendRedirect("createShoeAuction1.jsp");
		return;
	}

	//Checking the format of datetime to be correct, if not redirect to be resubmitted
	if (request.getParameter("yyyy").length()!=4 || request.getParameter("mm").length()==0 || request.getParameter("dd").length()==0
		|| request.getParameter("hh").length()==0 || request.getParameter("mi").length()==0){
		response.sendRedirect("createShoeAuction1.jsp");
		return;
	}

	//Assigning variables the parameters for more checking
	String hr = request.getParameter("hh");
	int hours = Integer.parseInt(request.getParameter("hh"));
	int minutes = Integer.parseInt(request.getParameter("mi"));
	int day = Integer.parseInt(request.getParameter("dd"));
	int month = Integer.parseInt(request.getParameter("mm"));
	int year = Integer.parseInt(request.getParameter("yyyy"));
	//Check if datetime inputs are valid
	if (hours < 0 || hours > 24 || minutes < 0 || minutes > 59 || day < 0 || day > 31 || month < 0 || month > 12 ||
		year < 2018){
		response.sendRedirect("createShoeAuction1.jsp");
		return;
	}
	
	//Check if length of text fields are valid
	if (request.getParameter("title").length() > 50 ||
		request.getParameter("brand").length() > 50 || request.getParameter("condition").length() > 50 ||
		request.getParameter("material").length() > 50){
		response.sendRedirect("createShoeAuction1.jsp");
		return;
	}
	
    //Create string endDateTime even if mm, dd, hh, mi fields are only numeric 1 length inputs
    String endDateTime = request.getParameter("yyyy") + "-";
    if (request.getParameter("mm").length() == 1){
        String mm = "0" + request.getParameter("mm");
        endDateTime += mm + "-";
    }
    else{
        endDateTime += request.getParameter("mm") + "-";
    }
    if (request.getParameter("dd").length() == 1){
        String dd = "0" + request.getParameter("dd");
        endDateTime += dd + " ";
    }
    else{
        endDateTime += request.getParameter("dd") + " ";
    }
    if (request.getParameter("hh").length() == 1){
        String hh = "0" + request.getParameter("hh");
        endDateTime += hh + ":";
    }
    else{
        endDateTime += request.getParameter("hh") + ":";
    }
    if (request.getParameter("mi").length() == 1){
        String mi = "0" + request.getParameter("mi");
        endDateTime += mi + ":00";
    }
    else{
        endDateTime += request.getParameter("mi") + ":00";
    }
    
    DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    Date endDate = df.parse(endDateTime);
    DateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
	Date startdate = new Date();
	System.out.println(dateFormat.format(startdate));
	long diff = Math.abs(endDate.getTime() - startdate.getTime());
	long diffDays = diff / (24 * 60 * 60 * 1000);
	if(diffDays > 30){
		response.sendRedirect("createShoeAuction1.jsp");
		return;
	}
	
	//Format of float string
	String startPrice = request.getParameter("startPriceDollar") + "." + request.getParameter("startPriceCent");
	String minSalePrice = request.getParameter("minPriceDollar") + "." + request.getParameter("minPriceCent");
	
	//Convert string to float for money representation
	float minSalePrice2 = Float.parseFloat(minSalePrice);
	float startPrice2 = Float.parseFloat(startPrice);
	float minIncrement = Float.parseFloat(minBidIncr);
	
	if (startPrice2 > minSalePrice2){
		response.sendRedirect("createShoeAuction1.jsp");
		return;
	}
	
/* To-do: Store image





*/
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

	//Make an insert statement for the Auction table:
	String insert = "INSERT INTO newAuction(aid, title, `desc`, cat, type, size, color, brand, `condition`, material, startPrice, minIncr, minSalePrice, endDateTime, auc_user) "
			+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
	PreparedStatement ps = con.prepareStatement(insert);
	ps.setString(1, title);
	ps.setString(2, description);
	ps.setString(3, "top");
	ps.setString(4, type);
	ps.setString(5, size);
	ps.setString(6, color);
	ps.setString(7, brand);
	ps.setString(8, condition);
	ps.setString(9, material);
	ps.setFloat(10, startPrice2);
	ps.setFloat(11, minIncrement);
	ps.setFloat(12, minSalePrice2);
	ps.setString(13, endDateTime);
	ps.setString(14, username);
	//ps.setString(15, "img.jpg");
	ps.executeUpdate(); 
	response.sendRedirect("success.jsp");
	/* String str = "SELECT aid FROM newAuction WHERE title=\""+title+"\"";
	response.sendRedirect("viewAuction.jsp");
	ResultSet result = stmt.executeQuery(str);

	//Start parsing out the result of the query. Don't forget this statement. It opens up the result set.
	result.next();
	int auctionNum = result.getInt("aid");
	session.setAttribute("auctionId", auctionNum); */
}
catch(Exception ex){
	out.print(ex);
	out.print("\n" + "Failed to add auction");
}
%>

</body>
</html>