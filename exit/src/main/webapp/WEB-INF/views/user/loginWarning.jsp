<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/include/include-head.jspf"%>
</head>
<body>
	<script type="text/javascript">
		window.alert("${msg}");
		window.location.href="/exit/user/openLogin.do";
	</script>
</body>
</html>