<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dbsql.*"%>
<%@ page import="table.*"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet"
	href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-BmbxuPwQa2lc/FVzBcNJ7UAyJxM6wuqIj61tLrc4wSX0szH/Ev+nYRRuWlolflfl"
	crossorigin="anonymous">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-beta2/dist/js/bootstrap.bundle.min.js"
	integrity="sha384-b5kHyXgcpbZJO/tY9Ul7kGkf1S0CWuKcCD38l8YkeH8z8QjE0GmW1gYU5S9FOnJ0"
	crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style>
a.btn-link {
	text-decoration: none;
	color: black;
}
</style>
<title>일정 추가</title>
</head>
<body>
	<!-- 로고, 네비게이션 바 파일 불러오기 -->
	<%@include file="nav.jsp"%>
	
	<div class="container mt-2">
		<div class="card">
			<div class="card-header">일정 추가</div>
			<div class="row">
				<div class="col-lg-1">기간:</div>
				<div class="col-lg-2">
					<input type="text" id="startdate" name="startdate">
				</div>
				<div class="col-lg-1">~</div>
				<div class="col-lg-2">
					<input type="text" id="enddate" name="enddate">
				</div>
				<div class="col-lg-1">내용:</div>
				<div class="col-lg-5">
					<input type="text" id="title" name="title">
				</div>
				<div class="col-lg-1">이미지:</div>
				<div id="postImg" contenteditable="true"></div>
				<div class="col-lg-3">
					<button class="btn btn-success btnCalendarInsert">일정 추가</button>
				</div>
			</div>
		</div>
		<div class="col-lg-8">
			<a href="MemberManagement.jsp" class="btn btn-primary">회원 관리</a> <a
				href="PostManagement.jsp" class="btn btn-primary">글 관리</a> <a
				href="CalendarManagement.jsp" class="btn btn-primary">일정 관리</a>
		</div>
	</div>
	<script>
		$(document).ready(function() {
			$("#startdate").datepicker({
				dateFormat : "yy-mm-dd", // 선택된 날짜 형식
				minDate : 0, // 오늘 이전 날짜는 선택 불가능
			}).on("focus", function() {
				$(this).datepicker("show");
			});

			$("#enddate").datepicker({
				dateFormat : "yy-mm-dd", // 선택된 날짜 형식
				minDate : 0, // 오늘 이전 날짜는 선택 불가능
			}).on("focus", function() {
				$(this).datepicker("show");
			});
		});

		// 이미지 드래그 앤 드랍
		var editor = document.getElementById('postImg');

		editor.addEventListener('dragover', function(e) {
			e.stopPropagation();
			e.preventDefault();
			e.dataTransfer.dropEffect = 'copy';
		});

		editor.addEventListener('drop', function(e) {
			e.stopPropagation();
			e.preventDefault();

			var files = e.dataTransfer.files;
			var file = files[0];

			if (file.type.match('image.*')) {
				var reader = new FileReader();

				reader.onload = function(e) {
					var img = document.createElement('img');
					img.src = e.target.result;
					editor.appendChild(img);
				};

				reader.readAsDataURL(file);
			}
		});

		// 일정 추가 버튼에 대한 클릭 이벤트 처리
		$(".btnCalendarInsert").on("click", function() {
			var imgDiv = document.getElementById("postImg");
			var tilte = document.getElementById("title");
			var startdate = document.getElementById("startdate");
			var enddate = document.getElementById("enddate");
			var postImg = imgDiv.innerHTML;
			var postTitle = tilte.value;
			var calstartdate = startdate.value;
			var calenddate = enddate.value;
			// AJAX 요청을 보냅니다.
			$.ajax({
				url : "Calendar.jsp",
				method : "POST",
				data : {
					postImg : postImg,
					postTitle : postTitle,
					startdate : calstartdate,
					enddate : calenddate,
					btnCalendarInsert : "true"
				},
				success : function(response) {
					// 요청이 성공적으로 처리되었을 때 실행되는 코드
					console.log("요청이 성공적으로 처리되었습니다.");
					console.log("서버 응답: ", response); // Log server response to browser console
					
					window.location.href = "CalendarManagement.jsp";
				},
				error : function(xhr, status, error) {
					// 요청이 실패하거나 에러가 발생했을 때 실행되는 코드
					console.error("요청이 실패하였습니다.");
					console.error(xhr, status, error);
				}
			});
		});
	</script>
</body>
</html>