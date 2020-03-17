<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/nav.jsp"%>

<h3>멜론 차트 100</h3>


<button type="button" class="btn btn-outline-secondary m-3" style="border-radius: 50px;">
	<i class="fas fa-play"></i> 듣기
</button>
<button type="button" onclick="openList()" class="btn btn-outline-secondary m-3" style="border-radius: 50px;">
	<i class="fas fa-plus"></i> 담기
</button>
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
				<td><input type="checkbox" name="musicCheckbox" value="${music.id}"></td>
				<td class="align-items-center"><div>${music.id}</div></td>

				<td><img style="width: 60px;" src="${music.photo}"></td>
				<td><a href="/music/${music.id}" style="color: black;"><i class="far fa-file-alt"></i></a></td>
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
									<span id="heart_${music.id}" onclick="set_heart(${music.id})" style="color: limegreen;"><i class="fa-heart fas"></i></span>
								</c:when>
								<c:otherwise>
									<span id="heart_${music.id}" onclick="set_heart(${music.id})" style="color: limegreen;"><i class="fa-heart far"></i></span>
								</c:otherwise>
							</c:choose>
						</c:otherwise>
					</c:choose> <span id="likesCount_${music.id}"> ${music.likesCount} </span></td>
				<c:choose>
					<c:when test="${empty principal}">
						<td><span onclick="go_login()" style="color: limegreen"><i class="fas fa-play"></i></span></td>
					</c:when>
					<c:otherwise>
						<td><span onclick="changeVideoAndStart('${music.videoLink}','${music.photo}','${music.title}','${music.singer}');" style="color: limegreen"><i class="fas fa-play"></i></span></td>
					</c:otherwise>
				</c:choose>

				<td><span onclick="musicList('${music.videoLink}','${music.title}','${music.singer}')"><i class="fas fa-plus"></i></span></td>
				<td><a href="/music/videoDetail/${music.id}" style="color: black;"><i class="fas fa-video"></i></a></td>
			</tr>
		</c:forEach>
	</tbody>
</table>

<div id="video_iframe" style="display: none;"></div>

<script>
	var popUp
	var checkedIds= new Array();

	function openList(){
		popUp=window.open('/playList','담기 클릭','width=400, height=500, toolbar=no, menubar=no, scrollbars=no, resizable=yes');
		}
	function getCheckboxVal(listName){
		$("input[name=musicCheckbox]:checked").each(function() {
			checkedIds.push($(this).val());
		 });	
			var data = { 
					listName: listName,
					checkedIds: checkedIds };
			$.ajax({
				type:'POST',
				url : '/playList/addList',
		        data: JSON.stringify(data),
		        contentType : 'application/json; charset=utf-8',
		        dataType : 'json'
			}).done(function(r) {
				if(r.msg=='ok'){
				alert('플레이리스트 추가 성공');
				$("input[name=musicCheckbox]:checked").each(function() {
				$(this).attr("checked", false);
				});
				}else{
					alert('플레이리스트 추가 실패');
					}

			}).fail(function(r) {
				alert('플레이리스트 추가 실패');
			});
	} 

	var tag = document.createElement('script');
	tag.src = "https://www.youtube.com/iframe_api";
	var firstScriptTag = document.getElementsByTagName('script')[0];
	firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
	
	var player;
	
	function addMusicForm(music_photo,music_title,music_singer){
		
		var items='<div style="width: 100%; height: 120px; background-color: black;">';
		items+='<div class="mx-3"><div style="color: white;">현재 재생중인 노래</div>';
		items+='<img style="width: 60px;" src="'+music_photo+'">';
		items+='<span style="color: white; font-size: 30px; margin-left: 20px;" onclick="playYoutube();"><i class="far fa-play-circle"></i></span>';
		items+='<span style="color: white; font-size: 30px"><i class="far fa-pause-circle" onclick="pauseYoutube();"></i></span>';
		items+='<span style="color: white; font-size: 30px"><i class="far fa-stop-circle" onclick="stopYoutube();"></i></span><br/>';
		items+='<font color="white"><MARQUEE id="mymarquee" bgColor="black">'+music_title+' - '+music_singer+'</MARQUEE></font>';
		items+='</div></div>';
		$('#music_control').html(items);
	};

	function onYouTubeIframeAPIReady () {
	  player = new YT.Player('video_iframe', {
	  });
	}
	function playYoutube () {
	  player.playVideo();
	  document.getElementById('mymarquee').start();

	}
	function pauseYoutube () {
	  player.pauseVideo();
	  document.getElementById('mymarquee').stop();
	}
	
	function changeVideoAndStart(videoLink,music_photo,music_title,music_singer) {
		  player.loadVideoById(videoLink, 0, "large");
		addMusicForm(music_photo,music_title,music_singer);
		}
    function stopYoutube() {
        player.seekTo(0, true);    
        player.stopVideo();
  	  document.getElementById('mymarquee').stop();
    }
    
 	var list = new Array();
 	
	function musicList(video_link,music_title,music_singer){
		list.push(video_link);
		$('#playList').append('<li class="list-group-item" style="font-size:12px">'+music_title+' - '+music_singer+'</li>');
	}
	
    function changeVideoListAndStart() {
        player.loadPlaylist(list, 0, 0, 'large');
    }
	function set_heart(music_id){
		var likesCount=$('#likesCount_'+music_id).html();
		if ($('#heart_'+music_id).html()=='<i class="fa-heart fas"></i>') {
			
			 $.ajax({
					type : 'delete',
					url : '/likes/delete/'+music_id,
					dataType : 'json'
				}).done(function(r) {
					if(r.msg=='ok'){
					 $('#heart_'+music_id+' i').removeClass("fas");
					 $('#heart_'+music_id+' i').addClass("far");
					$('#likesCount_'+music_id).text(parseInt(likesCount)-1);
					}else{
						alert('좋아요 해제 실패');
					}
				}).fail(function(r) {
					alert('좋아요 해제 실패');					
				}); 
		} else {
			 $.ajax({
					type : 'post',
					url : '/likes/save/'+music_id,
					dataType : 'json'
				}).done(function(r) {
					if(r.msg=='ok'){
					 $('#heart_'+music_id+' i').removeClass("far");
					 $('#heart_'+music_id+' i').addClass("fas");
					$('#likesCount_'+music_id).text(parseInt(likesCount)+1);
					}else{
						alert('좋아요 실패');
					}
				}).fail(function(r) {
					alert('좋아요 실패');
				}); 
		}
	};
	function go_login(){
	alert('로그인 후 이용가능합니다.');
	location.href='/user/login';
		}
</script>

<%@include file="../include/footer.jsp"%>