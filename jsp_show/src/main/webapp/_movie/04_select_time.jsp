<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:include page="00_home.jsp"></jsp:include>
<style>
	.selectmovie{
		position: relative;
		float: right;
		padding: 10px 20px 0 0;
	}
	.div_input{
		padding: 10px 0 10px 0;
		font-size: 20px;
		width: 1200px;
		height: 500px;
		text-align: center;
	}
	.left{
		padding: 0 20px 0 20px;
		float: left;
		width: 40%;
	}
	.selectbutton{
		width: 100px;
		height: 50px;
		border-color: gray;
		background-color: gray;
		color: #fff;
		padding: 7px 13px;
	    border: 1px solid #ccc;
	    font-size: 20px;
	    border-radius: 5px;
	}
	table{
		font-size: 24px;
	}
	td{
		padding: 10px 0 10px 0;
	}
</style>
<%
	String[][] movieList = (String[][])session.getAttribute("movieList");
	int index = Integer.parseInt(request.getParameter("index"));
	//movieList[index][0] 영화제목
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	int[][] timeList = null;
	int time_hall = 0;
	
	try{
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie?serverTimezone=UTC&useSSL=false";
		String dbId = "root";
		String dbPw = "root";
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
		
		String sql = "SELECT count(*) FROM movielist WHERE movie_title = ?";
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, movieList[index][0]);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			int size = rs.getInt(1);
			timeList = new int[size][2];
			
			sql = "SELECT * FROM movielist WHERE movie_title = ? order by hall";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, movieList[index][0]);
			rs = pstmt.executeQuery();
			int i = 0;
			while(rs.next()){
				timeList[i][0] = rs.getInt("hall");
				timeList[i][1] = rs.getInt("start_time");
				i++;
			}
		}
		
		conn.close();
		pstmt.close();
		rs.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
	session.setAttribute("timeList", timeList);
%>

<!-- 시간 선택 -->
<div class="selectmovie">
	<button onclick="window.location.href='03_ticketing.jsp'">영화선택</button>
</div>
<div align="center">
	<form action="05_select_seat.jsp">
		<div class="div_input">
			<div class="left">
				<img src="<%=movieList[index][1] %>" width=500px; height=500px;>
			</div>
			<div class="left">
				<div style="float: left;">
					<h1><%=movieList[index][0] %></h1>
					<h3>시간 선택</h3>
						<table>
						<%for(int i = 0; i < timeList.length; i++) {%>
							<%if(time_hall != timeList[i][0]){
								time_hall = timeList[i][0];
								%>
								<tr><th>[<%=time_hall %>관]</th></tr>
							<%} %>
								<tr>
									<td>
										<%if(i == 0){ %>
											<input type='radio' name='select' value='<%=i %>' checked>
											<%=timeList[i][1]/100 %>시
											<%if(timeList[i][1]%100 == 0){%>
												<%="00" %>
											<%}else { %>
												<%=timeList[i][1]%100 %>
											<%} %>분
										<%}else{ %>
											<input type='radio' name='select' value='<%=i %>'>
											<%=timeList[i][1]/100 %>시
											<%if(timeList[i][1]%100 == 0){%>
												<%="00" %>
											<%}else { %>
												<%=timeList[i][1]%100 %>
											<%} %>분
										<%} %>
									</td>
								</tr>
							<%}%>
						</table>
					<input type="hidden" name="index" value="<%=index %>">
					<input class="selectbutton" type="submit" value="선택">
				</div>
			</div>
		</div>
	</form>
</div>