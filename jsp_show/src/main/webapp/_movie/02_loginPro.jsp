<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

	<%
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try{
			String jdbcUrl = "jdbc:mysql://localhost:3306/movie?serverTimezone=UTC&useSSL=false";
			String dbId = "root";
			String dbPw = "root";
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
			
			String sql = "SELECT COUNT(*) FROM memberlist WHERE id=? AND pw=md5(?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pw);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				int result = rs.getInt(1);
				if(result == 1){
					session.setAttribute("log", id);
					sql = "SELECT name FROM memberlist WHERE id=? AND pw=md5(?)";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.setString(2, pw);
					rs = pstmt.executeQuery();
					if(rs.next()){
						session.setAttribute("name", rs.getString(1));
						session.setAttribute("id", id);
					}
					
					conn.close();
					pstmt.close();
					rs.close();
					%>
					<script>
						alert("로그인 성공!")
						location.href = "01_main.jsp";
					</script>
					<%
				}else{%>
					<script>
						alert("로그인 실패!")
						location.href = history.back();
					</script>
				<%}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	%>