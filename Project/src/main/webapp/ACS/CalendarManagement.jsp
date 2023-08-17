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

	<div class="container mt-2">
		<div class="card">
			<div class="card-header">
				일정 관리
				<button class="btn btn-secondary btnCalendarInsert">일정 추가</button>
			</div>
			<%
			Select select = new Select("Calendar");
			Calendar c = new Calendar();

			// 데이터베이스에서 회원 정보 가져오기
			List<Calendar> CalendarMembers = select.DBSelect(c);

			// 가져온 회원 정보를 사용하여 HTML 코드 작성
			if (CalendarMembers.size() > 0) {
				for (Calendar calendar : CalendarMembers) {
					if (calendar instanceof Calendar) {
				Calendar CalendarMember = calendar;
			%>
			<div class="card-body">
				<div class="row">
					<div class="row">
						<div class="col-md-1">
							<p><%=CalendarMember.getCalid()%></p>
						</div>
						<div class="col-md-3">
							<p>
								기간 :
								<%=CalendarMember.getStartdate()%>~<%=CalendarMember.getEnddate()%></p>
						</div>
						<div class="col-md-2">
							<a class="btn btn-link"
								onclick="viewPostDetails(<%=CalendarMember.getPostid()%>)"><%=CalendarMember.getText()%></a>
						</div>
						<div class="col-lg-1">
							<button class="btn btn-danger btnCalendarDelete"
								data-calid="<%=CalendarMember.getCalid()%>"
								data-postid="<%=CalendarMember.getPostid()%>">일정 삭제</button>
						</div>
					</div>

					<%
					} else {
					%>
					<!-- 적절한 타입이 아닌 경우 처리 -->
					<p>일정 정보가 없습니다.</p>
					<%
					}
					}
					} else {
					%>
					<p>일정 정보가 없습니다.</p>
					<%
					}
					%>
				</div>
				<div class="col-lg-8">
					<a href="AdminView.jsp" class="btn btn-primary">회원 수락</a> <a
						href="MemberManagement.jsp" class="btn btn-primary">회원 관리</a> <a
						href="PostManagement.jsp" class="btn btn-primary">글 관리</a>
				</div>
			</div>

		</div>

	</div>

	<script>
	// 게시글 번호에 해당하는 일정 글 보기 
	function viewPostDetails(postid) {
        // AJAX를 이용하여 서버에 글 상세 정보 요청
        console.log("ajax 보내기 전",postid);
        $.ajax({
            url: "PostDetailsView.jsp",
            type: "POST", // POST 메소드 사용
            data: { postid : postid },
            success: function(response) {
            	$("#searchResultsContainer").html(response);
				$("#infoContainer").hide();
            },
            error: function(xhr, status, error) {
                // 필요한 경우 에러 처리
                console.error(error);
            }
        });
    }
	
	// 일정 추가 버튼에 대한 클릭 이벤트 처리
	$(".btnCalendarInsert").on("click", function() {
		window.location.href = "CalendarInsert.jsp";
	});
	
	// 일정 삭제 버튼에 대한 클릭 이벤트 처리
	$(".btnCalendarDelete").on("click", function() {
		var calid = $(this).data("calid");
		var postid = $(this).data("postid");

		// AJAX 요청을 보냅니다.
		$.ajax({
			url : "Calendar.jsp",
			method : "POST",
			data : {
				calid : calid,
				postid : postid,
				btnCalendarDelete : "true"
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