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
				<td><c:choose>
						<c:when test="${empty principal}">
							<span onclick="go_login()" style="color: limegreen;"> <i class="far fa-heart"></i>
							</span>
						</c:when>
						<c:otherwise>
							<c:choose>
								<c:when test="${music.likesStatus}">
									<span id="heart_${music.id}" onclick="set_heart(${music.id})" style="color: limegreen;"><i class="fas fa-heart"></i></span>
								</c:when>
								<c:otherwise>
									<span id="heart_${music.id}" onclick="set_heart(${music.id})" style="color: limegreen;"><i class="far fa-heart"></i></span>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose> <span id="likesCount_${music.id}"> ${music.likesCount} </span></td>
				<td><span onclick="music_play('${music.videoLink}')" style="color: limegreen"><i class="fas fa-play"></i></span></td>
				<td><i class="fas fa-plus"></i></td>
				<td><i class="fas fa-video"></i></td>
			</tr>
		</c:forEach>
	</tbody>
</table>
<div id="test"></div>
<script>
function music_play(music_link){
	console.log(music_link);
	$('.my--iframe').remove();
	var iframe_item=`<iframe class='my--iframe'id="`
		+music_link
		+`"src='https://www.youtube.com/embed/`
		+music_link
		+`?autoplay=1&mute=0' allow='autoplay's></iframe>`;
	$('#test').append(iframe_item);
}
	var heartStatus = false;
	function set_heart(music_id){
		var likesCount=$('#likesCount_'+music_id).html();
		if ($('#heart_'+music_id).html()=='<i class="fas fa-heart"></i>') {
			 $.ajax({
					type : 'delete',
					url : '/likes/delete/'+music_id,
					dataType : 'json'
				}).done(function(r) {
					 $('#heart_'+music_id).html('<i class="far fa-heart"></i>');
					$('#likesCount_'+music_id).text(parseInt(likesCount)-1);
				}).fail(function(r) {
					
				}); 
			 heartStatus=false;
		} else {
			 $.ajax({
					type : 'GET',
					url : '/likes/save/'+music_id,
					dataType : 'json'
				}).done(function(r) {
					$('#heart_'+music_id).html('<i class="fas fa-heart"></i>');
					$('#likesCount_'+music_id).text(parseInt(likesCount)+1);
				}).fail(function(r) {
					
				}); 
			 heartStatus=true;
		}
	};
	function go_login(){
	alert('로그인 후 이용가능합니다.');
	location.href='/user/login';
		}
</script>

<%@include file="../include/footer.jsp"%>