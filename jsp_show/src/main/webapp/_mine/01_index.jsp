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
	<h1>����ã��</h1>
	<h2>���̵� ����</h2>
	<button onclick="window.location.href='02_select.jsp?select=1'">�ʱ�</button>
	<button onclick="window.location.href='02_select.jsp?select=2'">�߱�</button>
	<button onclick="window.location.href='02_select.jsp?select=3'">���</button>
	<br><br>
	<div class="blank"></div>Ȥ��<div class="blank"></div>
	<form action="02_select.jsp?select=0" method="post">
		���� : <input type="number" id="row" name="row" min="3" max="25"><br>
		���� : <input type="number" id="col" name="col" min="3" max="25"><br>
		<!-- ���� ���� > ���� x ���� / 3 -->
		<input type="submit" value="�Է�">
	</form>
</div>