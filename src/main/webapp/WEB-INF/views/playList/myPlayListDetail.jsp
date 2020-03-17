<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/nav.jsp"%>
<h3>플레이리스트 정보</h3>
<div style="border-style: solid; border-width: 1px; border-color: silver; height: 282px;" class="row">
	<div style="width: 282px;">
		<img style="width: 140px; margin: 0;" src="${myPlayLists[0].photo}"><img style="width: 140px; margin: 0;" src="${myPlayLists[1].photo}"><br /> <img style="width: 140px; margin: 0;"
			src="${myPlayLists[2].photo}"><img style="width: 140px; margin: 0;" src="${myPlayLists[3].photo}">
	</div>
	<div style="width: 853px; padding: 40px 0px 26px 30px">
		<div class="container">
			<div>
				<strong style="font-size: 22px; margin: 0px opx 8px;">${myPlayLists[0].listName}</strong>
			</div>
			
			<table>
				<tr>
					<td>제작자 : </td>
					<td> ${principal.username}</td>
				</tr>
			</table>
		</div>
	</div>
</div>
<br>
<h4>수록곡</h4>
<hr>
<table class="table table-hover mx-auto">
	<thead class="thead">
		<tr>
			<th>NO</th>
			<th></th>
			<th></th>
			<th>곡명</th>
			<th>아티스트</th>
			<th>앨범</th>
			<th>장르</th>
			<th></th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="myPlayList" items="${myPlayLists}" varStatus="status">
			<tr id="myPlayList--${myPlayList.id}">
				<td>${status.count}</td>
				<td><i class="far fa-play-circle"></i></td>
				<td><a href="/music/${myPlayList.musicId}" style="color: black;"><i class="far fa-file-alt"></i></a></td>
				<td>${myPlayList.title}</td>
				<td>${myPlayList.singer}</td>
				<td>${myPlayList.album}</td>
				<td>${myPlayList.genre}</td>
				<td><i onclick="myPlayListDelete('${myPlayList.id}')" class="far fa-trash-alt"></i></td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<br>
<br>
<hr />
<br>


<input id="joinId" type="hidden" value="${music.id}" />
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<script src="/js/musicDetail.js"></script>
<script>
function myPlayListDelete(id) {
	$.ajax({
		type : 'delete',
		url : '/playList/myPlayListDelete/' + id,
		dataType : 'json'
	}).done(function(r) {
		if (r.msg == 'ok') {
			alert('플레이리스트 삭제 성공');
			$('#myPlayList--' + id).remove();
		} else {
			alert('플레이리스트 삭제 실패');
		}
	}).fail(function(r) {
		alert('플레이리스트 삭제 실패');
	});

}
</script>
<%@include file="../include/footer.jsp"%>