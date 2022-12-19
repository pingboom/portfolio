<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:include page="_home.jsp"></jsp:include>
<style>
	button{
		width: 100px;
		height: 100px;
	}
	.blank{
		width: 100%;
		height: 20px;
	}
	input[type="number"]{
		width: 80px;
	}
</style>
<%
	session.invalidate();
%>
<div align="center">
	<h1>지뢰찾기</h1>
	<h2>난이도 선택</h2>
	<button onclick="window.location.href='02_select.jsp?select=1'">초급</button>
	<button onclick="window.location.href='02_select.jsp?select=2'">중급</button>
	<button onclick="window.location.href='02_select.jsp?select=3'">고급</button>
	<br><br>
	<div class="blank"></div>혹은<div class="blank"></div>
	<form action="02_select.jsp?select=0" method="post">
		가로 : <input type="number" id="row" name="row" min="3" max="25"><br>
		세로 : <input type="number" id="col" name="col" min="3" max="25"><br>
		<!-- 지뢰 개수 > 가로 x 세로 / 3 -->
		<input type="submit" value="입력">
	</form>
</div>