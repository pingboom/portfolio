<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:include page="00_home.jsp"></jsp:include>

<%
	String[][] movieList = (String[][])session.getAttribute("movieList");
	int index = Integer.parseInt(request.getParameter("index"));
	int time = Integer.parseInt(request.getParameter("time"));
	int hall = Integer.parseInt(request.getParameter("hall"));
	
	String id = (String)session.getAttribute("id");
	String[] seatList = request.getParameterValues("seat");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	int[] timeList = null;
	if(seatList == null){
	%>
		<script>
			alert("�ڸ��� ���õ��� �ʾҽ��ϴ�.");
			location.href = history.back();
		</script>
	<%
	}else{
		try{
			String jdbcUrl = "jdbc:mysql://localhost:3306/movie?serverTimezone=UTC&useSSL=false";
			String dbId = "root";
			String dbPw = "root";
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
			
			String sql = "";
			
			for(int i = 0; i < seatList.length; i++){
				sql = "INSERT INTO ticketlist VALUES (?, ?, ?, ?, ?, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, hall);
				pstmt.setString(2, movieList[index][0]);
				pstmt.setInt(3, time);
				pstmt.setString(4, String.valueOf(seatList[i].charAt(0)));
				pstmt.setString(5, seatList[i].substring(1));
				pstmt.setString(6, id);
				
				pstmt.executeUpdate();
			}
			
			conn.close();
			pstmt.close();
			rs.close();
			%>
			<%
		}catch(Exception e){
			e.printStackTrace();
		}
	}
%>
<script>
	alert("���Ű� �Ϸ�Ǿ����ϴ�.");
</script>
<div align="center">
	<h1>���Ÿ� ����Ͻðڽ��ϱ�?</h1>
	<button onclick="window.location.href='03_ticketing.jsp'">YES</button>
	<button onclick="window.location.href='06_viewticket.jsp'">NO</button>
</div>