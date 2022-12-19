<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:include page="00_home.jsp"></jsp:include>
<%
	request.setCharacterEncoding("utf-8");

	int hall = 0;
	String title = null;
	int hour = 0;
	int minute = 0;
	int r_time = 0;
	
	int start_time1 = 0;
	int movie_time1 = 0;
	int start_time2 = 0;
	int movie_time2 = 0;
	int hour_minute2 = 0;
	
	if(request.getParameter("title").equals("") || request.getParameter("hour").equals("") 
			|| request.getParameter("minute").equals("") || request.getParameter("r_time").equals("")){
		%>
		<script>
			alert("빈칸 없이 작성해주세요.");
			location.href = history.back();
		</script>
	<%
	}else{
		hall = Integer.parseInt(request.getParameter("hall"));
		title = request.getParameter("title");
		hour = Integer.parseInt(request.getParameter("hour"));
		minute = Integer.parseInt(request.getParameter("minute"));
		r_time = Integer.parseInt(request.getParameter("r_time"));
		String hour_minute = Integer.toString(hour) + Integer.toString(minute);
		hour_minute2 = Integer.parseInt(hour_minute);
		
		if(hour > 24 || minute >= 60){
			%>
				<script>
					alert("시간을 제대로 입력해주세요.");
					location.href = history.back();
				</script>
			<%			
		}else{
			Connection conn = null;
			PreparedStatement pstmt = null;
			ResultSet rs = null;
			
			try{
				String jdbcUrl = "jdbc:mysql://localhost:3306/movie?serverTimezone=UTC&useSSL=false";
				String dbId = "root";
				String dbPw = "root";
				
				Class.forName("com.mysql.cj.jdbc.Driver");
				conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
				
				String sql = "SELECT count(*) FROM movielist WHERE hall = ? and start_time = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, hall);
				pstmt.setInt(2, hour_minute2);
				rs = pstmt.executeQuery();
				
				if(rs.next()){
					if(rs.getInt(1) > 0){
						%>
							<script>
								alert("시간을 정확히 입력해주세요.");
								location.href = history.back();
							</script>
						<%
					}else{
						try{
							jdbcUrl = "jdbc:mysql://localhost:3306/movie?serverTimezone=UTC&useSSL=false";
							
							Class.forName("com.mysql.cj.jdbc.Driver");
							conn = DriverManager.getConnection(jdbcUrl, dbId, dbPw);
							
							sql = "SELECT start_time, movie_time FROM movielist WHERE hall = ? and start_time < ? order by start_time DESC";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, hall);
							pstmt.setInt(2, hour_minute2);
							rs = pstmt.executeQuery();
							
							if(rs.next()){
								start_time1 = rs.getInt(1);
								movie_time1 = rs.getInt(2);
							}
							
							sql = "SELECT start_time, movie_time FROM movielist WHERE hall = ? and start_time > ? order by start_time";
							pstmt = conn.prepareStatement(sql);
							pstmt.setInt(1, hall);
							pstmt.setInt(2, hour_minute2);
							rs = pstmt.executeQuery();
							
							if(rs.next()){
								start_time2 = rs.getInt(1);
								movie_time2 = rs.getInt(2);
							}
							hour_minute2 = hour_minute2/100 * 60 + hour_minute2%100;
							start_time1 = start_time1/100 * 60 + start_time1%100;
							start_time2 = start_time2/100 * 60 + start_time2%100;
							if((start_time1 == 0 || start_time1+movie_time1 < hour_minute2)
									&& (hour_minute2+r_time < start_time2 || start_time2 == 0)){
								sql = "INSERT INTO movielist VALUES(?, ?, ?, ?, 'ready.gif')";
								pstmt = conn.prepareStatement(sql);
								pstmt.setInt(1, hall);
								pstmt.setString(2, title);
								pstmt.setInt(3, Integer.parseInt(hour_minute));
								pstmt.setInt(4, r_time);
								pstmt.executeUpdate();
								
								conn.close();
								pstmt.close();
								rs.close();
								response.sendRedirect("99_viewmovie.jsp");
							}else{
							%>
							<script>
								alert("중복된 시간입니다.");
								location.href = history.back();
							</script>
							<%
							}
							
						}catch(Exception e){
							e.printStackTrace();
						}
					}
				}
			}catch(Exception e){
				e.printStackTrace();
			}
		}
	}
	
%>
