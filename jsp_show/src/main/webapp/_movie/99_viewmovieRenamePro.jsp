<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<% request.setCharacterEncoding("EUC-KR"); %>

<%
	String[][] delmovieList = (String[][])session.getAttribute("delmovieList");
	int index = Integer.parseInt(request.getParameter("index"));
	String movie_title = request.getParameter("movie_title");
	
	Connection conn = null;
	PreparedStatement pstmt = null;

	try{
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie?serverTimezone=UTC&useSSL=false";
		String dbId = "root";
		String dbPw = "root";
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
		
		String sql = "UPDATE movielist SET movie_img=? WHERE hall=? and movie_title=? and start_time=? and movie_time=?";
		pstmt = conn.prepareStatement(sql);
	    pstmt.setString(1, movie_title);
	    for(int i = 0; i < 4; i++){
	    	pstmt.setString(i+2, delmovieList[index][i]);
	    }
	    pstmt.executeUpdate();
		
		
		conn.close();
		pstmt.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	response.sendRedirect("99_viewmovie.jsp");
%>