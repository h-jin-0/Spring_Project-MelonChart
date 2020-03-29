/**
 * 
 * 
 */
var popUp
var checkedIds = new Array();
var count = 0;
var music_id;
var list = new Array();
var listInfo = new Array();
var videoLink = new Array();
var num = 0;
var tag = document.createElement('script');
tag.src = "https://www.youtube.com/iframe_api";
var firstScriptTag = document.getElementsByTagName('script')[0];
firstScriptTag.parentNode.insertBefore(tag, firstScriptTag);
var player;

function openList(num, id) {
	count = num;
	music_id = id
	popUp = window
			.open('/playList', '플레이리스트',
					'width=400, height=500, toolbar=no, menubar=no, scrollbars=no, resizable=yes');
}
$("#checkAll").click(function() {
	if ($("#checkAll").prop("checked")) {
		$("input[name=musicCheckbox]").prop("checked", true);

	} else {
		$("input[name=musicCheckbox]").prop("checked", false);
	}
})

function addMusicForm(music_photo, music_title, music_singer) {

	var items = '<div style=" height: 120px; background-color: black;">';
	items += '<div ><div style="color: white;">현재 재생중인 노래</div>';
	items += '<img style="width: 60px;" src="' + music_photo + '">';
	items += '<span style="color: white; font-size: 20px; margin:5px;"><i class="fas fa-backward" onclick="beforeYoutube();"></i></span>';
	items += '<span style="color: white; font-size: 30px;" onclick="playYoutube();"><i class="far fa-play-circle"></i></span>';
	items += '<span style="color: white; font-size: 30px"><i class="far fa-pause-circle" onclick="pauseYoutube();"></i></span>';
	items += '<span style="color: white; font-size: 30px"><i class="far fa-stop-circle" onclick="stopYoutube();"></i></span>';
	items += '<span style="color: white; font-size: 20px; margin:5px;"><i class="fas fa-forward" onclick="nextYoutube();"></i></span><br/>';
	items += '<font color="white"><MARQUEE id="mymarquee" bgColor="black">'
			+ music_title + ' - ' + music_singer + '</MARQUEE></font>';
	items += '</div></div>';
	$('#music_control').html(items);
};

function onYouTubeIframeAPIReady() {
	player = new YT.Player('video_iframe', {});
}
function playYoutube() {
	player.playVideo();
	document.getElementById('mymarquee').start();
}
function pauseYoutube() {
	player.pauseVideo();
	document.getElementById('mymarquee').stop();
}

function changeVideoAndStart(videoLink, music_photo, music_title, music_singer) {
	player.loadVideoById(videoLink, 0, "large");
	addMusicForm(music_photo, music_title, music_singer);
}
function stopYoutube() {
	player.seekTo(0, true);
	player.stopVideo();
	document.getElementById('mymarquee').stop();
}
function playCheckbox(playStatus, listName) {
	if (playStatus == 2) {
		// 리스트네임으로 아작스해서 뮤직아이디 가져오기
		$.ajax({
			type : 'GET',
			url : '/playList/listenListAll/' + listName,
			contentType : 'application/json; charset=utf-8',
		}).done(function(r) {
			if (r[0].status.msg == 'ok') {
				for (let i = 0; i < r.length; i++) {
					list.push(r[i].musicId);
				}
			} else {
				alert('리스트 로딩 실패')
			}

		}).fail(function(r) {
			alert('리스트 로딩 실패')
		});

	} else {
		$("input[name=musicCheckbox]:checked").each(function() {
			list.push($(this).val());
		});
	}
	
	console.log(list)
	var data = {
		list : list
	};
	$.ajax({
		type : 'POST',
		url : '/playList/listenList',
		data : JSON.stringify(data),
		contentType : 'application/json; charset=utf-8',
		dataType : 'json'
	}).done(
			function(r) {
				if (r[0].status.msg == 'ok') {
					console.log(r.length)
					for (let i = 0; i < r.length; i++) {
						listInfo.push(r[i])
						videoLink.push(r[i].videoLink)
					}
					console.log(videoLink)
					player.loadPlaylist(videoLink, 0, 0, 'large')
					addMusicForm(listInfo[num].photo, listInfo[num].title,
							listInfo[num].singer);
				} else {
					alert('재생 실패')
				}

			}).fail(function(r) {
		alert('재생 실패')
	});
}

function nextYoutube() {
	player.nextVideo();
	num += 1;
	addMusicForm(listInfo[num].photo, listInfo[num].title, listInfo[num].singer);
}
function beforeYoutube() {
	player.previousVideo()
	num -= 1;
	addMusicForm(listInfo[num].photo, listInfo[num].title, listInfo[num].singer);
}

function getCheckboxVal(listName) {
	if (count == 2) {
		$("input[name=musicCheckbox]:checked").each(function() {
			checkedIds.push($(this).val());
		});
	} else if (count == 1) {
		checkedIds.push(music_id);
	} else {
		for (let i = 1; i <= 100; i++) {
			checkedIds.push(i);
		}
	}
	var data = {
		listName : listName,
		checkedIds : checkedIds
	};
	$.ajax({
		type : 'POST',
		url : '/playList/addList',
		data : JSON.stringify(data),
		contentType : 'application/json; charset=utf-8',
		dataType : 'json'
	}).done(function(r) {
		if (r.msg == 'ok') {
			alert('플레이리스트 추가 성공');
			$("input[name=musicCheckbox]:checked").each(function() {
				$(this).attr("checked", false);
				checkedIds = [];
			});
		} else {
			alert('플레이리스트 추가 실패');
		}

	}).fail(function(r) {
		alert('플레이리스트 추가 실패');
	});
}
function set_heart(music_id) {
	var likesCount = $('#likesCount_' + music_id).html();
	if ($('#heart_' + music_id).html() == '<i class="fa-heart fas"></i>') {

		$.ajax({
			type : 'delete',
			url : '/likes/delete/' + music_id,
			dataType : 'json'
		}).done(function(r) {
			if (r.msg == 'ok') {
				$('#heart_' + music_id + ' i').removeClass("fas");
				$('#heart_' + music_id + ' i').addClass("far");
				$('#likesCount_' + music_id).text(parseInt(likesCount) - 1);
			} else {
				alert('좋아요 해제 실패');
			}
		}).fail(function(r) {
			alert('좋아요 해제 실패');
		});
	} else {
		$.ajax({
			type : 'post',
			url : '/likes/save/' + music_id,
			dataType : 'json'
		}).done(function(r) {
			if (r.msg == 'ok') {
				$('#heart_' + music_id + ' i').removeClass("far");
				$('#heart_' + music_id + ' i').addClass("fas");
				$('#likesCount_' + music_id).text(parseInt(likesCount) + 1);
			} else {
				alert('좋아요 실패');
			}
		}).fail(function(r) {
			alert('좋아요 실패');
		});
	}
};
function go_login() {
	alert('로그인 후 이용가능합니다.');
	location.href = '/user/login';
}