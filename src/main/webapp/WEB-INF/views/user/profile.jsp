<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
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
	<hr style="border-style: solid; border-width: 3px; border-color: limegreen;" />

	<div class="container ">
		<div class="row text-center align-items-center" style="height: 50vh;">
			<div class="col">
				<div style="padding-bottom: 10px; padding-top: 50px">
					<a href="/" title="Melon 메인"> <img src="https://cdnimg.melon.co.kr/resource/image/web/member/img_logo206x56.png" width="206" height="56" />
					</a>
				</div>
				<div style="border-style: solid; border-width: 1px; border-color: silver;" class="p-5 m-5">
					<form:form action="/user/profile" method="post" enctype="multipart/form-data">
						<div class="form-group">
						<input type="hidden" name="id" value="${principal.id}"/>
							<label class="float-left">아이디:</label> <input type="text" class="form-control" readonly="readonly" value="${principal.username}" />
						</div>
						<div class="form-group">
							<label class="float-left">비밀번호:</label> 
							<input name="password" type="password" class="form-control" onkeyup="keyUp('password')" placeholder="Enter Password" id="password" required="required" maxlength="20" />
							<div class="d-flex justify-content-between">
								<span id="password--vali" style="font-size: 12px; color: red;">비밀번호 입력은 필수입니다.</span><span id="password--count">0/20</span>
							</div>

						</div>
						<div class="form-group">
							<label class="float-left">비밀번호 확인:</label> <input type="password" class="form-control" onkeyup="keyUp('password-check')" placeholder="Enter Password" id="password-check" required="required"
								maxlength="20" />
							<div class="d-flex justify-content-between">
								<span id="password-check--vali" style="font-size: 12px; color: red;">비밀번호가 일치하지 않습니다.</span><span id="password-check--count">0/20</span>
							</div>

						</div>
						<div class="form-group">
							<label class="float-left">이름:</label> <input type="text" class="form-control" readonly="readonly" value="${principal.name}"/>

						</div>
						<div class="form-group">
							<label class="float-left">이메일:</label> <input type="email" class="form-control" readonly="readonly" value="${principal.email}" />
						</div>
						<div class="form-group">
							<label class="float-left">프로필 사진:</label> <input type="file" class="form-control" name="profile" />
							<p class="my__profile"></p>
						</div>
						<div>
							<button id="update--submit" class="btn" style="background-color: limegreen; width: 390px; height: 60px;">
								<span style="color: white; font-size: 18px">회원정보 수정 완료</span>
							</button>
						</div>
					</form:form>
				</div>
			</div>
		</div>
	</div>
	<script>
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
			var check_password = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{8,20}$/;

			if (field == "password") {
				if (check_password.test(field_data) == false) {
					$('#' + span_vali).html('8~20자리의 영문,숫자,특수문자의 조합으로 입력헤주세요.');
				} else {
					$('#' + span_vali).html('');
				}
			}
			if (field == "password-check") {

				if (field_data != $('#password').val()) {
					$('#' + span_vali).html('비밀번호가 일치하지 않습니다.');
				} else {
					$('#' + span_vali).html('');
				}
			}
	
		};
	</script>