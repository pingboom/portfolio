<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
<style>
	button{
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
	.blank{
		height: 50px;
	}
</style>
</head>
<body>
	<div align="center">
		<%for(int i = 0; i < 3; i++){ %><div class="blank"></div><%} %>
		<button onclick="window.location.href='_mine/01_index.jsp'">지뢰찾기</button>
		<div class="blank"></div>
		<button onclick="window.location.href='_movie/index.jsp'">영화예매</button>
	</div>
</body>
</html>