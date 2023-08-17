<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dbsql.Select"%>
<%@ page import="table.*"%>
<%@ page import="java.util.List"%>
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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

<title>내 정보 관리 창</title>
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

a.btn-link {
	text-decoration: none;
	color: black;
}
</style>
</head>
<body>
	<%@include file="nav.jsp"%>

	<div class="container" id="MyInfoForm">
		<h2>내 정보 관리</h2>
		<hr>
		<p>소중한 내 정보를 확인하세요.</p>
		<hr>
		<div class="mb-3">
			<label for="joinDate" class="form-label">가입날짜</label> <input
				type="text" id="joinDate" name="joinDate" class="form-control"
				readonly>
			<%
			String accessiondate = (String) session.getAttribute("ACCESSIONDATE");
			%>
			<script>
        // 세션에서 가져온 가입날짜를 텍스트 박스에 설정
        document.getElementById("joinDate").value = "<%=accessiondate%>";
    </script>
		</div>
		<div class="mb-3">
			<label for="ID" class="form-label">아이디</label> <input type="text"
				id="ID" name="ID" class="form-control" readonly>
			<%
			String id = (String) session.getAttribute("ID");
			%>
			<script>
        	// 세션에서 가져온 아이디를 텍스트 박스에 설정
        	document.getElementById("ID").value = "<%=id%>";
   			 </script>
		</div>
		<div class="mb-3">
			<label for="name" class="form-label">이름</label> <input type="text"
				id="name" name="name" class="form-control" readonly>
			<%
			String name = (String) session.getAttribute("NAME");
			%>
			<script>
            // 세션에서 가져온 이름을 텍스트 박스에 설정
          document.getElementById("name").value = "<%=name%>";
          </script>
		</div>
		<div class="mb-3">
			<label for="address" class="form-label">거주지</label> <input
				type="text" id="address" name="address" class="form-control"
				readonly>
			<%
			String residence = (String) session.getAttribute("RESIDENCE");
			%>
			<script>
            // 세션에서 가져온 입주정보를 텍스트 박스에 설정
          document.getElementById("address").value = "<%=residence%>";
          </script>
		</div>
		<div class="mb-3">
			<div class="input-group">
				<!-- 글 목록을 표시하는 부분 -->
				<div id="searchResultsContainer" class="container mt-5">
					<label for="myPosts" class="form-label">내가 쓴 글</label>
					<div class="card">
						<div class="row justify-content-center">
							<div class="col-lg-1">
								<p>번호</p>
							</div>
							<div class="col-lg-1">
								<p>타입</p>
							</div>
							<div class="col-lg-3">
								<p>제목</p>
							</div>
							<div class="col-lg-1">
								<p>작성자</p>
							</div>
							<div class="col-lg-2">
								<p>작성일</p>
							</div>
							<div class="col-lg-1">
								<p>조회</p>
							</div>
							<div class="col-lg-1">
								<p>추천</p>
							</div>
							<div class="col-lg-1">
							</div>
							<div class="col-lg-1">
							</div>
						</div>

						<div class="card-body">
							<%-- Java 코드 작성 (스크립트릿) --%>
							<!-- 글목록 정보를 표시하는 플레이스홀더 요소 -->
							<%
							// Java 코드 작성 (스크립트릿)
							// DBSQL 객체 생성
							Select dbsqlPost = new Select("Post");
							Post post = new Post();

							// 데이터베이스에서 글목록 가져오기
							List<Post> PostMembers = dbsqlPost.DBSelect(post); // 적절한 메서드를 호출하여 글목록 정보를 가져오도록 수정해야 합니다.

							// 가져온 글목록 정보를 사용하여 HTML 코드 작성
							if (PostMembers.size() > 0) {
								for (Post obj : PostMembers) {
									if (obj instanceof Post) {
								Post PostMember = obj; // Post로 캐스팅
								String title = PostMember.getTitle();
								if (title.length() > 25) {
									title = title.substring(0, 25) + "...";
								}

								// 여기서 추가된 조건문을 확인합니다.
								if (PostMember.getId().equals(id)) { // Post의 아이디 값과 세션에 저장된 아이디 값을 비교
									System.out.println(PostMember.getType());
									if (PostMember.getType().equals("잡담")
											|| (PostMember.getType().equals("공지") && PostMember.getId().equals("admin"))) {
							%>
							<!-- 이 부분부터는 추가된 조건문이 적용된 영역입니다. -->
							<div class="row">
								<div class="col-lg-1">
									<p><%=PostMember.getPostid()%></p>
								</div>
								<div class="col-lg-1">
									<a class="btn btn-link"
										onclick="setPostType('<%=PostMember.getType()%>')"> <%=PostMember.getType()%></a>
								</div>
								<div class="col-lg-3">
									<a class="btn btn-link"
										onclick="viewPostDetails(<%=PostMember.getPostid()%>)"> <%=title%></a>
								</div>
								<div class="col-lg-1">
									<p><%=PostMember.getName()%></p>
								</div>
								<div class="col-lg-2">
									<p><%=PostMember.getWritingdate()%></p>
								</div>
								<div class="col-lg-1">
									<p><%=PostMember.getViewsnum()%></p>
								</div>
								<div class="col-lg-1">
									<p>추천</p>
								</div>
								<div class="col-lg-1">
									<button class="btn btn-outline-secondary" type="button"
										onclick="viewPostCreationEditing(<%=PostMember.getPostid()%>)">수정</button>
								</div>
								<div class="col-lg-1">
									<button class="btn btn-outline-secondary" type="button"
										onclick="PostDelete(<%=PostMember.getPostid()%>)">삭제</button>
								</div>
							</div>

							<button class="btn btn-link"
								onclick="viewPostDetails(<%=PostMember.getPostid()%>)"></button>


							<%
							}
							}
							// 추가된 조건문 종료
							}
							}
							} else {
							%>
							<p>게시글이 없습니다.</p>
							<%
							}
							%>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="mb-3">
			<div class="input-group">
				<!-- 댓글 목록을 표시하는 부분 -->
				<div id="commentResultsContainer" class="container mt-5">
					<label for="myPosts" class="form-label">댓글 목록</label>
					<div class="card">
						<div class="row justify-content-center">
							<div class="col-lg-1">
								<p>번호</p>
							</div>
							<div class="col-lg-1">
								<p>타입</p>
							</div>
							<div class="col-lg-6">
								<p>내용</p>
							</div>
							<div class="col-lg-1">
								<p>작성자</p>
							</div>
							<div class="col-lg-2">
								<p>작성일</p>
							</div>
							<div class="col-lg-1"></div>
						</div>
						<%-- 여기서 댓글 목록을 가져옵니다. --%>
						<%-- Comment 클래스를 사용하여 댓글 데이터를 가져옵니다. --%>
						<%
						Select dbsqlComment = new Select("Post");
						Post postComment = new Post();

						// 데이터베이스에서 글목록 가져오기
						List<Post> CommentPostMembers = dbsqlPost.DBSelect(post); // 적절한 메서드를 호출하여 글목록 정보를 가져오도록 수정해야 합니다.

						// 가져온 글목록 정보를 사용하여 HTML 코드 작성
						if (PostMembers.size() > 0) {
							for (Post obj : PostMembers) {
								if (obj instanceof Post) {
							Post PostMember = obj; // Post로 캐스팅
							String title = PostMember.getTitle();
							if (title.length() > 25) {
								title = title.substring(0, 25) + "...";
							}
							// 여기서 추가된 조건문을 확인합니다.
							if (PostMember.getId().equals(id)) { // Post의 아이디 값과 세션에 저장된 아이디 값을 비교
								System.out.println(PostMember.getType());
								if (PostMember.getType().equals("댓글")) {
						%>
						<!-- 이 부분부터는 추가된 조건문이 적용된 영역입니다. -->
						<div class="row">
							<div class="col-lg-1">
								<p><%=PostMember.getTitle()%></p>
							</div>
							<div class="col-lg-1">
								<p><%=PostMember.getType()%></p>
							</div>
							<div class="col-lg-6">
								<p><%=PostMember.getText()%></p>
							</div>
							<div class="col-lg-1">
								<p><%=PostMember.getName()%></p>
							</div>
							<div class="col-lg-2">
								<p><%=PostMember.getWritingdate()%></p>
							</div>
							<div class="col-lg-1">
								<button class="btn btn-outline-secondary" type="button"
									onclick="PostDelete(<%=PostMember.getPostid()%>)">삭제</button>
							</div>
						</div>
						<%
						}
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
		</div>
	</div>

	<script>
		var postType = ''; // 기본값은 빈 문자열
		 
	    function setPostType(value) {
			postType = value;
	        console.log("setPostType",postType);
	        searchPosts();
	    }
		
	    function viewPostDetails(postid) {
	        // AJAX를 이용하여 서버에 글 상세 정보 요청
	        console.log("ajax 보내기 전",postid);
	        $.ajax({
	            url: "PostDetailsView.jsp",
	            type: "POST", // POST 메소드 사용
	            data: { postid : postid },
	            success: function(response) {
	                // 성공시, 받은 응답으로 postdetailsview.jsp 페이지로 이동
	                window.location.href = "PostDetailsView.jsp?postid=" + postid;
	            },
	            error: function(xhr, status, error) {
	                // 필요한 경우 에러 처리
	                console.error(error);
	            }
	        });
	    }
	    
	    function viewPostCreationEditing(postid) {
	        // AJAX를 이용하여 서버에 글 상세 정보 요청
	        console.log("ajax 보내기 전",postid);
	        $.ajax({
	            url: "PostCreationEditing.jsp",
	            type: "POST", // POST 메소드 사용
	            data: { postid : postid },
	            success: function(response) {
	                // 성공시, 받은 응답으로 postdetailsview.jsp 페이지로 이동
	                window.location.href = "PostCreationEditing.jsp?postid=" + postid;
	            },
	            error: function(xhr, status, error) {
	                // 필요한 경우 에러 처리
	                console.error(error);
	            }
	        });
	    }
	    
	    function PostDelete(id){
	    	// AJAX를 이용하여 서버에 글 삭제
	    	console.log("ajax 보내기 전",id);
	    	$.ajax({
	    		url : "Post.jsp",
	    		type : "POST",
				data : {
					id : id,
					btnPostDelete : "true"
				},
	            success: function(response) {
	            	// 요청이 성공적으로 처리되었을 때 실행되는 코드
					console.log("요청이 성공적으로 처리되었습니다.");
					console.log("서버 응답: ", response); // Log server response to browser console

					location.reload(); // 성공 후 페이지 새로 고침
	            },
	            error: function(xhr, status, error) {
	                // 필요한 경우 에러 처리
	            	console.error("요청이 실패하였습니다.");
					console.error(xhr, status, error);
	            }
	        });
	    }
	    
	    $(document).ready(function() {
	    	 var urlParams = new URLSearchParams(window.location.search);
	    	 var urlType = urlParams.get("postType");
	    	 if (urlType) {
	    		 setPostType(urlType);
	         }
	    });
	</script>
</body>
</html>