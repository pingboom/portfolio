<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:include page="00_home.jsp"></jsp:include>
<%
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String[][] delmovieList = null;
	
	try{
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie?serverTimezone=UTC&useSSL=false";
		String dbId = "root";
		String dbPw = "root";
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
		
		String sql = "SELECT COUNT(*) FROM movielist";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			int size = rs.getInt(1);
			delmovieList = new String[size][5];
			
			sql = "SELECT * FROM movielist ORDER BY hall, start_time";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			int i = 0;
			while(rs.next()){
				delmovieList[i][0] = rs.getString(1);
				delmovieList[i][1] = rs.getString(2);
				delmovieList[i][2] = rs.getString(3);
				delmovieList[i][3] = rs.getString(4);
				delmovieList[i][4] = rs.getString(5);
				i++;
			}
		}
		
		conn.close();
		pstmt.close();
		rs.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	session.setAttribute("delmovieList", delmovieList);
%>
<style>
	td{
		text-align: center;
		padding: 5px;
	}
</style>
<div align="center">
	<div class="blank"></div>
	<div>
		<div align="center">
			<table>
				<%for(int i = 0; i < delmovieList.length; i++){ %>
					<% int hour = Integer.parseInt(delmovieList[i][2])/100;
					int min = Integer.parseInt(delmovieList[i][2])%100; %>
					<tr>
						<td><%=delmovieList[i][0] %>관</td>
						<td><%=delmovieList[i][1] %></td>
						<td>
						<%=hour %>시
						<%if(min == 0){%>
							<%="00" %>
						<%}else { %>
							<%=min %>
						<%} %>분
						</td>
						<td><%=delmovieList[i][3] %>분</td>
						<td><%=delmovieList[i][4] %></td>
						<td><button onclick="window.location.href='99_viewmovieRename.jsp?index=<%=i %>'">img 수정</button></td>
						<td><button onclick="window.location.href='99_viewmoviePro.jsp?index=<%=i %>'">삭제</button></td>
					</tr>
				<%} %>
			</table>
		</div>
	</div>
</div>