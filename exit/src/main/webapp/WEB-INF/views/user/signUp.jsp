<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/include-tag.jspf" %>
<form id="frm">
	<table class="board_list" style="text-align: center; margin: 0; padding: 0" >
		<caption>회원가입</caption>
		<thead>
			<tr>
				<td colspan="3" class="signUp_agree">약관동의</td>
			</tr>
			<tr>
				<td colsapn="3" class="signUp_agree_textarea">
					<textarea rows="10" cols="50" readonly="readonly">제 1조 (목적) 본 약관은 남양주시청에서 제공하는 인터넷 관련 서비스 (이하 서비스, 접속 가능한 유/무선 단말기의 종류와는 상관없이 이용 가능한 남양주시청이 제공하는 모든 서비스를 의미)를 이용함에 있어 남양주시청과 회원간의 권리, 의무 및 책임사항, 하나의 ID 및 PASSWORD로 통합하여 이용하는데 따른 서비스 이용 조건 및 절차 등을 규정함을 목적으로 합니다.</textarea>
				</td>
			</tr>
			<tr>
				<td colspan="3" class="signUp_agree_checkbox">
					<input type="checkbox" id="agree_checkbox">약관에 동의
				</td>
			</tr>
		</thead>
		<tbody>
			<tr>
				<th scope="row">아이디</th>
				<td><input type="text" id="user_id" name="ID" class="wdp_90" /></td>
				<td><a href="#" id="user_id_checkBtn" class="btn">중복확인</a></td>
			</tr>
			<tr>
				<th scope="row">비밀번호</th>
				<td><input type="text" id="user_password" name="PASSWORD" class="wdp_90" /></td>
				<td></td>
			</tr>
			<tr>
				<th scope="row">이름</th>
				<td><input type="text" id="user_name" name="NAME" class="wdp_90" /></td>
				<td></td>
			</tr>
			<tr>
				<th scope="row">전화번호</th>
				<td><input type="text" id="user_tel" name="TEL" class="wdp_90" /></td>
				<td></td>
			</tr>
		</tbody>
		<tfoot>
			<tr>
				<td colspan="3">
					<a href="#" class="btn" id="signUpBtn">회원가입</a>
					<a href="#" class="btn" id="homeBtn">취소</a>
				</td>
			</tr>
		</tfoot>
	</table>
</form>
<form id="commonForm" name="commonForm"></form>
<script type="text/javascript">
	$(document).ready(function() {
		$("#user_id_checkBtn").unbind("click").click(function(e) {
			e.preventDefault();
			fn_userIDCheck();
		});
		
		$("#signUpBtn").unbind("click").click(function(e){
			e.preventDefault();
			fn_signUp();
		});
		
		$("#homeBtn").unbind("click").click(function(e){
			e.preventDefault();
			fn_moveToHome();
		});
	});

	function fn_userIDCheck(){
		/* var comSubmit = new ComSubmit();
		comSubmit.setUrl("<c:url value='/board/boardWrite.do' />");
		comSubmit.submit(); */
		var userId= $("#user_id").val();
		var userData = {"ID": userId}
		
		if(userId.length < 1){
			alert("아이디를 입력해 주세요.");
		} else{
			$.ajax({
				type : "POST",
				url : "<c:url value='/user/checkUserID.do' />",
				data : userData,
				dataType : "json",
				error : function(error) {
					alert("서버가 응답하지 않습니다. \n다시 시도해주시기 바랍니다.");
				},
				success : function(result){
					if(result == 0){
						$("#user_id").attr("disabled", true);
						alert("사용이 가능한 아이디입니다.");
					} else if(result == 1){
						alert("이미 존재하는 아이디입니다. \n 다른아이디를 사용해주세요.");
					} else {
						alert("에러가 발생하였습니다.");
					}
					
				}
			});
		}
	}

	function fn_signUp(){
		if($("#agree_checkbox").prop("checked") == false){
			alert("약관에 동의해주세요.");
		} else if($("#user_id").val().length < 1){
			alert("사용하실 아이디를 작성하세요.");
		} else if($("#user_password").val().length < 1){
			alert("사용하실 비밀번호를 작성하세요.");
		} else if($("#user_name").val().length < 1){
			alert("이름을 작성하세요.");
		} else if($("#user_tel").val().length < 1){
			alert("전화번호를 작성하세요.");
		} else if(!$("#user_id").attr("disabled")){
			alert("아이디 중복체크를 해주세요.");
		} else{
			if(window.confirm("회원가입을 하시겠습니까?")){
				var comSubmit = new ComSubmit("frm");
				comSubmit.setUrl("<c:url value='/user/signUp.do' />");
				comSubmit.addParam("ID", $("#user_id").val());
				comSubmit.submit();
			}
		}
	}

	function fn_moveToHome(){
		if(window.confirm("메인 화면으로 돌아가시곗습니까?")){
			window.location.href="/exit/";	
		}
	}	
</script>
