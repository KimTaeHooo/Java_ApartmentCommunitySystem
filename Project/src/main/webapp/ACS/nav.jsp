<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
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
<title>네비게이션 뷰</title>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="MainView.jsp"> <!-- 로고 이미지 --> <!-- 
        로고 출처 
        https://pixabay.com/ko/vectors/%EB%8F%84%EC%8B%9C-%EB%8F%84%EB%A1%9C-%EC%A7%80%EC%97%AD-%EC%82%AC%ED%9A%8C-%EA%B1%B4%EB%AC%BC-2042634/
        pixabay - Ricinator
        --> <img src="Logo.png" alt="로고"
				style="width: 20%; height: auto; margin: 0 auto; display: block;">
			</a>
		</div>
	</nav>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<!-- 홈, 공지, 잡담, 일정 버튼 -->
			<ul class="navbar-nav me-auto mb-2 mb-lg-0">
				<li class="nav-item"><a class="nav-link" href="MainView.jsp">
						<!-- 홈 버튼 이미지 --> <img src="Home.png" alt="로고" height="30">
				</a></li>
				<li class="nav-item"><a class="nav-link" href="#"
					onclick="setPostType('공지')">공지</a></li>
				<li class="nav-item"><a class="nav-link" href="#"
					onclick="setPostType('잡담')">잡담</a></li>
				<li class="nav-item"><a class="nav-link" href="#"
					onclick="setPostType('일정')">일정</a></li>
			</ul>
			<!-- 내 정보, 로그아웃 버튼 -->
			<ul class="navbar-nav">
				<!-- 내 정보 버튼 -->
				<li class="nav-item"><a id="btnMyInfo" class="nav-link"
					href="Myinfo.jsp">내 정보</a></li>
				<!-- 관리자 버튼 - id가 어드민일 경우만 활성화 -->
				<%
				String Adminverification = (String) session.getAttribute("ID");
				if ("admin".equals(Adminverification)) {
				%>
				<li class="nav-item"><a id="btnAdmin" class="nav-link"
					href="AdminView.jsp">관리자</a></li>
				<%
				}
				%>
				<!-- 로그아웃 버튼 -->
				<li class="nav-item"><a id="btnLogout" class="nav-link" href="/Project/logout">로그아웃</a></li>
			</ul>
		</div>
	</nav>
	<script>
		var postType = ''; // 기본값은 빈 문자열
		var pageNumber = 1;

		function setPostType(value) {
			postType = value;
			console.log("setPostType", postType);
			searchPosts(pageNumber);
		}

		function searchPosts(pageNumber) {
			var postValue = $("#postValueSelect").val();
			var searchText = $("#searchText").val();
			console.log("postValue", postValue);

			// 해당 페이지 번호를 클릭하면 active 클래스 설정
			$(".page-item").removeClass("active");
			$("#page_" + pageNumber).parent().addClass("active");

			// AJAX를 이용하여 서버에 검색 요청
			$.ajax({
				url : "Post.jsp",
				type : "POST",
				data : {
					postType : postType,
					postValue : postValue,
					searchText : searchText,
					currentPage : pageNumber,
					btnPostSearch : "true"
				},
				success : function(response) {
					// 성공시, 받은 응답으로 글 목록 업데이트
					window.location.href = "MainView.jsp?postType=" + postType;
					$("#searchResultsContainer").html(response);
					$("#infoContainer").hide();
				},
				error : function(xhr, status, error) {
					// 필요한 경우 에러 처리
					console.error("검색 결과를 가져오는데 실패했습니다.");
					console.error(error);
				}
			});
		}
	</script>
</body>
</html>
