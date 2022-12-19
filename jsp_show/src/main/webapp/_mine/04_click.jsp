<%@page import="java.util.Random"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>

<%
	Random ran = new Random();
	int row = Integer.parseInt(request.getParameter("x"));
	int col = Integer.parseInt(request.getParameter("y"));
	
	String[][] map = (String[][])session.getAttribute("map");
	int[][] minecount = (int[][])session.getAttribute("minecount");
	boolean[][] check = (boolean[][])session.getAttribute("check");
	int start = (int)session.getAttribute("start");
	int end = (int)session.getAttribute("end");
	
	if(start == 0){
		if(map[row][col] == "★"){ // 처음 클릭한 부분이 폭탄이 아니게 만들어준다.
			map[row][col] = " ";
			while(true){
				int mine_x = ran.nextInt(map.length);
				int mine_y = ran.nextInt(map[0].length);
				if(map[mine_x][mine_y] == " "){
					map[mine_x][mine_y] = "★";
					break;
				}
			}
		}
	}
	if(map[row][col] == "★"){ // 패배
		end = 2;
	}
	
	start = 1;
	check[row][col] = true;
	
	int dis_x = 3;
	int dis_y = 3;
	
	int x = row;
	int y = col;
	
	// 고른 좌표 주변을 검색할 수 있게 범위를 지정
	if(x < 1) {dis_x -= 1;}
	else if(x >= 1 && x < map.length-1) {x -= 1;}
	else if(x >= map.length-1) {x -= 1; dis_x -= 1;}
	if(y < 1) {dis_y -= 1;}
	else if(y >= 1 && y < map[0].length-1) {y -= 1;}
	else if(y >= map[0].length-1) {y -= 1; dis_y -= 1;}
	
	int count = 0;
	for(int i = 0; i < dis_x; i++) {
		for(int j = 0; j < dis_y; j++) {
			if(map[x+i][y+j] == "★"){
				count += 1;
			}
		}
	}
	minecount[row][col] = count; // 고른 버튼 주변 지뢰 숫자 count
	
	session.setAttribute("start", start);
	session.setAttribute("end", end);
	session.setAttribute("check", check);
	response.sendRedirect("03_start.jsp");
%>