<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:include page="00_home.jsp"></jsp:include>
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
	for(int i = 0; i < checkList.length; i++){
		if(checkList[i] == null || checkList[i].equals("")){
			check = 1;
			break;
		}
	}
%>
<%		
	Connection conn = null;
	PreparedStatement ps = null;
	ResultSet rs = null;
	
	if(check == 0){
		String jdbcUrl = "jdbc:mysql://localhost:3306/movie?serverTimezone=UTC&useSSL=false";
		String dbId = "root";
		String dbPw = "root";
		
		Class.forName("com.mysql.cj.jdbc.Driver");
		conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
		String sql = null;
		
		try{
			sql = "SELECT pw FROM memberlist WHERE id = ?";
			ps = conn.prepareStatement(sql);
			ps.setString(1, id);
			rs = ps.executeQuery();
			
			if(rs.next()){
				String result = rs.getString(1);
				if(pw.equals(result)){
					sql = "UPDATE memberlist SET pw=?, name=?, phone=?, birth=? WHERE id=?";
				}else{
					sql = "UPDATE memberlist SET pw=md5(?), name=?, phone=?, birth=? WHERE id=?";
				}
				ps = conn.prepareStatement(sql);
				ps.setString(1, pw);
				ps.setString(2, name);
				ps.setString(3, phone);
				ps.setString(4, birth);
				ps.setString(5, id);
				ps.executeUpdate();
				conn.close();
				ps.close();
				rs.close();
			}
			%>
			<script>
				alert("수정 완료!")
				location.href = "01_main.jsp";
			</script>
			<%
		}catch(Exception e){
			e.printStackTrace();
		}
	}else{%>
		<script>
			alert("빈칸 없이 작성해주세요!");
			location.href = history.back();
		</script>
<%
	}
%>