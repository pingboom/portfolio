<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:include page="00_home.jsp"></jsp:include>
<style>
	.selectmovie{
		width: 100%;
		text-align: right;
	}
	.position{
		padding: 50px 0 50px 0;
	}
	.selectbutton{
		width: 100px;
	    height: 50px;
	    margin-left: 20px;
	    font-size: 13px;
	    display: inline-block;
	    border-radius: 6px;
	    border: 1px solid skyblue;
	    background-color: white;
	    color: skyblue;
	    box-sizing: border-box;
	    font-weight: 700;
	    text-align: center;
	    vertical-align: top;
	    font-size: 15px;
	}
	td{
		text-align: center;
		width: 50px;
		height: 50px;
	}
	.blank{
		width: 100%;
		height: 60px;
	}
	input[type="checkbox"] {
	    width: 15px;
		height: 15px;
	}
</style>
<%
	String[][] movieList = (String[][])session.getAttribute("movieList");
	int[][] timeList = (int[][])session.getAttribute("timeList");
	int index = Integer.parseInt(request.getParameter("index"));
	int select = Integer.parseInt(request.getParameter("select"));
	
	String name = (String)session.getAttribute("name");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String[] seatList = null;
	
	try{
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie?serverTimezone=UTC&useSSL=false";
		String dbId = "root";
		String dbPw = "root";
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
		
		String sql = "SELECT COUNT(*) FROM ticketlist WHERE hall = ? AND movie_title = ? AND start_time = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setInt(1, timeList[select][0]);
		pstmt.setString(2, movieList[index][0]);
		pstmt.setInt(3, timeList[select][1]);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			int size = rs.getInt(1);
			seatList = new String[size];
			
			sql = "SELECT col, num FROM ticketlist WHERE hall = ? AND movie_title = ? AND start_time = ? ORDER BY col, num";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, timeList[select][0]);
			pstmt.setString(2, movieList[index][0]);
			pstmt.setInt(3, timeList[select][1]);
			rs = pstmt.executeQuery();
			
			int i = 0;
			while(rs.next()){
				seatList[i] = rs.getString(1) + rs.getString(2);
				i++;
			}
		}
		
		conn.close();
		pstmt.close();
		rs.close();
	}catch(Exception e){
		e.printStackTrace();
	}
%>
<!-- 좌석 선택 -->
<!-- 2 6 2 -->
<!-- 고를 수 없는 좌석 -->
<div class="rightmenu">
	<button onclick="window.location.href='03_ticketing.jsp'">영화선택</button>
</div>
<div class="blank"></div>
<form action="05_select_seatPro.jsp">
	<div align="center">
		<img src="screen.png" style="width: 75%">
	</div>
	<div class="blank"></div>
	<div>
		<div align="center">
			<table border="1">
				<%int start = 0; %>
				<%for(int i = 0; i < 7; i++){ %>
					<%char col = (char)(i + 65); %>
					<tr>
					<%for(int j = 0; j < 10; j++){ %>
						<%if(j == 2 || j == 7){ %>
							<td></td>
						<%} %>
						<%if(start < seatList.length){ %>
							<%boolean check = false; %>
							<%for(int k = start; k < seatList.length; k++){ %>
								<%if(col == seatList[k].charAt(0) && j+1 == Integer.parseInt(seatList[k].substring(1))){ %>
									<%check = true; start++;%>
								<%} %>
							<%} %>
							<%if(check == true){ %>
								<td><%=col %><%=j+1 %><br><input type="checkbox" name="seat" value="<%=col %><%=j+1 %>" disabled="disabled"></td>
							<%}else{ %>
								<td><%=col %><%=j+1 %><br><input type="checkbox" name="seat" value="<%=col %><%=j+1 %>"></td>
							<%} %>
						<%}else{ %>
							<td><%=col %><%=j+1 %><br><input type="checkbox" name="seat" value="<%=col %><%=j+1 %>"></td>
						<%} %>
					<%} %>
					</tr>
				<%} %>
			</table>
			<div class="blank"></div>
			<input type="hidden" name="index" value="<%=index %>">
			<input type="hidden" name="hall" value="<%=timeList[select][0] %>">
			<input type="hidden" name="time" value="<%=timeList[select][1] %>">
			<input class="selectbutton" type="submit" value="선택완료">
		</div>
	</div>
</form>