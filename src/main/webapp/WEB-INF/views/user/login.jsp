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

	<div class="container ">
		<div class="row text-center align-items-center" style="height: 50vh;">
			<div class="col">
				<div style="padding-bottom: 50px">
					<a href="/" title="Melon 메인"> <img src="https://cdnimg.melon.co.kr/resource/image/web/member/img_logo206x56.png" width="206" height="56" />
					</a>
				</div>
				<div>
					<form>
						<input id="username" type="text" placeholder="아이디 입력" style="width: 390px; height: 50px; padding: 0px 11px" /><br /> <input id="password" type="password" placeholder="비밀번호 입력"
							style="width: 390px; height: 50px; padding: 0px 11px" />

					</form>
					<div style="padding: 20px; margin-right: 10px">
						<input type="checkbox" id="inpSaveId" class="input_check"> <label for="inpSaveId" class="label_check">아이디 저장</label> <a href="/user/join" style="color: graytext; margin-left: 180px">회원가입</a>
					</div>

					<div>
						<button id="login--submit" class="btn" style="background-color: limegreen; width: 390px; height: 60px;">
							<span style="color: white; font-size: 18px">로그인</span>
						</button>
					</div>

				</div>
			</div>
		</div>
	</div>
	<script>
	$('#login--submit').on('click', function() {
		var data = {
			username : $('#username').val(),
			password : $('#password').val()
		};

		$.ajax({
			type : 'POST',
			url : '/user/login',
			data : data,
			contentType : 'application/x-www-form-urlencoded; charset=utf-8',
			dataType : 'json'
		}).done(function(r) {
			if (r.msg == 'ok') {
				alert('로그인 성공');
				location.href = "/";
			}else{
				alert('로그인 실패');
				}
		}).fail(function(r) {
			alert('로그인 실패');
		});
	});
	</script>