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
	<hr style="border-style: solid; border-width: 3px; border-color: limegreen;" />

	<div class="container">
		<div class="d-flex ">
			<a href="/" title="MelOn 로고 - 홈으로 이동"> <img width="142" height="99" src="https://cdnimg.melon.co.kr/resource/image/web/common/logo_melon142x99.png" alt="MelOn 로고 이미지"></a>
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
		<h3>곡 정보</h3>
		<div style="border-style: solid; border-width: 1px; border-color: silver; height: 282px;" class="row">
			<div style="width: 282px;">
				<img style="width: 282px;" src="${music.photo}">
			</div>
			<div style="width: 853px; padding: 40px 0px 26px 30px">
				<div class="container">
					<div>
						<strong style="font-size: 22px; margin: 0px opx 8px;">${music.title}</strong>
					</div>
					<div style="font-size: 18px; color: limegreen">${music.singer}</div>

					<table>
						<tr>
							<td>앨범</td>
							<td>${music.album}</td>
						</tr>
						<tr>
							<td>발매일</td>
							<td>${music.albumDate}</td>
						</tr>
						<tr>
							<td>장르</td>
							<td>${music.genre}</td>
						</tr>
					</table>
					<span style="color: limegreen"><i class="far fa-heart"></i></span> ${music.heartCount}
				</div>
			</div>
		</div>
		<br>
		<h4>가사</h4>
		<hr>
		<div>
		${music.lyrics}
		</div>

	</div>
</body>
</html>