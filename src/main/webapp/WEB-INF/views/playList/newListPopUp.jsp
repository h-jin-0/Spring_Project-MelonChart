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

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.8.2/css/all.min.css" />
<script src="http://code.jquery.com/jquery-1.7.js" type="text/javascript"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/jquery-ui.min.js" type="text/javascript"></script>
<link href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.8/themes/base/jquery-ui.css" rel="stylesheet" type="text/css" />
<script src="js/all.min.js"></script>
</head>


<body>
	<div style="background-color: limegreen; font-weight: bold; font-size: 20px; color: white; margin-top: 0; margin-bottom: 25px; padding: 10px;">플레이리스트 만들기</div>
<input id="newListName" type="text" class="form-control form-control-sm mx-auto" style="width: 80%" maxlength="40" placeholder="제목을 입력해주세요."/>
<button onclick="saveNewPlayList()" class="btn btn-success mt-3" style="border-radius: 50px; margin-left: 130px">확인</button><button class="btn btn-outline-secondary mt-3"  onclick="window.close();" style="border-radius: 50px; margin-left: 15px">취소</button>

</body>

<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>

<script>
function saveNewPlayList() {
	var listName=$('#newListName').val();
	opener.parent.savePlayList(listName);
	window.close();
}
</script>
<%@include file="../include/footer.jsp"%>