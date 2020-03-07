/**

 * 
 */
function go_login(){
	alert('로그인 후 이용가능합니다.');
	location.href='/user/login';
		}
$('#mucic--comment--submit').on('click', function() {
	var data = {
		joinId : $('#joinId').val(),
		content : $('#content').val(),
		type : 'music'
	};
	console.log(data)
	$.ajax({
		type : 'POST',
		url : '/comment/musicSave',
		data : JSON.stringify(data),
		contentType : 'application/json; charset=utf-8',
		dataType : 'json'
	}).done(function(r) {
		if (r.status.statusCode == 200) {
			alert('댓글 등록 성공');
			makeCommentItem(r);
		} else {
			alert('댓글 등록 실패');
		}
	}).fail(function(r) {
		console.log(r)
		alert('댓글 등록 실패');
	});
});
$('#video--comment--submit').on('click', function() {
	var data = {
		joinId : $('#joinId').val(),
		content : $('#content').val(),
		type : 'video'
	};
	console.log(data)
	$.ajax({
		type : 'POST',
		url : '/comment/musicSave',
		data : JSON.stringify(data),
		contentType : 'application/json; charset=utf-8',
		dataType : 'json'
	}).done(function(r) {
		if (r.status.statusCode == 200) {
			alert('댓글 등록 성공');
			makeCommentItem(r);
		} else {
			alert('댓글 등록 실패');
		}
	}).fail(function(r) {
		console.log(r)
		alert('댓글 등록 실패');
	});
});
function makeCommentItem(r) {
	
	var comment_item = `<div class="media text-muted pt-3" id="comment--item--${r.id}">`;
	comment_item += `<img src="/media/${r.profile}" class="rounded-circle my__img ml-auto" width="50px" onerror="javascript:this.src='../images/unknown.png'" />`;
	comment_item += `<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">`;
	comment_item += `<span class="d-block"> <strong class="text-gray-dark" style="padding-left: 30px">`;
	comment_item += `${r.username}`;
	comment_item += `</strong> <span style="padding-left: 7px; font-size: 9pt"> <a href="javascript:void(0)" onclick="commentDelete(${r.id})">삭제</a></span>`;
	comment_item += `</span> <span style="padding-left: 30px">`;
	comment_item += `${r.content}`;
	comment_item += `</span><span class="d-block" style="padding-left: 30px">`;
	comment_item += moment(`${r.writeDate}`).format('YYYY-MM-DD HH:mm');
	comment_item +=`</span></p><a class="btn" style="border-color: silver; color: red; padding: 0;">`;
	comment_item +=`<span id="thumbs_up_${r.id}" onclick="set_thumbsUp(${r.id},'recommend')" class="thumbsUp_${r.id}">`;
	comment_item +=`<i id="thumbsUp_no_${r.id}" class="fa-thumbs-up far"></i></span></a>`;
	comment_item +=`<div id="recommend_${r.id}">${r.recommend}</div><a class="btn" onclick="set_thumbsDown(${r.id},'opposite')" style="border-color: silver; color: blue; padding: 0;">`;
	comment_item +=`<span id="thumbs_down_${r.id}" class="thumbsDown_${r.id}"><i id="thumbsDown_no_${r.id}" class="fa-thumbs-down far"></i></span>`;
	comment_item +=`</a><div id="opposite_${r.id}">${r.opposite}</div></div>`;
	
	$('#replyList').prepend(comment_item);
};
function commentDelete(commentId) {
	$.ajax({
		type : 'DELETE',
		url : '/comment/delete/' + commentId,

	}).done(function(r) {
		if (r.msg == 'ok') {
			alert('댓글 삭제 성공');
			$('#comment--item--' + commentId).remove();
		} else {
			alert('댓글 삭제 실패');
		}
	}).fail(function(r) {
		alert('댓글 삭제 실패');
	});
};