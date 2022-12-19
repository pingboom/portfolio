<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	String[][] delticketList = (String[][])session.getAttribute("delticketList");
	int index = Integer.parseInt(request.getParameter("index"));
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try{
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie?serverTimezone=UTC&useSSL=false";
		String dbId = "root";
		String dbPw = "root";
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
		String sql = "DELETE FROM ticketlist WHERE hall=? and movie_title=? and start_time=? and col=? and num=? and id=?";
		pstmt = conn.prepareStatement(sql);
		for(int i = 0; i < delticketList[index].length; i++){
			pstmt.setString(i+1, delticketList[index][i]);
		}
		pstmt.executeUpdate();
		
		conn.close();
		pstmt.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	response.sendRedirect("99_viewticket.jsp");
%>