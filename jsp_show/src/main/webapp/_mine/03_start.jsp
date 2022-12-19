<%@page import="java.util.Arrays"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:include page="_home.jsp"></jsp:include>
<style>
	button{
		width: 100px;
		height: 100px;
		font-size: 30px;
		background-color: white;
		border-radius: 10px;
	}
	.hint{
		width: 100px;
		height: 50px;
		font-size: 15px;
	}
	.mine{
		background-image: url("mine.png");
		background-size: 100%;
		background-repeat: no-repeat;
	}
	.check{
		background-image: url("flag.png");
		background-size: 100%;
		background-repeat: no-repeat;
	}
	.reset{
		width: 100px;
		height: 50px;
		font-size: 15px;
	}
</style>
<%
	String[][] map = (String[][])session.getAttribute("map");
	int[][] minecount = (int[][])session.getAttribute("minecount");
	boolean[][] check = (boolean[][])session.getAttribute("check");
	int count = (int)session.getAttribute("count");
	int end = (int)session.getAttribute("end");
	int hint = (int)session.getAttribute("hint");
	int mine = (int)session.getAttribute("mine");
	int select = (int)session.getAttribute("select");
	
	for(int i = 0; i < map.length; i++){
		System.out.println(Arrays.toString(map[i]));
	}
	System.out.println("----------------");
	
	int countmine = 0;
	for(int i = 0; i < map.length; i++){
		for(int j = 0; j < map[i].length; j++){
			if(check[i][j] == false){
				countmine += 1;
			}
		}
	}
	if(countmine == mine){ // 승리
		end = 1;
	}
%>
<div align="center">
<%if(end == 0){ %>
	<%if(select == 1){ %>
		<h1>초급</h1>
	<%}else if(select == 2){ %>
		<h1>중급</h1>
	<%}else if(select == 3){ %>
		<h1>고급</h1>
	<%}else{ %>
		<h1>사용자 지정</h1>
	<%} %>
	<%for(int i = 0; i < map.length; i++){%>
		<%for(int j = 0; j < map[i].length; j++){%>
			<%if(check[i][j] == false){ %>
				<button onclick="window.location.href='04_click.jsp?x=<%=i%>&y=<%=j%>'">&nbsp;&nbsp;</button>
			<%}else{ %>
				<button disabled>&nbsp;<%=minecount[i][j] %>&nbsp;</button>
			<%} %>
		<%} %><br>
	<%} %><br>
	<%if(hint == 0){ %>
		<button class="hint" onclick="window.location.href='05_hint.jsp'">힌트<br>(1회용)</button>
	<%} %>
<%}else if(end == 1){ %>
	<h1>승리!</h1>
	<%for(int i = 0; i < map.length; i++){%>
		<%for(int j = 0; j < map[i].length; j++){%>
			<%if(map[i][j].equals("★")){ %>
				<button class="mine" disabled></button>
			<%}else{ %>
				<button class="check" disabled></button>
			<%} %>
		<%} %><br>
	<%} %>
	<br><br>
	<button class="reset" onclick="window.location.href='01_index.jsp'">다시하기</button>
<%}else if(end == 2){ %>
	<h1>패배!</h1>
	<%for(int i = 0; i < map.length; i++){%>
		<%for(int j = 0; j < map[i].length; j++){%>
			<%if(map[i][j].equals("★")){ %>
				<button class="mine" disabled>&nbsp;</button>
			<%}else{ %>
				<button class="check" disabled>&nbsp;</button>
			<%} %>
		<%} %><br>
	<%} %>
	<br><br>
	<button class="reset" onclick="window.location.href='01_index.jsp'">다시하기</button>
<%} %>
</div>