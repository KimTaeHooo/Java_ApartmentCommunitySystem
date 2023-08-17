<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.Date"%>
<%@ page import="dbsql.Select"%>
<%@ page import="dbsql.Update"%>
<%@ page import="table.Post"%>
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
<title>글 세부 화면</title>
</head>
<body>
	<%-- Java 코드 작성 (스크립트릿) --%>
	<%
	// 클라이언트로부터 전송된 데이터 받기
	String postidStr = request.getParameter("postid");
	Post post = new Post();
	Select dbsqlSelect = new Select("Post");
	Update dbsqlUpdate = new Update("Post");
	Post PostMember = null;
	List<Post> PostMembers = null;

	int postid = 0; // 기본값으로 초기화
	String jsonString = "";
	// postidStr이 null이 아니고 숫자 형태일 경우에만 Integer로 변환
	if (postidStr != null && postidStr.matches("\\d+")) {
		System.out.println("postidStr: " + postidStr);
		postid = Integer.parseInt(postidStr);

		// 데이터베이스에서 글목록 가져오기
		PostMembers = dbsqlSelect.DBSelect(post, postid); // 적절한 메서드를 호출하여 글목록 정보를 가져오도록 수정해야 합니다.
		if (PostMembers != null && PostMembers.size() > 0) {
			for (Post obj : PostMembers) {
		if (obj instanceof Post) {
			PostMember = obj; // Post로 캐스팅
		}
			}
		} else {
			System.out.println("PostMembers 오류");
		}
		dbsqlUpdate.DBUpdate(post, postid, PostMember.getViewsnum());
		System.out.println("조회수: " + PostMember.getViewsnum());
		System.out.println(PostMember.getTitle() + PostMember.getText() + PostMember.getType() + PostMember.getImg());
	}
	%>
	<div class="container mt-3">
		<div class="card">
			<div class="card-header">
				<div class="row">
					<div class="col-md-3" id=Type>
						<p>
							<strong>타입:</strong>
							<%=(PostMember != null) ? PostMember.getType() : "데이터가 없습니다"%>
						</p>
					</div>
					<div class="col-md-3" id=Title>
						<p>
							<strong>제목:</strong>
							<%=(PostMember != null) ? PostMember.getTitle() : "데이터가 없습니다"%>
						</p>
					</div>
					<div class="col-md-3" id=Name>
						<p>
							<strong>작성자:</strong>
							<%=(PostMember != null) ? PostMember.getName() : "데이터가 없습니다"%>
						</p>
					</div>
					<div class="col-md-3">
						<p>
							<strong>조회수:</strong>
							<%=(PostMember != null) ? PostMember.getViewsnum() + 1 : "데이터가 없습니다"%>
						</p>
					</div>
				</div>
			</div>
			<div class="card-body">
				<div class="col">
					<div id="textArea">
						<p><%=PostMember.getText() != null ? PostMember.getText() : " "%></p>
					</div>
					<div id="img">
						<p><%=PostMember.getImg() != null ? PostMember.getImg() : " "%></p>
					</div>
				</div>
			</div>
			<div class="col">
				<div class="col-md-3" id="Type">
					<!-- 댓글 라벨 -->
					<label for="comment"><strong>댓글:</strong></label>
					<!-- 댓글을 입력할 수 있는 텍스트 박스 -->
					<textarea class="form-control" id="comment" rows="3"
						placeholder="댓글을 입력하세요"></textarea>
					<div class="text-end">
						<!-- 확인 버튼 -->
						<button class="btn btn-primary mt-2" onclick="submitComment()">확인</button>
					</div>
				</div>
				<div class="card-body">
					<div class="row mt-4">
						<div class="col">
							<!-- 댓글 목록을 표시하는 부분 -->
							<div id="searchResultsContainer" class="container mt-5">
								<div class="card">
									<div class="row justify-content-center">
										<div class="col-lg-4">
											<p>작성자</p>
										</div>
										<div class="col-lg-6">
											<p>내용</p>
										</div>
										<div class="col-lg-2">
											<p>작성일</p>
										</div>
									</div>
									<div class="card-body">
										<%-- Java 코드 작성 (스크립트릿) --%>
										<%-- 댓글 목록을 표시하는 부분 --%>
										<%
										// 데이터베이스에서 댓글 목록 가져오기
										Select select = new Select("post");
										List<Post> commentList = select.DBSelect(post, postid);

										// 가져온 댓글 목록 정보를 사용하여 HTML 코드 작성
										if (commentList != null && commentList.size() > 0) {
											for (Post comment : commentList) {
												if (comment instanceof Post) {
											// 댓글의 POSTID와 게시글의 POSTID를 비교하여 관련된 댓글만 출력
											if (comment.getTitle().equals(String.valueOf(PostMember.getPostid()))) {
										%>
										<div class="row">
											<div class="col-lg-4">
												<p><%=comment.getName()%></p>
											</div>
											<div class="col-lg-6">
												<p><%=comment.getText()%></p>
											</div>
											<div class="col-lg-2">
												<p><%=comment.getWritingdate()%></p>
											</div>
										</div>
										<%
										}
										}
										}
										} else {
										%>
										<p>댓글이 없습니다.</p>
										<%
										}
										%>
									</div>
								</div>
							</div>
							<!-- 댓글목록 끝 -->
						</div>
					</div>
				</div>
			</div>
		</div>
		<form id="postForm" action="PostCreationEditing.jsp" method="post">
			<input type="hidden" name="postTitle"
				value="<%=PostMember.getTitle()%>"> <input type="hidden"
				name="postContent" value="<%=PostMember.getText()%>"> <input
				type="hidden" name="postType" value="<%=PostMember.getType()%>">
			<input type="hidden" name="postImgSrc"
				value="<%=PostMember.getImg()%>">
		</form>

		<script>
			function textAreaView() {
				var textArea = document.getElementById("textArea");
				var content = textArea.innerHTML;
				content = content.replace(/\[style (.*?)\]/g,
						function(_, style) {
							return '<span style="' + style + '">';
						});
				content = content.replace(/\[\/style\]/g, '</span>');
				textArea.innerHTML = content;
			}

			function callMainViewSetPostType(value) {
				window.location.href = "MainView.jsp?postType=" + value;
			}

			function submitComment() {
				var content = document.getElementById("comment").value;

				// AJAX 요청을 보냄
				$.ajax({
					url : "Comment.jsp", // 댓글을 처리할 페이지 URL
					method : "POST",
					data : {
						commentText : content,
						commentPostId :
		<%=PostMember.getPostid()%>
			,
						btnConfirmComment : "true"
					},
					success : function(response) {
						// 요청이 성공적으로 처리되었을 때 실행되는 코드
						console.log("요청이 성공적으로 처리되었습니다.");
						console.log("서버 응답: ", response); // 브라우저 콘솔에 서버 응답 기록
						// 댓글 작성 폼을 초기화
						document.getElementById("comment").value = "";
						// 댓글 목록을 업데이트
						// 여기서는 새로고침을 통해 댓글 목록을 가져와서 표시할 수 있습니다.
						// 실제로는 AJAX를 이용하여 서버로부터 댓글 목록을 가져와서 업데이트하는 것이 좋습니다.
						window.location.reload();
					},
					error : function(xhr, status, error) {
						// 요청이 실패하거나 에러가 발생했을 때 실행되는 코드
						console.error("요청이 실패하였습니다.");
						console.error(xhr, status, error);
					}
				});
			}

			// 함수 호출
			textAreaView();
		</script>
</body>
</html>