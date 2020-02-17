<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>

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
				<button class="btn" style="background-color :limegreen" type="submit">Search</button>
			</form>
		</div>
		<br>

		<hr>
		<h2>멜론 차트 100</h2>
		<ul class="nav nav-tabs nav-justified">
			<li class="nav-item"><a class="nav-link active" href="#">Active</a></li>
			<li class="nav-item"><a class="nav-link" href="#">Link</a></li>
			<li class="nav-item"><a class="nav-link" href="#">Link</a></li>
			<li class="nav-item"><a class="nav-link disabled" href="#">Disabled</a></li>
		</ul>
		<table class="table">
			<thead>
				<tr>
					<th>순위</th>
					<th></th>
					<th>(사진자리)</th>
					<th></th>
					<th>곡정보</th>
					<th>앨범</th>
					<th>좋아요</th>
					<th>듣기</th>
					<th>담기</th>
					<th>뮤비</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td>1</td>
					<td><i class="fas fa-minus"></i></td>
					<td>사진</td>
					<td><i class="far fa-file-alt"></i></td>
					<td><div>아무노래</div>
						<br>
					<div>지코</div></td>
					<td>아무노래앨범</td>
					<td><span><i class="far fa-heart"></i></span>234 <i class="fas fa-heart"></i></td>
					<td><span style="color:limegreen"><i class="fas fa-play"></i></span></td>
					<td><i class="fas fa-plus"></i></td>
					<td><i class="fas fa-video"></i></td>
				</tr>

			</tbody>
		</table>
	</div>
</body>
</html>