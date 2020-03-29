<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<sec:authorize access="isAuthenticated()">
	<sec:authentication property="principal" var="principal" />
</sec:authorize>

<!DOCTYPE html>
<html lang="en">
<head>
<style>
.ui-autocomplete {
	overflow-y: scroll;
	overflow-x: hidden;
}

.ui-menu-item {
	font-size: 12px;
}
</style>
<title>melon Chart</title>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<script src="http://code.jquery.com/jquery-1.7.js" type="text/javascript"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />
<script src="js/all.min.js"></script>
<script type="text/javascript">
	$(document).ready(function() {

		$("#search_form").autocomplete({
			source : function(request, response) {

				$.ajax({
					url : "/autocomplete",
					type : "post",
					dataType : "json",
					data : request,
					success : function(data) {
						response(data);
					},
					error : function(data) {
						alert("에러가 발생하였습니다.")
					}
				});
			}
		});
	});
	function searchTitle() {
		var search_title = $('#search_form').val();
		console.log(search_title);
		location.href = '/music/search/' + search_title;
	}
</script>
</head>
<body>

	<nav style="background-color: white; height: 1000px; width: 15%; z-index: 8; position: fixed; left: 85%; border-left-width: 1px; border-left-style: solid; border-left-color: silver;">
		<hr style="border-style: solid; border-width: 3px; border-color: limegreen; margin-top: 0; margin-bottom: 50px" />
		<c:choose>
			<c:when test="${empty principal}">
				<div style="margin-left: 50px;">
					<div>
						<a href="/user/join" style="margin-left: 50px; font-size: 12px; color: graytext;">회원가입</a> <br /> <a href="/user/login" class="btn "
							style="background-color: limegreen; color: white; width: 85%; padding: 8px 15px; font-size: 15px;">로그인</a>
					</div>
				</div>
			</c:when>
			<c:otherwise>
				<div style="margin-left: 50px;">
					<div>
						<img src="/media/${principal.profile}" class="rounded-circle my__img ml-auto" width="50px" onerror="javascript:this.src='/images/unknown.png'" /><br />
					</div>
					<a href="/user/profile" style="font-size: 12px; color: graytext;">회원정보 수정</a> <br /> <a href="/user/logout" class="btn"
						style="background-color: limegreen; color: white; width: 85%; padding: 8px 15px; font-size: 15px;">로그아웃</a>
						<br/><br/>
							<a href="/playList/myPlayList">나의 플레이리스트</a>
				</div>
			</c:otherwise>
		</c:choose>
		<br /> <br /> <br />

		<div id="music_control" style="width: 100%"></div>
		
	</nav>

	<hr style="border-style: solid; border-width: 3px; border-color: limegreen; margin-top: 0" />

	<div style="width: 85%">
		<div class="container">
			<div class="d-flex ">
				<a href="/"> <img width="142" height="100" src="https://cdnimg.melon.co.kr/resource/image/web/common/logo_melon142x99.png" />
				</a>
				<div class="input-group" style="border: 2px solid limegreen; width: 350px; height: 60px; margin-top: 30px; border-radius: 50px; padding: 10px">
					<input id="search_form" type="text" class="form-control" placeholder="Search" style="border: 0">
					<div class="input-group-append" style="padding: 0;">
						<span style="color: limegreen; font-size: 30px; margin-left: 20px;" onclick="searchTitle()"><i class="fas fa-search"></i></span>
					</div>
				</div>
			</div>
		
			<hr>


			<br> <br> <br>