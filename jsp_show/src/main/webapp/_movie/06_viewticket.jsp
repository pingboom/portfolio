<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:include page="00_home.jsp"></jsp:include>
<style>
	th{
		width: 100px;
		height: 30px;
		font-weight: bold;
		vertical-align: middle;
		font-size: 16px;
	}
	tr, td{
		width: 80px;
		height: 30px;
		text-align: center;
		font-weight: normal;
		padding: 5px;
	}
	.show_sum{
		position: relative;
		left: -15px;
		display: inline-block;
	}
</style>
<%
	String id = (String)session.getAttribute("id");
	String name = (String)session.getAttribute("name");

	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String[][] ticketList = null;
	
	try{
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie?serverTimezone=UTC&useSSL=false";
		String dbId = "root";
		String dbPw = "root";
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
		
		String sql = "SELECT COUNT(*) FROM ticketlist WHERE id = ?";
		
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			int size = rs.getInt(1);
			ticketList = new String[size][6];
			
			sql = "SELECT * FROM ticketlist WHERE id=? ORDER BY hall, start_time, col, num";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			int i = 0;
			while(rs.next()){
				ticketList[i][0] = rs.getString(1);
				ticketList[i][1] = rs.getString(2);
				ticketList[i][2] = rs.getString(3);
				ticketList[i][3] = rs.getString(4);
				ticketList[i][4] = rs.getString(5);
				ticketList[i][5] = rs.getString(6);
				i++;
			}
		}
		
		conn.close();
		pstmt.close();
		rs.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	session.setAttribute("ticketList", ticketList);
%>

<div align="center">
	<div style="padding: 40px;">
		<table>
			<%for(int i = 0; i < ticketList.length; i++){ %>
				<% int hour = Integer.parseInt(ticketList[i][2])/100;
				int min = Integer.parseInt(ticketList[i][2])%100; %>
				<tr>
					<th><%=ticketList[i][0] %>관</th>
					<th><%=ticketList[i][1] %></th>
					<td>
					<%=hour %>시
					<%if(min == 0){%>
						<%="00" %>
					<%}else { %>
						<%=min %>
					<%} %>분
					</td>
					<td><%=ticketList[i][3] %>열</td>
					<td><%=ticketList[i][4] %>번</td>
					<td><button onclick="window.location.href='07_deleteticket.jsp?index=<%=i %>'">삭제</button></td>
				</tr>
			<%} %>
		</table>
	</div>
	<h3 class="show_sum">[<%=name %>]님의 총 구매 금액 : </h3>
	<h2 class="show_sum"><%=ticketList.length*12000 %>원</h2>
</div>