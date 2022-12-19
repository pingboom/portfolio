<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<jsp:include page="00_home.jsp"></jsp:include>
<style>
	.div_input{
		padding: 10px 0 10px 0;
		font-size: 20px;
		width: 350px;
		height: 30px;
		text-align: center;
	}
	.left{
		float: left;
		width: 50%;
	}
	.input_time{
		width: 50px;
		border: solid 1px #03c75a;
		border-radius: 6px;
		padding: 7px;
	}
	input[type=text], input[type=password]{
		border: solid 1px #03c75a;
		border-radius: 6px;
		padding: 7px;
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

<!-- �� ���ý� ��ȭ �̸� �ڵ� �ҷ����� -->
<!-- ��, ���۽ð� span -->

<div align="center">
	<div style="padding: 40px">
		<form method="post" action="99_addmoviePro.jsp" accept-charset="utf-8">
			<div class="div_input">
				<div class="left">�� :</div>
				<div class="left">
					<span>
						<select id="hall" name="hall">
					        <option value="1">1</option>
					        <option value="2">2</option>
					        <option value="3">3</option>
					        <option value="4">4</option>
					        <option value="5">5</option>
					        <option value="6">6</option>
					        <option value="7">7</option>
					        <option value="8">8</option>
					        <option value="9">9</option>                                    
					    </select>
					��</span>
				</div>
			</div>
			<div class="div_input">
				<div class="left">��ȭ ���� :</div>
				<div class="left"><input type="text" name="title"></div>
			</div>
			<div class="div_input">
				<div class="left">���� �ð� :</div>
				<div class="left"><input class="input_time" type="text" name="hour">��
				<input class="input_time" type="text" name="minute">��
				</div>
			</div>
			<div class="div_input">
				<div class="left">�� �ð� :</div>
				<div class="left"><input class="input_time" type="text" name="r_time">��</div>
			</div>
			<div class="div_input">
				<input type="submit" value="�߰�">
			</div>
		</form>
	</div>
</div>