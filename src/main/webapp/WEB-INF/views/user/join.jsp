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
				<div style="padding-bottom: 10px; padding-top: 50px">
					<a href="/" title="Melon 메인"> <img src="https://cdnimg.melon.co.kr/resource/image/web/member/img_logo206x56.png" width="206" height="56" />
					</a>
				</div>
				<div style="border-style: solid; border-width: 1px; border-color: silver;" class="p-5 m-5">
					<form>
						<div class="form-group">
							<label class="float-left">아이디:</label> <input type="text" class="form-control" onkeyup="keyUp('username')" id="username" placeholder="Enter ID" required="required" maxlength="15" />
							<div class="d-flex justify-content-between">
								<span id="username--vali" style="font-size: 12px; color: red;">아이디 입력은 필수입니다.</span><span id="username--count"> 0/15</span>
							</div>

						</div>
						<div class="form-group">
							<label class="float-left">비밀번호:</label> <input type="password" class="form-control" onkeyup="keyUp('password')" placeholder="Enter Password" id="password" required="required" maxlength="20" />
							<div class="d-flex justify-content-between">
								<span id="password--vali" style="font-size: 12px; color: red;">비밀번호 입력은 필수입니다.</span><span id="password--count">0/20</span>
							</div>

						</div>
						<div class="form-group">
							<label class="float-left">이름:</label> <input type="text" class="form-control" onkeyup="keyUp('name')" placeholder="Enter Name" id="name" required="required" maxlength="10" />
							<div class="d-flex justify-content-between">
								<span id="name--vali" style="font-size: 12px; color: red;">이름 입력은 필수입니다.</span><span id="name--count">0/10</span>
							</div>

						</div>
						<div class="form-group">
							<label class="float-left">이메일:</label> <input type="email" class="form-control" onkeyup="keyUp('email')" placeholder="Enter Email" id="email" required="required" maxlength="20" />
							<div class="d-flex justify-content-between">
								<span id="email--vali" style="font-size: 12px; color: red;">이메일 입력은 필수 입니다.</span><span id="email--count">0/20</span>
							</div>

						</div>
					</form>

					<div>
						<button id="join--submit" class="btn" style="background-color: limegreen; width: 390px; height: 60px;">
							<span style="color: white; font-size: 18px">회원가입</span>
						</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		$('#join--submit').on('click', function() {

			var data = {
				username : $('#username').val(),
				password : $('#password').val(),
				name : $('#name').val(),
				email : $('#email').val()
			};

			$.ajax({
				type : 'POST',
				url : '/user/join',
				data : JSON.stringify(data),
				contentType : 'application/json; charset=utf-8',
				dataType : 'json'
			}).done(function(r) {
				if (r.statusCode == 200) {
					alert('회원가입 성공');
					location.href = '/user/login';
				} else {
					if (r.msg == '아이디중복') {
						alert('아이디가 중복되었습니다.');
					}
					alert('회원가입 실패');
				}
			}).fail(function(r) {
				alert('회원가입 실패');
			});
		});

		function keyUp(field) {
			var field_data = $('#' + field).val();

			keyUp_count(field, field_data);
			validation_check(field, field_data);
		};

		function keyUp_count(field, field_data) {
			var strLength = $('#' + field).val().length;
			var maxLength = $('#' + field).attr('maxlength');
			var span_count = field + "--count";

			$('#' + span_count).html(strLength + '/' + maxLength);
		};

		function validation_check(field, field_data) {
			var span_vali = field + "--vali";
			var check_username = /^[A-Za-z0-9+]{5,15}$/;
			var check_password = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$/;
			var check_name = /^[ㄱ-ㅎ|가-힣|a-z|A-Z|0-9|\*]{2,10}$/
			var check_email = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;

			if (field == "username") {
				if (check_username.test(field_data) == false) {
					$('#' + span_vali).html('5~15자리 영문 또는 숫자로 입력해주세요');
				} else {
					
					 $.ajax({
						type : 'GET',
						url : '/user/doubleCheck/'+field_data,
						dataType : 'json'
					}).done(function(r) {
						if (r.statusCode == -2) {
							$('#' + span_vali).html('해당 아이디는 중복된 아이디입니다.');
						} else {
							$('#' + span_vali).html('');
						}
					}).fail(function(r) {
						
					}); 
				}
			} 
			if (field == "password") {
				if (check_password.test(field_data) == false) {
					$('#' + span_vali).html('8~20자리의 영문,숫자,특수문자의 조합으로 입력헤주세요.');
				} else {
					$('#' + span_vali).html('');
				}
			}
			if (field == "name") {
				if (check_name.test(field_data) == false) {
					$('#' + span_vali).html('2~10자리 영문 또는 한글로 입력해주세요.');
				} else {
					$('#' + span_vali).html('');
				}
			}
			if (field == "email") {
				if (check_email.test(field_data) == false) {
					$('#' + span_vali).html('이메일 형식에 맞게 입력헤주세요.');
				} else {
					$('#' + span_vali).html('');
				}
			}
		};
	</script>