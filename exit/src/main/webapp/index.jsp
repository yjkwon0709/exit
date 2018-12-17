<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<h1>Exit Index Page!</h1>
<h2>기능목록</h2>
<ul>
	<li><a href="<c:url value='/board/boardList.do' />" id="BoardBtn">게시판</a></li>
	<li><a href="<c:url value='/user/openSignUp.do' />" id="signUpBtn">회원가입</a></li>
	<c:choose>
		<c:when test="${loginInfo eq null }">
			<li><a href="<c:url value='/user/openLogin.do' />" id="loginBtn">로그인</a></li>
		</c:when>
		<c:otherwise>
			<li><a href="<c:url value='/user/logoutTry.do' />" id="logoutBtn">로그아웃</a></li>
		</c:otherwise>
	</c:choose>
</ul>
<script type="text/javascript">
	$(document).ready(function() {
		$("#BoardBtn").unbind("click").click(function(e){
			e.preventDefault();
			fn_moveToBoard();
		});
		
		$("#signUpBtn").unbind("click").click(function(e){
			e.preventDefault();
			fn_moveToSignUp();
		});
		
		$("#logoutBtn").unbind("click").click(function(e){
			e.preventDefault();
			fn_moveToLogout();
		});
		
		$("#loginBtn").unbind("click").click(function(e){
			e.preventDefault();
			fn_moveToLogin();
		});
	});
	function fn_moveToBoard(){
		window.location.href="<c:url value='/board/boardList.do' />";
	}
	function fn_moveToSignUp(){
		window.location.href="<c:url value='/user/openSignUp.do' />";
	}
	function fn_moveToLogout(){
		window.location.href="<c:url value='/user/logoutTry.do' />";
	}
	function fn_moveToLogin(){
		window.location.href="<c:url value='/user/openLogin.do' />";
	}
</script>
