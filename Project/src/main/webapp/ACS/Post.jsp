<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.Date"%>
<%@ page import="dbsql.*"%>
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
<title>게시글</title>
</head>
<body>
	<%-- Java 코드 작성 (스크립트릿) --%>
	<%
	String id = (String) session.getAttribute("ID");
	// 클라이언트로부터 전송된 데이터 받기   
	// PostCreationEditing.jsp
	String postIdString = request.getParameter("postId");
	String postContent = request.getParameter("postContent");
	String postTitle = request.getParameter("postTitle");
	String postImg = request.getParameter("postImg");
	String btnConfirm = request.getParameter("btnConfirm");
	String notice = request.getParameter("notice");
	String Schedule = request.getParameter("Schedule");
	String editing = request.getParameter("editing");
	String Radio = "";
	int postId = 0;
	// PostManagement.jsp
	String btnPostDelete = request.getParameter("btnPostDelete");

	// 클라이언트로부터 전송된 데이터 받기
	String postType = request.getParameter("postType");
	String postValue = request.getParameter("postValue");
	String searchText = request.getParameter("searchText");
	String currentPageParam = request.getParameter("currentPage");
	String btnPostSearch = request.getParameter("btnPostSearch");
	int currentPage = 1; // 기본 페이지 1

	if (currentPageParam != null && !currentPageParam.isEmpty()) {
		currentPage = Integer.parseInt(currentPageParam);
		System.out.println("currentPage: " + currentPage);
	}
	if (postIdString != null && !postIdString.isEmpty()) {
		postId = Integer.parseInt(postIdString);
	}

	System.out.println("postType : " + postType + ", postValue : " + postValue + ", currentPage : " + currentPage);
	System.out.println("Editing: " + editing + "postid: " + postId);
	// 요청 파라미터에서 confirm 값을 확인하여 데이터 삽입 여부를 결정
	if (btnConfirm != null && btnConfirm.equals("true")) {
		if (editing.equals("false")) {
			// DBSQL 객체 생성
			Post post = new Post();
			Insert dbsqlInsert = new Insert("Post");
			//newPost.setPostid(2); // 원하는 값을 설정합니다.
			String name = (String) session.getAttribute("NAME");

			if (notice.equals("true")) {
		Radio = "공지";
			} else {
		Radio = "잡담";
			}
			post.setType(Radio);
			post.setTitle(postTitle);
			post.setText(postContent);
			post.setWritingdate(new Date(System.currentTimeMillis()));
			post.setId(id);
			post.setName(name);
			post.setImg(postImg);
			post.setViewsnum(0);
			System.out.println("Radio: " + Radio + ", postTitle: " + postTitle + ", postContent: " + postContent
			+ ", Date: " + new Date(System.currentTimeMillis()) + ", id: " + id + ", name: " + name + ", postImg: "
			+ postImg + ", Viewsnum: " + 0);

			// 데이터를 삽입합니다.
			dbsqlInsert.DBInsert(post);

			// Send the response to the Eclipse console using JSP's 'out' object
			out.println("요청이 성공적으로 처리되었습니다.");
			out.println("서버 응답: " + "데이터가 성공적으로 저장되었습니다."); // You can customize this message as needed
		} else if (editing.equals("true")) {
			// DBSQL 객체 생성
			Post post = new Post();
			Update dbsqlUpdate = new Update("Post");
			//newPost.setPostid(2); // 원하는 값을 설정합니다.
			String name = (String) session.getAttribute("NAME");

			if (notice.equals("true")) {
		Radio = "공지";
			} else {
		Radio = "잡담";
			}
			post.setType(Radio);
			post.setTitle(postTitle);
			post.setText(postContent);
			post.setWritingdate(new Date(System.currentTimeMillis()));
			post.setId(id);
			post.setName(name);
			post.setImg(postImg);
			post.setViewsnum(0);
			//System.out.println("Radio: " + Radio + ", postTitle: " + postTitle + ", postContent: " + postContent
			//+ ", Date: " + new Date(System.currentTimeMillis()) + ", id: " + id + ", name: " + name + ", postImg: "
			//+ postImg + ", Viewsnum: " + 0+", postId: " + postId);

			// 데이터를 삽입합니다.
			dbsqlUpdate.DBUpdate(post, postId);

			// Send the response to the Eclipse console using JSP's 'out' object
			out.println("요청이 성공적으로 처리되었습니다.");
			out.println("서버 응답: " + "데이터가 성공적으로 저장되었습니다."); // You can customize this message as needed
		}
	}

	// 관리자가 글 삭제
	if (btnPostDelete != null && btnPostDelete.equals("true")) {
		// DBSQL 객체 생성
		Post post = new Post();
		Delete dbsql = new Delete("Post");

		int postid = Integer.parseInt(request.getParameter("id"));

		// 데이터를 삽입합니다.
		dbsql.DBDelete(post, postid);

		// Send the response to the Eclipse console using JSP's 'out' object
		out.println("요청이 성공적으로 처리되었습니다.");
		out.println("서버 응답: " + "데이터가 성공적으로 저장되었습니다."); // You can customize this message as needed
	}

	if (btnPostSearch != null && btnPostSearch.equals("true")) {
		Select dbsqlPost = new Select("Post");
		Post post = new Post();
		List<Post> PostMembers = null;
		if ((postType.equals("") || postType.equals("전체")) && (searchText == null || searchText.trim().isEmpty())) {
			// 검색어가 없고 타입이 전체일 때, 전체 글 목록을 가져옴
			PostMembers = dbsqlPost.DBSelect(post);
			request.setAttribute("PostMembers", PostMembers);
		} else if (searchText == null || searchText.trim().isEmpty()) {
			// 검색어가 없을 경우, 해당하는 타입의 글 목록을 가져옴
			PostMembers = dbsqlPost.DBSelect(post, postType);
			request.setAttribute("PostMembers", PostMembers);
		} else if (postType.equals("") || postType.equals("전체")) {
			// 검색어가 있고 타입이 전체일 때, 해당하는 글 목록을 가져옴 
			PostMembers = dbsqlPost.DBSelect(post, postValue, searchText);
			request.setAttribute("PostMembers", PostMembers);
		} else {
			// 검색어가 있을 경우, 해당하는 타입의 글 목록을 가져옴
			PostMembers = dbsqlPost.DBSelect(post, postValue, searchText, postType);
			request.setAttribute("PostMembers", PostMembers);
		}

		int total = PostMembers.size();
		int itemsPerPage = 10; // 10개씩 끊어서 보기

		// 현재 페이지에 해당하는 게시물들을 가져오는 로직
		int startIndex = (currentPage - 1) * itemsPerPage;
		int endIndex = Math.min(startIndex + itemsPerPage, total);
	%>

	<div class="row justify-content-center">
		<div class="col-lg-1">
			<p>번호</p>
		</div>
		<div class="col-lg-1">
			<p>타입</p>
		</div>
		<div class="col-lg-5">
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
	</div>
	<div class="card-body">
		<%
		//PostMembers = (List<Post>) request.getAttribute("PostMembers");
		if (PostMembers != null && !PostMembers.isEmpty()) {
			for (int i = startIndex; i < endIndex; i++) {
				Post obj = PostMembers.get(i);
				if (obj instanceof Post) {
			Post PostMember = obj; // Post로 캐스팅
			String title = PostMember.getTitle();
			if (title.length() > 25) {
				title = title.substring(0, 25) + "...";
			}
			if (PostMember.getType().equals("잡담") || (PostMember.getType().equals("공지"))||(PostMember.getType().equals("일정"))) {
		%>
		<div class="row">
			<div class="col-lg-1">
				<p><%=PostMember.getPostid()%></p>
			</div>
			<div class="col-lg-1">
				<p><%=PostMember.getType()%></p>
			</div>
			<div class="col-lg-5">
				<a class="btn btn-link"
					onclick="viewPostDetails(<%=PostMember.getPostid()%>)"><%=title%></a>
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
		</div>
		<%
		}
		}
		}
		} else {
		%>
		<p>검색 결과가 없습니다.</p>
		<%
		}
		%>
	</div>
	<%
	}
	%>
</body>
</html>