<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/nav.jsp"%>

<h3>멜론 차트 100</h3>
<button type="button" onclick="openList(3,'')" class="btn btn-outline-secondary m-3" style="border-radius: 50px;">
	<i class="fas fa-play"></i> Top100 담기
</button>
<button type="button" onclick="playCheckbox(1,'');" class="btn btn-outline-secondary m-3" style="border-radius: 50px;">
	<i class="fas fa-play"></i> 듣기
</button>
<button type="button" onclick="openList(2,'')" class="btn btn-outline-secondary m-3" style="border-radius: 50px;">
	<i class="fas fa-plus"></i> 담기
</button>
<table class="table">
	<thead>
		<tr>
			<th style="width: 15px; font-size: 13px"><input type="checkbox" id="checkAll"></th>
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

				<td><span onclick="openList(1,'${music.id}')"><i class="fas fa-plus"></i></span></td>
				<td><a href="/music/videoDetail/${music.id}" style="color: black;"><i class="fas fa-video"></i></a></td>
			</tr>

		</c:forEach>
	</tbody>
</table>
<br />
<div style="margin-left: 500px; color: silver;">
	<h4>
		<strong><a  id="text--1"  href="/music/paging/1" style="color: graytext;"">1-50위</a></strong> |<strong> <a id="text--2"  style="color: graytext;"
			href="/music/paging/2">51-100위</a></strong>
	</h4>
</div>
<div id="video_iframe" style="display: none;"></div>

<script>

</script>
<script src="/js/musicChart.js"></script>
<%@include file="../include/footer.jsp"%>