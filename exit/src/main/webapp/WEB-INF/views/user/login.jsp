<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/include-tag.jspf" %>
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
		var userInputId = fn_getCookie("userInputId");
	    $("input[name='ID']").val(userInputId); 
	     
	    if($("input[name='ID']").val() != ""){ // 그 전에 ID를 저장해서 처음 페이지 로딩 시, 입력 칸에 저장된 ID가 표시된 상태라면,
	        $("#id_save").attr("checked", true); // ID 저장하기를 체크 상태로 두기.
	    }
	     
	    $("#id_save").change(function(){ // 체크박스에 변화가 있다면,
	        if($("#id_save").is(":checked")){ // ID 저장하기 체크했을 때,
	            var userInputId = $("input[name='ID']").val();
	            fn_setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
	        }else{ // ID 저장하기 체크 해제 시,
	        	fn_deleteCookie("userInputId");
	        }
	    });
	     
	    // ID 저장하기를 체크한 상태에서 ID를 입력하는 경우, 이럴 때도 쿠키 저장.
	    $("input[name='ID']").keyup(function(){ // ID 입력 칸에 ID를 입력할 때,
	        if($("#id_save").is(":checked")){ // ID 저장하기를 체크한 상태라면,
	            var userInputId = $("input[name='ID']").val();
	            fn_setCookie("userInputId", userInputId, 7); // 7일 동안 쿠키 보관
	        }
	    });
		
		$("#login_btn").unbind("click").click(function(e){
			e.preventDefault();
			fn_login();
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
	    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
	    document.cookie = cookieName + "=" + cookieValue;
	}
	function fn_getCookie(cookieName) {
	    cookieName = cookieName + '=';
	    var cookieData = document.cookie;
	    var start = cookieData.indexOf(cookieName);
	    var cookieValue = '';
	    if(start != -1){
	        start += cookieName.length;
	        var end = cookieData.indexOf(';', start);
	        if(end == -1){
	        	end = cookieData.length;
	        }
	        cookieValue = cookieData.substring(start, end);
	    }
	    return unescape(cookieValue);
	}
	function fn_deleteCookie(cookieName){
	    var expireDate = new Date();
	    expireDate.setDate(expireDate.getDate() - 1);
	    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
	}
</script>
