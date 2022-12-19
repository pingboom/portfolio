<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="00_home.jsp"></jsp:include>
<style>
	.div_input{
		padding: 10px 0 10px 0;
		font-size: 20px;
		width: 450px;
		height: 30px;
		text-align: center;
	}
	.left{
		float: left;
		width: 40%;
	}
	.right{
		float: left;
		width: 60%;
	}
	input[type=text], input[type=password]{
		border: solid 1px #03c75a;
		border-radius: 6px;
		padding: 7px 8px 7px 9px;
	}
	input[type=submit]{
		width: 100px;
	    height: 50px;
	    margin: 30px 30px 30px 30px;
	    padding: 0 12px;
	    font-size: 13px;
	    display: inline-block;
	    border-radius: 6px;
	    border: 1px solid #00c73c;
	    background-color: white;
	    color: #00c73c;
	    box-sizing: border-box;
	    font-weight: 700;
	    text-align: center;
	    vertical-align: top;
	    font-size: 15px;
	}
	select{
		width: 60px;
		padding: 5px;
		border: 1px solid #999;
		font-family: 'Nanumgothic';
		border-radius: 3px;
		-webkit-appearance: none;
		-moz-appearance: none;
		appearance : none;
	}
</style>

<%
	String id = (String)session.getAttribute("log");
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	String[] member = null;
	
	try{
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie?serverTimezone=UTC&useSSL=false";
		String dbId = "root";
		String dbPw = "root";
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
		
		String sql = "SELECT * FROM memberlist WHERE id = ?";
		ps = conn.prepareStatement(sql);
		ps.setString(1, id);
		rs = ps.executeQuery();
		
		if(rs.next()){
			member = new String[5];
			
			for(int i = 0; i < member.length; i++){
				member[i] = rs.getString(i+1);
			}
		}
		conn.close();
		ps.close();
		rs.close();
	}catch(Exception e){}
	
	int year = Integer.parseInt(member[4].substring(0, 4));
	int month = Integer.parseInt(member[4].substring(5, 7));
	int day = Integer.parseInt(member[4].substring(8, 10));
%>

<script type="text/javascript" src="02_check.js"></script>
<div align="center">
	<div style="padding: 40px;">
		<form method="post" action="02_updatePro.jsp" accept-charset="utf-8">
			<div class="div_input">
				<div class="left">아이디 :</div>
				<div class="right"><input type="text" name="id" value="<%=member[0] %>" disabled></div>
				<input type="hidden" name="id" value="<%=member[0] %>">
			</div>
			<div class="div_input">
				<div class="left">패스워드 :</div>
				<div class="right"><input type="password" name="pw" value="<%=member[1] %>"></div>
			</div>
			<div class="div_input">
				<div class="left">이름 :</div>
				<div class="right"><input type="text" name="name" value="<%=member[2] %>"></div>
			</div>
			<div class="div_input">
				<div class="left">전화번호 :</div>
				<div class="right">
					<input type="hidden" name="phone1" value="010">
					<input type="text" name="phone1" size="3" maxlength="3" value="010" disabled> -
					<input type="text" name="phone2" size="4" maxlength="4" value="<%=member[3].substring(4, 8) %>"> -
					<input type="text" name="phone3" size="4" maxlength="4" value="<%=member[3].substring(9) %>">
				</div>
			</div>
			<div class="div_input">
				<div class="left">생년월일 :</div>
				<div class="right">
					<select name="year">
						<option value="null">선택</option>
						<%for(int i = 1920; i <= 2021; i++){ %>
							<%if(year == i){ %>
								<option value="<%=i %>" selected><%=i %></option>
							<%}else{ %>
								<option value="<%=i %>"><%=i %></option>
							<%} %>
						<%} %>
					</select>년
					<select name="month">
						<option value="null">선택</option>
						<%for(int i = 1; i <= 12; i++){ %>
							<%if(month == i){ %>
								<option value="<%=i %>" selected><%=i %></option>
							<%}else{ %>
								<option value="<%=i %>"><%=i %></option>
							<%} %>
						<%} %>
					</select>월
					<select name="day">
						<option value="null">선택</option>
						<%for(int i = 1; i <= 31; i++){ %>
							<%if(day == i){ %>
								<option value="<%=i %>" selected><%=i %></option>
							<%}else{ %>
								<option value="<%=i %>"><%=i %></option>
							<%} %>
						<%} %>
					</select>일
				</div>
			</div>
			<input type="submit" value="수정완료">
		</form>
	</div>
</div>