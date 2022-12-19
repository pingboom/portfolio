<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.leftmenu{
		position: relative;
		float: left;
		padding: 10px 0 0 20px;
	}
	.rightmenu{
		position: relative;
		float: right;
		padding: 10px 20px 0 0;
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
</style>

<div style="width: 100%; height: 70px;">
	<div class="leftmenu">
		<button onclick="window.location.href='../index.jsp'">초기화면</button>
	</div>
	<div class="rightmenu">
		<button onclick="window.location.href='01_main.jsp'">홈페이지</button>
	</div>
</div>
