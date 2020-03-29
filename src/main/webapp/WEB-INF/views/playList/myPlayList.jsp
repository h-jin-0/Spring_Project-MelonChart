<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/nav.jsp"%>

<h3>나의 플레이 리스트</h3>
<table class="table table-hover mx-auto" style="border-bottom: 1px; border-bottom-style: solid; border-bottom-color: silver;">
	<thead class="thead">
		<tr>
			<th>NO</th>
			<th>플레이리스트 명</th>
			<th>수록곡 수</th>
			<th>듣기</th>
			<th>삭제</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="playList" items="${playLists}" varStatus="status">
			<tr id="playList--${playList.listName}">
				<td>${status.count}</td>
				<td><a href="/playList/myPlayListDetail/${playList.listName}/1">${playList.listName}</a></td>
				<td>${playList.listCount}곡</td>
				<td><i onclick="playCheckbox(2,'${playList.listName}');" class="fas fa-play"></i></td>
				<td><i onclick="playListDelete('${playList.listName}')" class="fas fa-trash-alt"></i></td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<script>
	function playListDelete(listName) {
		$.ajax({
			type : 'delete',
			url : '/playList/delete/' + listName,
			dataType : 'json'
		}).done(function(r) {
			if (r.msg == 'ok') {
				alert('플레이리스트 삭제 성공');
				$('#playList--' + listName).remove();
			} else {
				alert('플레이리스트 삭제 실패');
			}
		}).fail(function(r) {
			alert('플레이리스트 삭제 실패');
		});

	}
</script>
<%@include file="../include/footer.jsp"%>