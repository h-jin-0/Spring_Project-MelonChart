<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
</sec:authorize>

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

	<nav style="background-color: white; height: 1000px; width: 15%; z-index: 8; position: fixed; left: 85%; border-left-width: 1px; border-left-style: solid; border-left-color: silver;">
		<hr style="border-style: solid; border-width: 3px; border-color: limegreen; margin-top: 0; margin-bottom: 50px" />
		<c:choose>
			<c:when test="${empty principal}">
				<div >
					<a href="/user/join" style="margin-left: 50px; font-size: 12px; color: graytext;">회원가입</a> <br /> <a href="/user/login" class="btn mx-5"
						style="background-color: limegreen; color: white; width: 200px; padding: 8px 15px; font-size: 15px;">로그인</a>
				</div>
			</c:when>
			<c:otherwise>
				<div >
					<a href="/user/logout" class="btn mx-5" style="background-color: limegreen; color: white; width: 200px; padding: 8px 15px; font-size: 15px;">로그아웃</a>
				</div>
			</c:otherwise>
		</c:choose>
	</nav>


	<hr style="border-style: solid; border-width: 3px; border-color: limegreen; margin-top: 0" />

	<div style="width: 85%">
		<div class="container">
			<div class="d-flex ">
				<a href="/"> <img width="142" height="99" src="https://cdnimg.melon.co.kr/resource/image/web/common/logo_melon142x99.png" />
				</a>
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