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
					<td>제작자 :</td>
					<td>${principal.username}</td>
				</tr>
			</table>
		</div>
	</div>
</div>
<br>
<h4>수록곡</h4>
<hr>
<button type="button" onclick="playCheckbox(2,'${myPlayLists[0].listName}');" class="btn btn-outline-secondary " style="border-radius: 50px;">
	<i class="fas fa-play"></i>플레이리스트 재생
</button>
<button type="button" onclick="playCheckbox(1,'');" class="btn btn-outline-secondary m-3" style="border-radius: 50px;">
	<i class="fas fa-play"></i>선택 곡 듣기
</button>
<button type="button" onclick="myPlayListDeleteAll()" class="btn btn-outline-secondary" style="border-radius: 50px;">
	<i class="far fa-trash-alt"></i>선택 곡 삭제
</button>
<table class="table table-hover mx-auto">
	<thead class="thead">
		<tr>
			<th><input type="checkbox" id="checkAll"></th>
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
				<td><input type="checkbox" name="musicCheckbox" value="${myPlayList.musicId}"></td>
				<td>${status.count}</td>
				<td><i class="far fa-play-circle" onclick="changeVideoAndStart('${myPlayList.videoLink}','${myPlayList.photo}','${myPlayList.title}','${myPlayList.singer}');"></i></td>
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
<ul class="pagination pagination-sm justify-content-center ">
	<c:if test="${pageMaker.prev}">
		<li class="page-item m-1"><a class="page-link" href="${pageMaker.startPage-1}">&lt</a></li>
	</c:if>
	<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="i">
		<li class="page-item m-1"><a class="page-link" href="/playList/myPlayListDetail/${myPlayLists[0].listName}/${i}">${i}</a></li>
	</c:forEach>
	<c:if test="${pageMaker.next}">
		<li class="page-item m-1"><a class="page-link" href="${pageMaker.endPage+1 }">&gt</a></li>
	</c:if>
</ul>

<br>
<br>
<hr />
<br>

<div id="video_iframe" style="display: none;"></div>
<input id="joinId" type="hidden" value="${music.id}" />
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<script src="/js/musicDetail.js"></script>
<script src="/js/musicChart.js"></script>
<script>
	function playAllCheckbox() {
		$("input[name=musicCheckbox]").prop("checked", true);
		playCheckbox();
	}
	var deleteList = new Array();

	function myPlayListDeleteAll() {
		$("input[name=musicCheckbox]:checked").each(function() {
			deleteList.push($(this).val());
		});
		var data = {
			deleteList : deleteList
		};
		$.ajax({
			type : 'delete',
			url : '/playList/myPlayListDeleteAll',
			data : JSON.stringify(data),
			contentType : 'application/json; charset=utf-8',
			dataType : 'json'
		}).done(function(r) {
			if (r.msg == 'ok') {
				for (let i = 0; i < deleteList.length; i++) {
					let id = deleteList[i];
					$('#myPlayList--' + id).remove();
				}
				alert('선택 곡 삭제 성공');
				$("input[name=musicCheckbox]").prop("checked", false);
				deleteList = [];
			} else {
				alert('선택 곡 삭제 실패');
			}

		}).fail(function(r) {
			alert('선택 곡 삭제 실패');
		});
	}
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