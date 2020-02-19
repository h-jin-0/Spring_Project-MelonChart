<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="../include/nav.jsp"%>
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
					<span style="color: limegreen"><i class="far fa-heart"></i></span> 123
				</div>
			</div>
		</div>
		<br>
		<h4>가사</h4>
		<hr>
		<div>
		${music.lyrics}
		</div>
<%@include file="../include/footer.jsp"%>