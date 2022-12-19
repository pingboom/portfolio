<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:include page="00_home.jsp"></jsp:include>
<style>
	.div_input{
		padding: 10px 0 10px 0;
		font-size: 20px;
		width: 300px;
		height: 30px;
		text-align: center;
	}
	.left{
		float: left;
		width: 40%;
	}
	input[type=text], input[type=password]{
		border: solid 1px #03c75a;
		border-radius: 6px;
		padding: 7px 8px 7px 9px;
	}
	input[type=submit]{
		width: 100px;
	    height: 50px;
	    margin: 30px 30px 30px 10px;
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
</style>
<div align="center">
	<div style="padding: 40px">
		<form method="post" action="02_loginPro.jsp" accept-charset="utf-8">
			<div class="div_input">
				<div class="left">아이디 :</div>
				<div class="left"><input type="text" name="id"></div>
			</div>
			<div class="div_input">
				<div class="left">패스워드 :</div>
				<div class="left"><input type="password" name="pw"></div>
			</div>
			<div class="div_input">
				<input type="submit" value="로그인">
			</div>
		</form>
	</div>
</div>