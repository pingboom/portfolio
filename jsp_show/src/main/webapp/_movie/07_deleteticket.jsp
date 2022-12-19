<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String[][] ticketList = (String[][])session.getAttribute("ticketList");
	int index = Integer.parseInt(request.getParameter("index"));
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try{
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie?serverTimezone=UTC&useSSL=false";
		String dbId = "root";
		String dbPw = "root";
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
		String sql = "DELETE FROM ticketList WHERE hall=? and movie_title=? and start_time=? and col=? and num=? and id=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, ticketList[index][0]);
		pstmt.setString(2, ticketList[index][1]);
		pstmt.setString(3, ticketList[index][2]);
		pstmt.setString(4, ticketList[index][3]);
		pstmt.setString(5, ticketList[index][4]);
		pstmt.setString(6, ticketList[index][5]);
		pstmt.executeUpdate();
		
		conn.close();
		pstmt.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
	response.sendRedirect("06_viewticket.jsp");
%>