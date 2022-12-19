<%@page import="java.util.Random"%>
<%@ page language="java" contentType="terowt/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%
	Random ran = new Random();
	String[][] map = (String[][])session.getAttribute("map");
	int[][] minecount = (int[][])session.getAttribute("minecount");
	int hint = (int)session.getAttribute("hint");
	
	boolean[][] check = (boolean[][])session.getAttribute("check");
	
	while(true){
		int row = ran.nextInt(map.length);
		int col = ran.nextInt(map[0].length);
		int x = row;
		int y = col;
		int dis_x = 3;
		int dis_y = 3;
		if(x < 1) {dis_x -= 1;}
		else if(x >= 1 && x < map.length-1) {x -= 1;}
		else if(x >= map.length-1) {x -= 1; dis_x -= 1;}
		if(y < 1) {dis_y -= 1;}
		else if(y >= 1 && y < map[0].length-1) {y -= 1;}
		else if(y >= map[0].length-1) {y -= 1; dis_y -= 1;}
		
		int count = 0;
		for(int i = 0; i < dis_x; i++) {
			for(int j = 0; j < dis_y; j++) {
				if(map[x+i][y+j] == "¡Ú"){
					count += 1;
				}
			}
		}
		minecount[row][col] = count;
		
		if(check[row][col] == false && map[row][col] == " "){
			check[row][col] = true;
			hint = 1;
			break;
		}
	}
	
	session.setAttribute("hint", hint);
	session.setAttribute("check", check);
	response.sendRedirect("03_start.jsp");
%>