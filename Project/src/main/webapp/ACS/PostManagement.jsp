<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page import="dbsql.Select"%>
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
	
	<div class="container mt-3">
		<div class="card">
			<div class="card-header">글 목록</div>
			<div class="card-body">
				<%-- Java 코드 작성 (스크립트릿) --%>
				<!-- 글목록 정보를 표시하는 플레이스홀더 요소 -->
				<%
				// Java 코드 작성 (스크립트릿)
				// DBSQL 객체 생성
				Select dbsql = new Select("Post");
				Post p = new Post();

				// 데이터베이스에서 글목록 가져오기
				List<Post> PostMembers = dbsql.DBSelect(p); // 적절한 메서드를 호출하여 글목록 정보를 가져오도록 수정해야 합니다.

				// 가져온 글목록 정보를 사용하여 HTML 코드 작성
				if (PostMembers.size() > 0) {
					for (Post post : PostMembers) {
						if (post instanceof Post) {
					Post PostMember = (Post) post; // Post로 캐스팅
				%>
				<div class="row">
					<div class="col-lg-8">
						<a><%=PostMember.getPostid()%> [<%=PostMember.getType()%>] 제목:
							<%=PostMember.getTitle()%> 작성자: <%=PostMember.getName()%> 조회수: <%=PostMember.getViewsnum()%>
							날짜: <%=PostMember.getWritingdate()%></a>
					</div>
					<div class="col-lg-1">
						<button class="btn btn-danger btnPostDelete"
							data-id="<%=PostMember.getPostid()%>">글 삭제</button>
					</div>
				</div>
				<%
				}
				}
				} else {
				%>
				<p>게시글이 없습니다.</p>
				<%
				}
				%>
			</div>
			<div class="col-lg-8">
				<a href="MemberManagement.jsp" class="btn btn-primary">회원 관리</a> <a
					href="AdminView.jsp" class="btn btn-primary">회원 수락</a> <a
					href="CalendarManagement.jsp" class="btn btn-primary">일정 관리</a>
			</div>
		</div>
	</div>
	<script>
		// 임시 차단 버튼에 대한 클릭 이벤트 처리
		$(".btnPostDelete").on("click", function() {
			var id = $(this).data("id");

			// AJAX 요청을 보냅니다.
			$.ajax({
				url : "Post.jsp",
				method : "POST",
				data : {
					id : id,
					btnPostDelete : "true"
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