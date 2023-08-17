<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

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
<%@ page import="Login.CheckDuplicateServlet"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원 가입 폼 만들기</title>
<style>
body {
	padding-top: 20px;
	background-color: #f9f9f9;
}

h2 {
	text-align: center;
}

label {
	width: 100px;
}

input[type="text"], input[type="password"] {
	width: 240px;
}

button {
	cursor: pointer;
}
</style>
</head>
<body>
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<div class="container-fluid">
			<a class="navbar-brand" href="Login.jsp"> <!-- 로고 이미지 --> <!-- 
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
			<ul class="navbar-nav">
				<!-- 로그아웃 버튼 -->
				<li class="nav-item"><a id="btnLogout" class="nav-link"
					href="Login.jsp">로그인</a></li>
			</ul>
		</div>
	</nav>

	<div class="container" id="registrationForm">
		<h2>회원가입</h2>
		<hr>
		<p>아래 내용을 기재하여 가입하세요.</p>
		<hr>
		<div class="mb-3">
			<label for="ID" class="form-label">아이디</label>
			<div class="input-group">
				<input type="text" id="ID" name="ID" class="form-control"
					aria-describedby="btnCheckDuplicate">
				<button class="btn btn-outline-primary" type="button"
					id="btnCheckDuplicate" onclick="checkDuplicate()">중복확인</button>
			</div>
			<div id="duplicateMessage"></div>
		</div>
		<div class="mb-3">
			<label for="PW" class="form-label">비밀번호</label>
			<div class="input-group">
				<input type="password" id="PW" name="PW" class="form-control"
					aria-describedby="btnShowPassword">
				<button class="btn btn-outline-primary" type="button"
					id="btnShowPassword" onclick="togglePasswordVisibility()">내용표시</button>
			</div>
		</div>
		<div class="mb-3">
			<label for="name" class="form-label">이름</label> <input type="text"
				id="name" name="name" class="form-control">
		</div>
		<div class="mb-3">
			<label for="address" class="form-label">거주지</label> <input
				type="text" id="address" name="address" class="form-control">
		</div>
		<div class="d-grid gap-2">
			<button class="btn btn-primary btnRequest">가입승인요청</button>
			<button class="btn btn-secondary btnCancel">취소</button>
		</div>
	</div>

	<script>
		// 가입승인요청 버튼에 대한 클릭 이벤트 처리
		$(".btnRequest").on("click", function() {
			var id = document.getElementById("ID");
			var name = document.getElementById("name");
			var password = document.getElementById("PW");
			var accessiondate = new Date().toISOString().split('T')[0]; // 현재 날짜
			var residence = document.getElementById("address");

			// AJAX 요청을 보냅니다.
			$.ajax({
				url : "Tenant.jsp",
				method : "POST",
				data : {
					id : id.value, // Get the value from the input field
					name : name.value,
					password : password.value,
					accessiondate : accessiondate,
					residence : residence.value,
					btnRequest : "true"
				},
				success : function(response) {
					// 요청이 성공적으로 처리되었을 때 실행되는 코드
					console.log("요청이 성공적으로 처리되었습니다.");
					console.log("서버 응답: ", response); // Log server response to browser console

					location.reload(); // 성공 후 페이지 새로 고침
				},
				error : function(xhr, status, error) {
					// 요청이 실패하거나 에러가 발생했을 때 실행되는 코드
					console.error("요청이 실패하였습니다.");
					console.error(xhr, status, error);
				}
			});
		});

		// 가입승인요청 버튼에 대한 클릭 이벤트 처리
		$(".btnCancel").on("click", function() {
			location.reload(); // 페이지 새로 고침
		});

		//중복확인 함수
		function checkDuplicate() {
			const idInput = document.getElementById("ID").value;
			const xhr = new XMLHttpRequest();
			xhr.open("POST", "/Project/checkDuplicate"); // 서블릿 매핑과 일치하는 URL 사용
			xhr.setRequestHeader("Content-Type", "application/json");
			xhr.send(JSON.stringify({
				id : idInput
			}));

			xhr.onreadystatechange = function() {
				if (xhr.readyState === XMLHttpRequest.DONE) {
					if (xhr.status === 200) {
						const response = JSON.parse(xhr.responseText);
						if (response.exists) {
							// 중복된 아이디가 발견되었습니다.
							document.getElementById("duplicateMessage").innerHTML = "중복인 아이디입니다.";
							document.getElementById("ID").value = "";
						} else {
							// 아이디를 사용할 수 있습니다.
							document.getElementById("duplicateMessage").innerHTML = "사용 가능한 아이디입니다.";
						}
					} else {
						// 서버 오류 처리
						console.error("중복 확인 중 오류 발생: " + xhr.status);
					}
				}
			};

		}

		// 비밀번호 표시 여부를 토글하는 함수
		function togglePasswordVisibility() {
			var passwordInput = document.getElementById("PW");
			var showPasswordButton = document.getElementById("btnShowPassword");

			if (passwordInput.type === "password") {
				// 비밀번호 필드가 가려진 상태일 때 버튼을 클릭하면 텍스트로 변경
				passwordInput.type = "text";
				showPasswordButton.textContent = "내용숨기기";
			} else {
				// 비밀번호 필드가 텍스트 상태일 때 버튼을 클릭하면 다시 가려짐
				passwordInput.type = "password";
				showPasswordButton.textContent = "내용표시";
			}
		}
	</script>
</body>
</html>