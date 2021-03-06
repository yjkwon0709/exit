<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui" %> 
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<form name="selectOne">
	<div class="rela">
		<h1>
			<a href="#">소위행매</a>
		</h1>
		<div class="etc">
			<ul>
				<li><a href="#" id="hd_homeBtn">HOME </a></li>
				<c:choose>
					<c:when test="${loginInfo eq null }">
						<li><a href="#" id="hd_signUpBtn">회원가입</a></li>
						<li><a href="#" id="hd_loginBtn">로그인</a></li>
					</c:when>
					<c:otherwise>
						<li>${loginInfo.name }닙 반갑습니다.</li>
						<li><a href="#" id="hd_boardBtn">게시판</a></li>
						<li><a href="#" id="hd_logoutBtn">로그아웃 </a></li>
					</c:otherwise>
				</c:choose>
				<li><a href="#">사이트맵</a></li>
			</ul>
		</div>
		<ul class="gnb">
			<li><a href="#">ABOUT커뮤니티매핑</a></li>
			<li><a href="#">내커퓨니티맵</a></li>
			<li><a href="#">커뮤니티맵</a></li>
			<li><a href="#">활동소식</a></li>
			<li><a href="#">알림마당</a></li>
			<li><a href="#">자유게시판</a></li>
		</ul>
		
		
	</div>
</form>
<script type="text/javascript">
	$(document).ready(function() {
		$("#hd_homeBtn").unbind("click").click(function(e){
			e.preventDefault();
			fn_hdGoHome();
		});
		
		$("#hd_signUpBtn").unbind("click").click(function(e){
			e.preventDefault();
			fn_hdGoSignUp();
		});
		
		$("#hd_loginBtn").unbind("click").click(function(e){
			e.preventDefault();
			fn_hdGoLogin();
		});
		
		$("#hd_boardBtn").unbind("click").click(function(e){
			e.preventDefault();
			fn_hdGoBoard();
		});
		
		$("#hd_logoutBtn").unbind("click").click(function(e){
			e.preventDefault();
			fn_hdGoLogout();
		});
	});
	
	function fn_hdGoHome(){
		window.location.href="<c:url value='/' />";
	}
	function fn_hdGoSignUp(){
		window.location.href="<c:url value='/user/openSignUp.do' />";
	}
	function fn_hdGoLogin(){
		window.location.href="<c:url value='/user/openLogin.do' />";
	}
	function fn_hdGoBoard(){
		window.location.href="<c:url value='/board/boardList.do' />";
	}
	function fn_hdGoLogout(){
		window.location.href="<c:url value='/user/logoutTry.do' />";
	}
	

</script>