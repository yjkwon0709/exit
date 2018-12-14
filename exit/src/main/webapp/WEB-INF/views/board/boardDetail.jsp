<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/include/include-head.jspf" %>
</head>
<body>
	<%@ include file="/WEB-INF/include/include-header.jspf" %>
	<table class="board_view">
		<colgroup>
			<col width="15%" />
			<col width="35%" />
			<col width="15%" />
			<col width="35%" />
		</colgroup>
		<caption>게시글 상세</caption>
		<thead>
			<tr>
				<th scope="row">글번호</th>
				<td>${selectedOne.idx }</td>
				<th scope="row">조회수</th>
				<td>${selectedOne.hit_cnt }</td>
			</tr>
			<tr>
				<th scope="row">작성자</th>
				<td> ${selectedOne.crea_id }</td>
				<th scope="row">작성시간</th>
				<td>${selectedOne.crea_dtm }</td>
			</tr>
			<tr>
				<th scope="row">제목</th>
				<td colspan="3">${selectedOne.title }</td>
			</tr>
			<tr>
				<td colspan="4">${selectedOne.contents }</td>
			</tr>
			<tr>
				<th scope="row">첨부파일</th>
				<td colspan="3">
					<c:forEach var="row" items="${list }">
						<p>
							<input type="hidden" id="IDX" value="${row.idx }" >
							<a href="#this" name="FILE">${row.original_file_name }</a>
							(${row.file_size }kb)
						</p>
					</c:forEach>
				</td>
			</tr>
		</thead>
	</table>
	<br/>
	<a href="#this" class="btn" id="list">목록으로</a>
	<a href="#this" class="btn" id="update">수정하기</a>
	
	<%@ include file="/WEB-INF/include/include-body.jspf" %>
	<script type="text/javascript">
	
		$(document).ready(function() {
			$("#list").on("click", function(e){
				e.preventDefault();
				fn_boardList();
			});
			
			$("#update").on("click", function(e){
				e.preventDefault();
				fn_boardUpdate();
			});
			$("a[name='FILE']").on("click", function(e) {
				e.preventDefault();
				fn_downloadFile($(this));
			});
		});
		
		function fn_boardList(){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/board/boardList.do'/>");
			comSubmit.submit();
		}
		function fn_boardUpdate(){
			/* 수정이 매우 필요해 보이는 코드. */
			var idx = "${selectedOne.idx}";
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/board/boardUpdate.do'/>");
			comSubmit.addParam("IDX", idx);
			comSubmit.submit();
		}
		function fn_downloadFile(obj){
			var idx = obj.parent().find("#IDX").val();
			var comSubmit = new ComSubmit();
			
			comSubmit.setUrl("<c:url value='/common/downloadFile.do'/>");
			comSubmit.addParam("IDX", idx);
			comSubmit.submit();
		}
	</script>
</body>
</html>