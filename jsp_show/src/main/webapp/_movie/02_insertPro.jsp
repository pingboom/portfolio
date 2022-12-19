<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="00_home.jsp"></jsp:include>
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
</style>
<% 	
	request.setCharacterEncoding("utf-8");
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");
	String name = request.getParameter("name");
	String phone1 = request.getParameter("phone1");
	String phone2 = request.getParameter("phone2");
	String phone3 = request.getParameter("phone3");
	String phone = phone1 + "-" + phone2 + "-" + phone3; 
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	String day = request.getParameter("day");
	String birth = year + "-" + month + "-" + day; 
	
	String checkList[] = {id, pw, name, phone1, phone2, phone3, year, month, day};
	
	int check = 0;
	for(String a : checkList){
		if(a == null || a.equals("") || a.equals("null")){
			check = 1;
			break;
		}
	}
	
	System.out.println(check);
%>
<%		
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	if(check == 0){
		try {
			String jdbcUrl = "jdbc:mysql://localhost:3306/movie?serverTimezone=UTC&useSSL=false";
			String dbId = "root";
			String dbPw = "root";
			
			Class.forName("com.mysql.cj.jdbc.Driver");
			conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
			
			String sql = "SELECT count(*) from memberlist WHERE id=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				if(rs.getInt(1) > 0){%>
					<script>
						alert("중복된 아이디입니다");
						location.href = history.back();
					</script>
				<%}else{
					sql = "INSERT INTO memberlist VALUES(?, md5(?), ?, ?, ?)";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, id);
					pstmt.setString(2, pw);
					pstmt.setString(3, name);
					pstmt.setString(4, phone);
					pstmt.setString(5, birth);
					
					pstmt.executeUpdate();
					conn.close();
					pstmt.close();
					%>
					<script>
						alert("회원가입 성공!")
						location.href = "01_main.jsp";
					</script>
					<%
				}
			}
			
		}catch(Exception e){
			e.printStackTrace();
		}
	}else if(check == 1){%>
		<script>
			alert("빈칸 없이 작성해주세요!");
			location.href = history.back();
		</script>
<%
	}
%>