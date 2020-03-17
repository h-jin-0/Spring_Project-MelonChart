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
	<div style="background-color: limegreen; font-weight: bold; font-size: 22px; color: white; margin-top: 0; margin-bottom: 50px; padding: 10px;">플레이리스트에 담기</div>
	<table class="table mx-auto table-hover" style="width: 90%; font-size: 13px; border-bottom: 1px; border-bottom-style: solid">
		<thead class="thead-light">
			<tr>
				<th>플레이리스트 명</th>
				<th></th>
				<th>수록곡 수</th>
			</tr>
		</thead>
		<tbody>
			<c:forEach var="playList" items="${playLists}">
				<tr onclick="savePlayList('${playList.listName}')">
					<td>${playList.listName}</td>
					<td></td>
					<td>${playList.listCount}</td>
				</tr>
			</c:forEach>
		</tbody>
	</table>
	<div>
		<ul class="pagination pagination-sm justify-content-center ">
			<li class="page-item m-1"><a class="page-link" href="#">&lt</a></li>
			<li class="page-item m-1"><a class="page-link" href="#">1</a></li>
			<li class="page-item active m-1"><a class="page-link" href="#">2</a></li>
			<li class="page-item m-1"><a class="page-link" href="#">3</a></li>
			<li class="page-item m-1"><a class="page-link" href="#">&gt</a></li>
		</ul>
		<button onclick="newPlayList()" class="btn btn-success btn-sm" style="border-radius: 50px; margin-left: 130px; font-size: 13px;">플레이리스트 만들기</button>
	</div> 
</body>


<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>

<script>
	function newPlayList() {
		window.open('/newPlayList', '플레이리스트 추가','width=400, height=200, toolbar=no, menubar=no, scrollbars=no, resizable=yes');
		
	}
	function savePlayList(listName) {
		opener.parent.getCheckboxVal(listName);
		window.close();
	}

</script>
<%@include file="../include/footer.jsp"%>