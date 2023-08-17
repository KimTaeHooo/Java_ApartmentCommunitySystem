<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dbsql.*"%>
<%@ page import="table.*"%>
<%@ page import="java.util.List"%>
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
<style>
a.btn-link {
	text-decoration: none;
	color: black;
}
</style>
<title>관리자 화면</title>
</head>
<body>
	<!-- 로고, 네비게이션 바 파일 불러오기 -->
	<%@include file="nav.jsp"%>

	<!-- 수락 대기중 라벨과 데이터베이스에서 받아온 정보를 표시하는 div -->
	<div class="container mt-2">
		<div class="card">
			<div class="card-header">수락 대기중</div>
			<div class="card-body">
				<div class="row">
					<%
					Select select = new Select("TenantWait");
					Tenant t = new Tenant();

					// 데이터베이스에서 회원 정보 가져오기
					List<Tenant> TenantMembers = select.DBSelect(t); // 적절한 메서드를 호출하여 회원 정보를 가져오도록 수정해야 합니다.

					// 가져온 회원 정보를 사용하여 HTML 코드 작성
					if (TenantMembers.size() > 0) {
						for (Tenant tenant : TenantMembers) {
							if (tenant instanceof Tenant) {
						Tenant TenantMember = tenant; // Tenant로 캐스팅
					%>
					<div class="row">
						<div class="col-md-2">
							<p>
								<strong>입주자 아이디:</strong>
								<%=TenantMember.getId()%>
							</p>
						</div>
						<div class="col-md-2">
							<p>
								<strong>입주자 명:</strong>
								<%=TenantMember.getName()%>
							</p>
						</div>
						<div class="col-md-2">
							<p>
								<strong>거주지:</strong>
								<%=TenantMember.getAccessiondate()%>
							</p>
						</div>
						<div class="col-md-2">
							<p>
								<strong>가입일:</strong>
								<%=TenantMember.getResidence()%>
							</p>
						</div>
						<div class="col-md-2">
							<button class="btn btn-success btnAccept"
								data-id="<%=TenantMember.getId()%>"
								data-name="<%=TenantMember.getName()%>"
								data-password="<%=TenantMember.getPassword()%>"
								data-accessiondate="<%=TenantMember.getAccessiondate()%>"
								data-residence="<%=TenantMember.getResidence()%>">수락</button>
							<button class="btn btn-danger">거절</button>
						</div>
					</div>

					<%
					} else {
					%>
					<!-- 적절한 타입이 아닌 경우 처리 -->
					<p>회원 정보가 없습니다.</p>
					<%
					}
					}
					} else {
					%>
					<p>회원 정보가 없습니다.</p>
					<%
					}
					%>
				</div>
			</div>
		</div>
		<div class="col-lg-8">
			<a href="MemberManagement.jsp" class="btn btn-primary">회원 관리</a> 
			<a href="PostManagement.jsp" class="btn btn-primary">글 관리</a>
			<a href="CalendarManagement.jsp" class="btn btn-primary">일정 관리</a>
		</div>
		<%
		int total = TenantMembers.size();
		%>
		<!-- 페이지 -->
		<ul class="pagination justify-content-center">
			<li class="page-item"><a class="page-link" href="#"
				id="previous">&laquo;</a></li>
			<%
			for (int i = 1; i <= (int) Math.ceil((double) total / 10); i++) {
			%>
			<li class="page-item <%=i == 1 ? "active" : ""%>"><a
				class="page-link" href="#"><%=i%></a></li>
			<%
			}
			%>
			<li class="page-item"><a class="page-link" href="#" id="next">&raquo;</a></li>
		</ul>
	</div>

	<script>
		// 회원 관리 버튼에 대한 클릭 이벤트 처리
		$(".btnAccept").on("click", function() {
			var id = $(this).data("id");
			var name = $(this).data("name");
			var password = $(this).data("password");
			var accessiondate = $(this).data("accessiondate");
			var residence = $(this).data("residence");

			// AJAX 요청을 보냅니다.
			$.ajax({
				url : "Tenant.jsp",
				method : "POST",
				data : {
					id : id,
					name : name,
					password : password,
					accessiondate : accessiondate,
					residence : residence,
					btnAccept : "true"
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
	</script>
</body>
</html>
