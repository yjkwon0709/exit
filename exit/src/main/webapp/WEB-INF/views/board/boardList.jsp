<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<%@ include file="/WEB-INF/include/include-head.jspf" %>
</head>
<body>
	<%@ include file="/WEB-INF/include/include-header.jspf" %>
	<h2>게시판 목록</h2>
	<table class="board_list">
		<colgroup>
			<col width="10%" />
			<col width="*" />
			<col width="15%" />
			<col width="20%" />
		</colgroup>
		<thead>
			<tr>
				<th scope="col">글번호</th>
				<th scope="col">제목</th>
				<th scope="col">조회수</th>
				<th scope="col">작성일</th>
			</tr>
		</thead>
		
		<tbody>
		
		</tbody>
	</table>
	
	<div id="PAGE_NAVI"></div>	
	<input type="hidden" id="PAGE_INDEX" name="PAGE_INDEX"/>
	
	<br/>
	<a href="#this" class="btn" id="write">글쓰기</a>
	
	<%@ include file="/WEB-INF/include/include-body.jspf" %>
	<script type="text/javascript" >
		$(document).ready(function(){
			fn_selectBoardList(1);
			
			$("#write").on("click", function(e){
				e.preventDefault();
				fn_boardWrite();
			});
			
			$("a[name='TITLE']").on("click", function(e){
				e.preventDefault();
				fn_boardDetail($(this));
			});
		});
			
		function fn_boardWrite(){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/board/boardWrite.do' />");
			comSubmit.submit();
		}
		
		function fn_boardDetail(obj){
			var comSubmit = new ComSubmit();
			comSubmit.setUrl("<c:url value='/board/boardDetail.do' />");
			comSubmit.addParam("IDX", obj.parent().find("#IDX").val());
			comSubmit.submit();
		}
		
		function fn_selectBoardList(pageNo){
			var comAjax = new ComAjax();
			comAjax.setUrl("<c:url value='/board/setBoardList.do' />");
			comAjax.setCallback("fn_selectBoardListCallback");
			comAjax.addParam("PAGE_INDEX", $("#PAGE_INDEX").val());
			comAjax.addParam("PAGE_ROW", 15);
			comAjax.addParam("IDX_FE", $("#IDX_FE").val());
			comAjax.ajax();
		}
		
		function fn_selectBoardListCallback(data){
			var total = data.total;
			var body = $("table>tbody");
			body.empty();
			if(total == 0){
				var str = "<tr>" + "<td colspan='4'>조회된 결과가 없습니다. </td>" +
						"</tr>";
				body.append(str);
			} else {
				var params = {
					divId : "PAGE_NAVI",
					pageIndex : "PAGE_INDEX",
					totalCount : total,
					eventName : "fn_selectBoardList"
				};
				gfn_renderPaging(params);
				
				var str = "";
				$.each(data.list, function(key, value){
					str += "<tr>" +
						"<td>" +value.idx + "</td>" +
						"<td class='title'>" +
							"<a href='#this' name='title'>" + value.title + "</a>" +
							"<input type='hidden' name='title' id='IDX' value=" + value.idx + ">" +
						"</td>" +
						"<td>" + value.hit_cnt + "</td>" +
						"<td>" + value.crea_dtm + "</td>" +
					"</tr>";
				});
				body.append(str);
				
				$("a[name='title']").on("click", function(e){
					e.preventDefault();
					fn_boardDetail($(this));
				});
			}
		}
	</script>
</body>
</html>