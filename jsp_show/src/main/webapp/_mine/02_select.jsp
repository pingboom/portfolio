<%@page import="java.util.Arrays"%>
<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:include page="_home.jsp"></jsp:include>
<%
	Random ran = new Random();
	int select = Integer.parseInt(request.getParameter("select"));
	
	int x = 0, y = 0, mine = 0;
	
	if(select == 1){ // ÃÊ±Þ
		x = 3; y = 3; mine = 3; // 3x3 Áö·Ú 3°³
	}else if(select == 2){ // Áß±Þ
		x = 4; y = 4; mine = 5; // 4x4 Áö·Ú 5°³
	}else if(select == 3){ // °í±Þ
		x = 5; y = 5; mine = 8; // 5x5 Áö·Ú 7°³
	}else{
		x = Integer.parseInt(request.getParameter("col"));
		y = Integer.parseInt(request.getParameter("row"));
		mine = x * y / 3;
	}
	
	String[][] map = new String[x][y]; // ¸Ê Å©±â ÁöÁ¤
	int[][] minecount = new int[x][y];
	boolean[][] check = new boolean[x][y];
	
	for(int i = 0; i < map.length; i++){
		for(int j = 0; j < map[i].length; j++){
			map[i][j] = " ";
		}
	}
	
	int count = 0;
	while(true) {                  // ¸Ê¿¡ Áö·Ú¸¦ ³Ö´Â ÀÛ¾÷
		if(count == mine) {break;}
		int row = ran.nextInt(x);
		int col = ran.nextInt(y);
		if(map[row][col] == " ") {
			map[row][col] = "¡Ú"; count += 1;
		}
	}
	
	session.setAttribute("select", select);
	session.setAttribute("hint", 0);
	session.setAttribute("map", map);
	session.setAttribute("minecount", minecount);
	session.setAttribute("check", check);
	session.setAttribute("mine", mine);
	session.setAttribute("end", 0);
	session.setAttribute("count", 0);
	session.setAttribute("start", 0);
	response.sendRedirect("03_start.jsp");
%>