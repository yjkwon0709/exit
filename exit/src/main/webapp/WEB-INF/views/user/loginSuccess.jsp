<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/include/include-tag.jspf" %>
<script type="text/javascript">
	window.alert("${msg}"+ "${session}");
	window.location.href="/exit/board/boardList.do";
</script>
