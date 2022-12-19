<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:include page="00_home.jsp"></jsp:include>
<style>
	.div_input{
		padding: 10px 0 10px 0;
		font-size: 20px;
		width: 500px;
		height: 30px;
		text-align: center;
	}
	.left{
		float: left;
		width: 40%;
	}
	input[type=text]{
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
</style>

<%
	String[][] delmovieList = (String[][])session.getAttribute("delmovieList");
	int index = Integer.parseInt(request.getParameter("index"));
%>

<div align="center">
	<div style="padding: 40px;">
		<form method="post" action="99_viewmovieRenamePro.jsp" accept-charset="utf-8">
			<div class="div_input">
				<div class="left">이미지 파일 이름 :</div>
				<div class="left"><input type="text" name="movie_title" value="<%=delmovieList[index][4] %>"></div>
				<input type="hidden" name="index" value="<%=index %>">
			</div>
			<input type="submit" value="수정완료">
		</form>
	</div>
</div>