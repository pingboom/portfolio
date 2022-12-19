<%@page import="java.io.File"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:include page="00_home.jsp"></jsp:include>
<style>
	td {
		padding: 10px;
	}
    a { text-decoration: none; color: black; }
    a:visited { text-decoration: none; }
    a:hover { text-decoration: none; }
    a:focus { text-decoration: none; }
    a:hover, a:active { text-decoration: none; }
</style>

<%
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String[][] movieList = null;
	
	try{
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie?serverTimezone=UTC&useSSL=false";
		String dbId = "root";
		String dbPw = "root";
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
		
		String sql = "SELECT COUNT(distinct movie_title) FROM movielist";
		pstmt = conn.prepareStatement(sql);
		rs = pstmt.executeQuery();
		
		if(rs.next()){
			int size = rs.getInt(1);
			movieList = new String[size][2];
			
			sql = "SELECT distinct movie_title, movie_img FROM movielist";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			int i = 0;
			while(rs.next()){
				movieList[i][0] = rs.getString(1);
				movieList[i][1] = rs.getString(2);
				i++;
			}
		}
		
		conn.close();
		pstmt.close();
		rs.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
	
	int size = 0;
	File dir = new File(application.getRealPath("/") + "_movie");
	File files[] = dir.listFiles();
	for (int i = 0; i < files.length; i++) {
		String[] filesplit = files[i].toString().split("\\\\");
		String filename = filesplit[filesplit.length-1];
		if(filename.endsWith(".jpg") || filename.endsWith(".png")
				|| filename.endsWith(".gif")){
			size++;
		}
	}
	String[] imgList = new String[size];
	size = 0;
	for (int i = 0; i < files.length; i++) {
		String[] filesplit = files[i].toString().split("\\\\");
		String filename = filesplit[filesplit.length-1];
		if(filename.endsWith(".jpg") || filename.endsWith(".png")
				|| filename.endsWith(".gif")){
			imgList[size++] = filename;
		}
	}
	
	session.setAttribute("movieList", movieList);
%>

<div align="center">
	<h1 style="padding: 50px 0 20px 0;">영화목록</h1>
	<table style="text-align: center;">
		<%for(int i = 0, k = 0; i < movieList.length/3 + 1; i++){%>
			<tr>
			<%for(int j = 0; j < 3; j++, k++){%>
				<%if(k >= movieList.length){
					break;
				}
				
				boolean check = false;
				for(String img : imgList){
					if(img.equals(movieList[k][1])){
						check = true;
						break;
					}
				}
				if(check == false){
					movieList[k][1] = "ready.gif";
				}%>
				<td><a href="04_select_time.jsp?index=<%=k %>"><img src="<%=movieList[k][1] %>" width="300px;" height="430px;"></a>
				<br><br><a href="04_select_time.jsp?index=<%=k %>"><%=movieList[k][0] %></a></td>
			<%} %>
			</tr>
	<%	}%>
	</table>
</div>