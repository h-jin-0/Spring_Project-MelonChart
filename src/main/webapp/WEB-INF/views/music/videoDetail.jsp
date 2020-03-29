<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/nav.jsp"%>
<h3>뮤직 비디오</h3>
<div style="border-style: solid; border-width: 1px; border-color: silver; height: 600px;" >
<p align="center">
	<iframe id="gangnamStyleIframe" width="100%" height="600px;" src="https://www.youtube.com/embed/${music.videoLink }" frameborder="0" allow="autoplay; fullscreen" allowfullscreen></iframe>
</p>

</div>
<h4>${music.title}</h4>
<p style="font-size: 14px; color: graytext;">${music.album}</p>
<p>${music.singer}</p>

<br>
<hr />
<br>
<p>댓글</p>
<div class="my-3 p-3 bg-light rounded shadow-sm" style="padding-top: 10px;">
	<form name="form" id="form" role="form" method="post">
		<div class="row">
			<div class="col-sm-1">
				<img src="/media/${principal.profile}" class="rounded-circle my__img ml-auto" width="70px" onerror="javascript:this.src='/images/unknown.png'" />
			</div>
			<c:choose>
				<c:when test="${empty principal}">
					<div class="col-sm-10" onclick="go_login()">
						<textarea class="form-control" rows="3" placeholder="댓글을 입력해 주세요"></textarea>
					</div>
					<div class="col-sm-1" onclick="go_login()">
						<button type="button" style="width: 100%; height: 80%; margin-top: 10px">등 록</button>
					</div>
				</c:when>
				<c:otherwise>
					<div class="col-sm-10">
						<textarea id="content" class="form-control" rows="3" placeholder="댓글을 입력해 주세요"></textarea>
					</div>
					<div class="col-sm-1">
						<button type="button" id="video--comment--submit" style="width: 100%; height: 80%; margin-top: 10px">등 록</button>
					</div>
				</c:otherwise>
			</c:choose>
		</div>
	</form>
</div>


<div class="my-3 p-3 bg-white rounded shadow-sm" style="padding-top: 10px">
	<h6 class="border-bottom pb-2 mb-0"></h6>
	<div id="replyList">
		<c:forEach var="comment" items="${comments}">
			<div class="media text-muted pt-3" id="comment--item--${comment.id}">
				<img src="/media/${comment.profile}" class="rounded-circle my__img ml-auto" width="50px" onerror="javascript:this.src='/images/unknown.png'" />
				<p class="media-body pb-3 mb-0 small lh-125 border-bottom horder-gray">
					<span class="d-block"> <strong class="text-gray-dark" style="padding-left: 30px">${comment.username}</strong> <c:if test="${principal.username eq comment.username}">
							<span style="padding-left: 7px; font-size: 9pt"> <a href="javascript:void(0)" onclick="commentDelete(${comment.id})">삭제</a>
							</span>
						</c:if>
					</span> <span style="padding-left: 30px">${comment.content}</span> <span class="d-block" style="padding-left: 30px"><fmt:formatDate value="${comment.writeDate}" pattern="yyyy-MM-dd hh:mm" /></span>
				</p>
				<c:choose>
				<c:when test="${empty principal}">
					<a class="btn" style="border-color: silver; color: red; padding: 0;"> 
				<span onclick="go_login()">
					<i  class="fa-thumbs-up far"></i>
				</span>
				</a>
				<div >${comment.recommend}</div>
				<a class="btn"  style="border-color: silver; color: blue; padding: 0;"> 
				<span class="thumbsDown_${comment.id}" onclick="go_login()"><i class="fa-thumbs-down far"></i></span>
				</a>
				<div >${comment.opposite}</div>
				
				</c:when>
				<c:otherwise>
					<a class="btn" style="border-color: silver; color: red; padding: 0;"> 
				<span id="thumbs_up_${comment.id}" onclick="set_thumbsUp(${comment.id},'recommend')" class="thumbsUp_${comment.id}">
					<i id="thumbsUp_no_${comment.id}" class="fa-thumbs-up far"></i>
				</span>
				</a>
				<div id="recommend_${comment.id}">${comment.recommend}</div>
				<a class="btn" style="border-color: silver; color: blue; padding: 0;"> 
				<span id="thumbs_down_${comment.id}" class="thumbsDown_${comment.id}" onclick="set_thumbsDown(${comment.id},'opposite')" ><i id="thumbsDown_no_${comment.id}" class="fa-thumbs-down far"></i></span>
				</a>
				<div id="opposite_${comment.id}">${comment.opposite}</div>
				
				</c:otherwise>
				</c:choose>
			
				
			</div>
		</c:forEach>
	</div>
