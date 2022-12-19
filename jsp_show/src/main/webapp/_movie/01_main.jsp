<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="00_home.jsp"></jsp:include>
<style>
	.rightmenu{
		position: relative;
		float: right;
		padding: 10px 20px 0 0;
	}
	.middlemenu{
		position: relative;
		padding: 5px 0 5px 0;
		text-align: center;
	}
	.shopbutton{
		position: relative;
		top: 90px;
		font-size: 24px;
		color: black;
		font-family: fantasy;
		border: none;
	}
	.shopbutton:hover{
		color: #9d60ff;
	}
	.shopimg{
		width: 150px;
		height: 150px;
		padding: 30px 0 0 30px;
	}
	.downmenu{
		height: 70px;
		position: relative;
		padding: 30px;
		text-align: center;
	}
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
	h2{
		margin: 20px 0 0 20px;
	}
</style>
	<%
		String name = (String)session.getAttribute("name");
		String loginid = (String)session.getAttribute("log");
		if(session.getAttribute("log") == null) {
	%>
		<div style="width: 100%; height: 70px;">
			<div class="rightmenu">
				<button onclick="window.location.href='02_login.jsp'">로그인</button>
				<button onclick="window.location.href='02_insert.jsp'">회원가입</button>
			</div>
		</div>
		
		<div class="middlemenu">
			<img class="cinemaimg" src="cinema.png">
		</div>
	<%	
		}else if (session.getAttribute("log").equals("admin")){
	%>
			<div style="width: 100%; height: 70px;">
				<div class="rightmenu">
					<h2 style="display: inline-block;">[<%=name %>]님 로그인</h2>
					<button onclick="window.location.href='02_logout.jsp'">로그아웃</button>
				</div>
			</div>
			
			<div class="middlemenu">
				<img class="cinemaimg" src="cinema.png">
			</div>
				
			<div style="width: 100%; height: 70px;">
				<div class="downmenu">
					<button onclick="window.location.href='99_addmovie.jsp'">영화추가</button>
					<button onclick="window.location.href='99_viewmovie.jsp'">영화출력</button>
					<button onclick="window.location.href='99_viewticket.jsp'">예매출력</button>
				</div>
			</div>
	<%
		}else{
	%>
			<div style="width: 100%; height: 70px;">
				<div class="rightmenu">
					<h2 style="display: inline-block;">[<%=name %>]님 로그인</h2>
					<button onclick="window.location.href='02_update.jsp'">정보수정</button>
					<button onclick="window.location.href='02_logout.jsp'">로그아웃</button>
				</div>
			</div>
	
			<div class="middlemenu">
				<img class="cinemaimg" src="cinema.png">
			</div>

			<div style="width: 100%; height: 70px;">
				<div class="downmenu">
					<button onclick="window.location.href='03_ticketing.jsp'">영화예매</button>
					<button onclick="window.location.href='06_viewticket.jsp'">예매확인</button>
				</div>
			</div>
	<%	
		}
	%>
