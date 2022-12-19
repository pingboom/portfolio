<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:include page="00_home.jsp"></jsp:include>

<%
	String[][] delmovieList = (String[][])session.getAttribute("delmovieList");
	int index = Integer.parseInt(request.getParameter("index"));
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	
	try{
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie?serverTimezone=UTC&useSSL=false";
		String dbId = "root";
		String dbPw = "root";
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
		String sql = "DELETE FROM ticketlist WHERE hall=? and movie_title=? and start_time=?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, delmovieList[index][0]);
		pstmt.setString(2, delmovieList[index][1]);
		pstmt.setString(3, delmovieList[index][2]);
		pstmt.executeUpdate();
		
		conn.close();
		pstmt.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	response.sendRedirect("99_viewmovie.jsp");
%>