</div>
<input id="joinId" type="hidden" value="${music.id}" />
<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
<script src="/js/musicDetail.js"></script>
<script>

	function set_thumbsUp(comment_id,type){
		if ($('.thumbsUp_'+comment_id+' i').attr('id')==('thumbsUp_no_'+comment_id)){
			 $.ajax({
					type : 'post',
					url : '/comment/plus/'+type+'/'+comment_id, 
					dataType : 'json'
				}).done(function(r) {
					if(r.msg=='ok'){
					$('#thumbsUp_no_'+comment_id).parent().html('<i id="thumbsUp_yes_'+comment_id+'" class="fa-thumbs-up fas"></i>');
					$('#'+type+'_'+comment_id).text(parseInt($('#'+type+'_'+comment_id).html())+1);
					}else{
						}
				}).fail(function(r) {
					
				}); 
		}else if($('.thumbsUp_'+comment_id+' i').attr('id')=='thumbsUp_yes_'+comment_id){
			 $.ajax({
					type : 'post',
					url : '/comment/minus/'+type+'/'+comment_id,
					dataType : 'json'
				}).done(function(r) {
					if(r.msg=='ok'){
					$('#thumbsUp_yes_'+comment_id).parent().html('<i id="thumbsUp_no_'+comment_id+'" class="fa-thumbs-up far"></i>');
					$('#'+type+'_'+comment_id).text(parseInt($('#'+type+'_'+comment_id).html())-1);
					}else{
					}
				}).fail(function(r) {
					
				}); 
		}
	};
	function set_thumbsDown(comment_id,type){
		if ($('.thumbsDown_'+comment_id+' i').attr('id')==('thumbsDown_no_'+comment_id)){
			 $.ajax({
					type : 'post',
					url : '/comment/plus/'+type+'/'+comment_id, 
					dataType : 'json'
				}).done(function(r) {
					if(r.msg=='ok'){
					$('#thumbsDown_no_'+comment_id).parent().html('<i id="thumbsDown_yes_'+comment_id+'" class="fa-thumbs-down fas"></i>');
					$('#'+type+'_'+comment_id).text(parseInt($('#'+type+'_'+comment_id).html())+1);
					}else{
					}
				}).fail(function(r) {
					
				}); 
		}else if($('.thumbsDown_'+comment_id+' i').attr('id')=='thumbsDown_yes_'+comment_id){
			 $.ajax({
					type : 'post',
					url : '/comment/minus/'+type+'/'+comment_id,
					dataType : 'json'
				}).done(function(r) {
					if(r.msg=='ok'){
					$('#thumbsDown_yes_'+comment_id).parent().html('<i id="thumbsDown_no_'+comment_id+'" class="fa-thumbs-down far"></i>');
					$('#'+type+'_'+comment_id).text(parseInt($('#'+type+'_'+comment_id).html())-1);
					}else{
					}
				}).fail(function(r) {
					
				}); 
		}
	};
	function go_login(){
		alert('로그인 후 이용가능합니다.');
		location.href='/user/login';
			}


</script>
<%@include file="../include/footer.jsp"%>