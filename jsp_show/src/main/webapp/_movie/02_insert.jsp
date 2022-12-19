<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="00_home.jsp"></jsp:include>
<style>
	.div_input{
		padding: 10px 0 10px 0;
		font-size: 20px;
		width: 450px;
		height: 30px;
		text-align: center;
	}
	.left{
		float: left;
		width: 40%;
	}
	.right{
		float: left;
		width: 60%;
	}
	input[type=text], input[type=password]{
		border: solid 1px #03c75a;
		border-radius: 6px;
		padding: 7px 8px 7px 9px;
	}
	input[type=submit]{
		width: 100px;
	    height: 50px;
	    margin: 30px 30px 30px 30px;
	    padding: 0 12px;
	    font-size: 13px;
	    display: inline-block;
	    border-radius: 6px;
	    border: 1px solid #00c73c;
	    background-color: white;
	    color: #00c73c;
	    box-sizing: border-box;
	    font-weight: 700;
	    text-align: center;
	    vertical-align: top;
	    font-size: 15px;
	}
	select{
		width: 60px;
		padding: 5px;
		border: 1px solid #999;
		font-family: 'Nanumgothic';
		border-radius: 3px;
		-webkit-appearance: none;
		-moz-appearance: none;
		appearance : none;
	}
</style>
<script type="text/javascript" src="02_check.js"></script>
<div align="center">
	<div style="padding: 40px;">
		<form method="post" action="02_insertPro.jsp" accept-charset="utf-8">
			<div class="div_input">
				<div class="left">아이디 :</div>
				<div class="right"><input type="text" name="id"></div>
			</div>
			<div class="div_input">
				<div class="left">패스워드 :</div>
				<div class="right"><input type="password" name="pw"></div>
			</div>
			<div class="div_input">
				<div class="left">이름 :</div>
				<div class="right"><input type="text" name="name"></div>
			</div>
			<div class="div_input">
				<div class="left">전화번호 :</div>
				<div class="right">
					<input type="hidden" name="phone1" value="010">
					<input type="text" name="phone1" size="3" maxlength="3" value="010" disabled> -
					<input type="text" name="phone2" size="4" maxlength="4"> -
					<input type="text" name="phone3" size="4" maxlength="4">
				</div>
			</div>
			<div class="div_input">
				<div class="left">생년월일 :</div>
				<div class="right">
					<select name="year">
						<option value="null">선택</option>
						<%for(int i = 1920; i <= 2021; i++){ %>
							<option value="<%=i %>"><%=i %></option>
						<%} %>
					</select>년
					<select name="month">
						<option value="null">선택</option>
						<%for(int i = 1; i <= 12; i++){ %>
							<option value="<%=i %>"><%=i %></option>
						<%} %>
					</select>월
					<select name="day">
						<option value="null">선택</option>
						<%for(int i = 1; i <= 31; i++){ %>
							<option value="<%=i %>"><%=i %></option>
						<%} %>
					</select>일
				</div>
			</div>
			<input type="submit" value="회원가입">
		</form>
	</div>
</div>