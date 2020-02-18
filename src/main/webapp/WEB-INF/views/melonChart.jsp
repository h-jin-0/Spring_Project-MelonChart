<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
<head>
<!-- 흠 테스트중 -->
<title>melon Chart</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<script src="js/all.min.js"></script>
</head>
<body>

	<hr />

	<div class="container">
		<div class="d-flex ">
			<a href="#" title="MelOn 로고 - 홈으로 이동"> <img width="142" height="99" src="https://cdnimg.melon.co.kr/resource/image/web/common/logo_melon142x99.png" alt="MelOn 로고 이미지"></a>
			<form class="form-inline">
				<input class="form-control mr-sm-2" type="text" placeholder="Search">
				<button class="btn" style="background-color: limegreen" type="submit">Search</button>
			</form>
		</div>


		<hr>

		<ul class="nav nav-tabs nav-justified">
			<li class="nav-item"><a class="nav-link active" href="#">실시간</a></li>
			<li class="nav-item"><a class="nav-link" href="#">급상승</a></li>
			<li class="nav-item"><a class="nav-link" href="#">일간</a></li>
			<li class="nav-item"><a class="nav-link disabled" href="#">주간</a></li>
		</ul>
		<br> <br> <br>
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
						<td><i class="far fa-file-alt"></i></td>
						<td>
							<div style="font-size: 14px">
								<a>${music.title}</a>
							</div>
							<div style="font-size: 12px">${music.singer}</div>
						</td>
						<td><a style="font-size: 12px">${music.album}</a></td>
						<td><span><i class="far fa-heart"></i></span> ${music.heart}</td>
						<td><span style="color: limegreen"><i class="fas fa-play"></i></span></td>
						<td><i class="fas fa-plus"></i></td>
						<td><i class="fas fa-video"></i></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
</body>
</html>