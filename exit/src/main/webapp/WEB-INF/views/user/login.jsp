<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<form id="frm">
	<table class="board_list">
		<colgroup>
		</colgroup>
		<caption>로그인</caption>
		<thead>
		</thead>
		<tbody>
			<tr>
				<th scope="row">아이디</th>
				<td><input type="text" id="user_id" name="ID" class="wdp_90"></td>
			</tr>
			<tr>
				<th scope="row">비밀번호</th>
				<td><input type="password" id="user_password" name="PASSWORD" class="wdp_90"></td>
			</tr>
			<tr>
				<th scope="row">아이디 저장</th>
				<td><input type="checkbox" id="id_save"></td>
			</tr>
		</tbody>
	</table>
	<div class="btn_area">
		<a id="login_btn" class="btn">로그인</a>
	</div>
</form>
<form id="commonForm" name="commonForm"></form>
<script type="text/javascript">
	$(document).ready(function(){
		$("#login_btn").unbind("click").click(function(e){
			e.preventDefault();
			fn_login();
		});
		$("#id_save").change(function{
			
		});
	});
	
	function fn_login(){
		if($("#user_id").val().length < 1){
			alert("아이디를 입력해주세요.");
		} else if($("#user_password").val().length < 1){
			alert("비밀번호를 입력해주세요.");
		} else{
			var comSubmit = new ComSubmit("frm");
			comSubmit.setUrl("<c:url value='/user/loginTry.do' />");
			comSubmit.submit();
		}
	}
	
	function fn_setCookie(cookieName, value, exdays){
		var exdate = new Date();
		exdate.setDate(exdate.getDate() + exdays);
		var cookieValue = escape(value) + 
	}

	function fn_getCookie(){
		
	}
	
	function fn_deleteCookie(){
		
	}
	
</script>
