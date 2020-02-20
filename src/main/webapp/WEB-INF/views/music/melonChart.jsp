<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/nav.jsp"%>

<h3>멜론 차트 100</h3>
<table class="table">
	<thead>
		<tr>
			<th style="width: 15px; font-size: 13px"></th>
			<th style="width: 62px; font-size: 13px">순위</th>
			<th style="width: 60px; font-size: 13px"></th>
			<th style="width: 24px; font-size: 13px"></th>
			<th style="width: 190px; font-size: 13px">곡정보</th>
			<th style="width: 111px; font-size: 13px">앨범</th>
			<th style="width: 58px; font-size: 13px">좋아요</th>
			<th style="width: 52px; font-size: 13px">듣기</th>
			<th style="width: 52px; font-size: 13px">담기</th>
			<th style="width: 52px; font-size: 13px">뮤비</th>
		</tr>
	</thead>
	<tbody>
		<c:forEach var="music" items="${musics}">
			<tr>
				<td><input type="checkbox" id="defaultCheck" name="example2"></td>
				<td class="align-items-center"><div>${music.id}</div></td>

				<td><img style="width: 60px;" src="${music.photo}"></td>
				<td><a href="/music/${music.id}"><i class="far fa-file-alt"></i></a></td>
				<td>
					<div style="font-size: 14px">
						<a>${music.title}</a>
					</div>
					<div style="font-size: 12px">${music.singer}</div>
				</td>
				<td><a style="font-size: 12px">${music.album}</a></td>
				<td><span id="heart_${music.id}" onclick="set_heart(${music.id})" style="color: limegreen;"><i class="far fa-heart"></i></span> 123</td>
				<td><span style="color: limegreen"><i class="fas fa-play"></i></span></td>
				<td><i class="fas fa-plus"></i></td>
				<td><i class="fas fa-video"></i></td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<script>
	var heartStatus = false;
	function set_heart(music_id){
		if (heartStatus) {
			 $('#heart_'+music_id).html('<i class="far fa-heart"></i>');
			 $.ajax({
					type : 'delete',
					url : '/likes/delete/'+music_id,
					dataType : 'json'
				}).done(function(r) {
					
				}).fail(function(r) {
					
				}); 
			 heartStatus=true;
			 heartStatus=false;
		} else {
			$('#heart_'+music_id).html('<i class="fas fa-heart"></i>');
			
			 $.ajax({
					type : 'GET',
					url : '/likes/save/'+music_id,
					dataType : 'json'
				}).done(function(r) {
					
				}).fail(function(r) {
					
				}); 
			 heartStatus=true;
		}
	
	};
</script>

<%@include file="../include/footer.jsp"%>