<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
	<hr style="border-style: solid; border-width: 3px; border-color: limegreen;" />

	<div class="container">
		<div class="d-flex ">
			<a href="/" title="MelOn 로고 - 홈으로 이동"> <img width="142" height="99" src="https://cdnimg.melon.co.kr/resource/image/web/common/logo_melon142x99.png" alt="MelOn 로고 이미지"></a>
			<form class="form-inline">
				<input class="form-control mr-sm-2" type="text" placeholder="Search">
				<button class="btn" style="background-color: limegreen" type="submit">Search</button>
			</form>
			<div class="ml-auto">
			<a href="/user/login" class="btn" style="background-color: limegreen;">로그인</a>
			</div>
		</div>


		<hr>

		<ul class="nav nav-tabs nav-justified">
			<li class="nav-item"><a class="nav-link active" href="#">실시간</a></li>
			<li class="nav-item"><a class="nav-link" href="#">급상승</a></li>
			<li class="nav-item"><a class="nav-link" href="#">일간</a></li>
			<li class="nav-item"><a class="nav-link disabled" href="#">주간</a></li>
		</ul>
		<br> <br> <br>