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
	String[][] delticketList = null;
	
	try{
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie?serverTimezone=UTC&useSSL=false";
		String dbId = "root";
		String dbPw = "root";
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
		
		String sql = "SELECT COUNT(*) FROM ticketlist";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			int size = rs.getInt(1);
			delticketList = new String[size][6];
			
			sql = "SELECT * FROM ticketlist ORDER BY hall, start_time, col";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			
			int i = 0;
			while(rs.next()){
				delticketList[i][0] = rs.getString(1);
				delticketList[i][1] = rs.getString(2);
				delticketList[i][2] = rs.getString(3);
				delticketList[i][3] = rs.getString(4);
				delticketList[i][4] = rs.getString(5);
				delticketList[i][5] = rs.getString(6);
				i++;
			}
		}
		
		conn.close();
		pstmt.close();
		rs.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	session.setAttribute("delticketList", delticketList);
%>

<div align="center">
	<div class="blank"></div>
	<div>
		<div align="center">
			<table>
				<%for(int i = 0; i < delticketList.length; i++){ %>
					<% int hour = Integer.parseInt(delticketList[i][2])/100;
					int min = Integer.parseInt(delticketList[i][2])%100; %>
					<tr>
						<td><%=delticketList[i][0] %>관</td>
						<td><%=delticketList[i][1] %></td>
						<td>
						<%=hour %>시
						<%if(min == 0){%>
							<%="00" %>
						<%}else { %>
							<%=min %>
						<%} %>분
						</td>
						<td><%=delticketList[i][3] %>열 <%=delticketList[i][4] %>번</td>
						<td>아이디:<%=delticketList[i][5] %></td>
						<td><button onclick="window.location.href='99_viewticketPro.jsp?index=<%=i %>'">삭제</button></td>
					</tr>
				<%} %>
			</table>
		</div>
	</div>
</div>