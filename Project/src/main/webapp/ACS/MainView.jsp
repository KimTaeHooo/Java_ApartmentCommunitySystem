<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="dbsql.Select"%>
<%@ page import="table.*"%>
<%@ page import="java.util.List"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.sql.Date"%>
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
<!-- 아래 스크립트는 달력 관련 -->
<meta http-equiv='X-UA-Compatible' content='IE=edge'>
<meta name='viewport' content='width=device-width, initial-scale=1'>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/fullcalendar@5.7.0/main.min.css">
<script type="text/javascript"
	src="https://cdn.jsdelivr.net/npm/fullcalendar@5.7.0/main.min.js"></script>
<!--<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script> -->
<!-- FullCalendar 라이브러리를 이용하여 일정을 표시하는 부분 -->
<style>
#calendarBox {
	width: 100%;
}

a.btn-link {
	text-decoration: none;
	color: black;
}

/* 달력 스타일 설정 */
.card-body #calendarBox #calendar a {
	text-decoration: none;
	color: black;
}
</style>
<title>메인 화면</title>
</head>
<body>
	<%@include file="nav.jsp"%>

	<div id="infoContainer" class="container mt-3">
		<!-- 그리드 시스템을 사용하여 달력의 정보, 일정의 글 목록, 로그인 시에만 보이는 회원정보를 한 줄로 배치 -->
		<div class="row">
			<div class="col-lg-8">
				<!-- 달력의 정보를 받아들이는 div -->
				<div class="card">
					<div class="card-body">
						<!-- 달력 정보를 표시하는 내용 -->
						<div id="calendarBox">
							<div id="calendar"></div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-4">
				<!-- 회원정보 표시하는 부분 -->
				<!-- 로그인 시에만 보이는 회원정보 div -->
				<div id="memberInfo" class="card">
					<div class="card-body">
						<%-- Java 코드 작성 (스크립트릿) --%>
						<%-- 회원정보를 표시하는 플레이스홀더 요소 --%>
						<%
						// Java 코드 작성 (스크립트릿)
						// 세션에서 회원정보 가져오기
						String id = (String) session.getAttribute("ID");
						String name = (String) session.getAttribute("NAME");
						String residence = (String) session.getAttribute("RESIDENCE");
						System.out.println(id + name + residence);
						%>
						<%-- 세션에 ID, NAME, RESIDENCE 정보가 있는지 체크하고 표시 --%>
						<%
						if (id != null && name != null && residence != null) {
						%>
						<p><%=name%>님. 환영합니다~!♥
						</p>
						<p>
							아이디:
							<%=id%></p>
						<p>
							거주지:
							<%=residence%></p>
						<%
						} else {
						%>
						<p>회원 정보가 없습니다.</p>
						<%
						}
						%>
					</div>
				</div>
				<!-- 일정의 글 목록을 받아들이는 div -->
				<div class="card">
					<div class="card-body">
						<!-- 일정 글 목록을 표시하는 내용 -->
						일정
						<%-- Java 코드 작성 (스크립트릿) --%>
						<!-- 글목록 정보를 표시하는 플레이스홀더 요소 -->
						<%
						// Java 코드 작성 (스크립트릿)
						// DBSQL 객체 생성
						Select dbsqlScedule = new Select("Calendar");
						Calendar pScedule = new Calendar();

						// 데이터베이스에서 글목록 가져오기
						List<Calendar> SceduleMembers = dbsqlScedule.DBSelect(pScedule); // 적절한 메서드를 호출하여 글목록 정보를 가져오도록 수정해야 합니다.

						// 가져온 글목록 정보를 사용하여 HTML 코드 작성
						if (SceduleMembers.size() > 0) {
							for (Calendar obj : SceduleMembers) {
								if (obj instanceof Calendar) {
							Calendar SceduleMember = obj; // Post로 캐스팅
						%>
						<p>
							<%=SceduleMember.getCalid()%>
							기간:<%=SceduleMember.getStartdate()%>
							~
							<%=SceduleMember.getEnddate()%>
							내용: <a class="btn btn-link"
								onclick="viewPostDetails(<%=SceduleMember.getPostid()%>)"><%=SceduleMember.getText()%></a>
						</p>
						<%
						}
						}
						} else {
						%>
						<p>일정이 없습니다.</p>
						<%
						}
						%>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 글 목록을 표시하는 부분 -->
	<div id="searchResultsContainer" class="container mt-5">
		<div class="card">
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
				<%-- Java 코드 작성 (스크립트릿) --%>
				<!-- 글목록 정보를 표시하는 플레이스홀더 요소 -->
				<%
				// Java 코드 작성 (스크립트릿)
				// DBSQL 객체 생성
				Select dbsqlPost = new Select("Post");
				Post post = new Post();

				// 데이터베이스에서 글목록 가져오기
				List<Post> PostMembers = dbsqlPost.DBSelect(post, 10.0); // 적절한 메서드를 호출하여 글목록 정보를 가져오도록 수정해야 합니다.

				// 가져온 글목록 정보를 사용하여 HTML 코드 작성
				if (PostMembers.size() > 0) {
					for (Post obj : PostMembers) {
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
						<a class="btn btn-link"
							onclick="setPostType(<%=PostMember.getType()%>)"> <%=PostMember.getType()%></a>
					</div>
					<div class="col-lg-5">
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
				</div>
				<%
				}
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

	<!-- 글쓰기 버튼과 검색 -->
	<div class="container mt-3">
		<div class="row">
			<div class="col-lg-3">
				<a href="PostCreationEditing.jsp" class="btn btn-primary">글쓰기</a>
			</div>
			<div class="col-lg-5">
				<%
				// 전체 게시물 수
				List<Post> Postcount = dbsqlPost.DBSelect(post);
				int total = 0;
				int itemsPerPage = 10; // 10개씩 끊어서 보기
				int currentPage = 1; // 기본 페이지 1

				// 사용자가 선택한 페이지 번호를 쿼리 매개변수로 전달
				String currentPageParam = request.getParameter("currentPage");
				System.out.println("currentPageParam: " + currentPageParam);
				if (currentPageParam != null && !currentPageParam.isEmpty()) {
					currentPage = Integer.parseInt(currentPageParam);
					System.out.println("currentPage: " + currentPage);
				}
				
				// total 계산하기 (댓글이 아닌 게시물만 세기)
			    for (Post postItem : Postcount) {
			        if (!postItem.getType().equals("댓글")) {
			            total++;
			        }
			    }
				System.out.println(total);
				%>
				<!-- 페이지 -->
				<ul class="pagination justify-content-center">
					<%
					// 이 부분은 반복문에서 i 변수를 정의합니다.
					%>
					<%
					for (int i = 1; i <= (int) Math.ceil((double) total / itemsPerPage); i++) {
					%>
					<li class="page-item <%=i == currentPage ? "active" : ""%>"><a
						class="page-link" href="#" id="page_<%=i%>"
						onclick="setpageNumber(<%=i%>)"><%=i%></a></li>
					<%
					}
					// 데이터베이스에서 게시물을 내림차순으로 가져오도록 쿼리 작성
					//List<Post> posts = dbsqlPost.DBSelectOrderedByDateDesc(post);

					// 현재 페이지에 해당하는 게시물들을 가져오는 로직

					int startIndex = (currentPage - 1) * itemsPerPage;
					int endIndex = Math.min(startIndex + itemsPerPage, total);

					for (int i = startIndex; i < endIndex; i++) {
					Post postItem = Postcount.get(i);
					}
					%>
					<li class="page-item"><a class="page-link" href="#" id="next">&raquo;</a></li>
				</ul>
			</div>
			<div class="col-lg-4">
				<div class="input-group">
					<div class="col-lg-2">
						<select class="form-control" id="postTypeSelect"
							onchange="setPostType(this.value)">
							<option value="전체" selected>전체</option>
							<option value="공지">공지</option>
							<option value="잡담">잡담</option>
							<option value="일정">일정</option>
						</select>
					</div>
					<div class="col-lg-3">
						<select class="form-control" id="postValueSelect">
							<option value="title" selected>제목</option>
							<option value="name">작성자</option>
						</select>
					</div>
					<input type="text" class="form-control" id="searchText"
						placeholder="검색어를 입력하세요">
					<button class="btn btn-secondary btnPostSearch" type="button"
						onclick="searchPosts(pageNumber)">검색</button>
				</div>
			</div>
		</div>
	</div>

	<script>
	var postType = ''; // 기본값은 빈 문자열
	var pageNumber = 1;
	 
    function setpageNumber(pageNum) {
    	pageNumber = pageNum;
    	console.log("pageNumber",pageNumber);
    	searchPosts(pageNumber);
    }
    
    function setPostType(value) {
		postType = value;
        console.log("setPostType",postType);
        searchPosts(pageNumber);
    }
	
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
    
    function searchPosts(pageNumber) {
    	var postValue = $("#postValueSelect").val();
		var searchText = $("#searchText").val();
		console.log("postValue",postValue);
		
		// 해당 페이지 번호를 클릭하면 active 클래스 설정
        $(".page-item").removeClass("active");
        $("#page_" + pageNumber).parent().addClass("active");
        
		// AJAX를 이용하여 서버에 검색 요청
		$.ajax({
			url: "Post.jsp",
			type: "POST",
			data: { postType: postType,
					postValue: postValue,
					searchText: searchText,
					currentPage: pageNumber,
					btnPostSearch: "true"
			},
			success: function(response) {
				// 성공시, 받은 응답으로 글 목록 업데이트
				$("#searchResultsContainer").html(response);
				$("#infoContainer").hide();
			},
			error: function(xhr, status, error) {
				// 필요한 경우 에러 처리
				console.error("검색 결과를 가져오는데 실패했습니다.");
				console.error(error);
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
    
 	// FullCalendar 라이브러리 초기화 및 설정
    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendar');

        var events = [];
        <%for (Calendar scheduleMember : SceduleMembers) {%>
            events.push({
                title: '<%=scheduleMember.getText()%>',
                start: '<%=scheduleMember.getStartdate()%>',
                end: '<%=scheduleMember.getEnddate()%>',
                postid: '<%=scheduleMember.getPostid()%>'
            });
        <%}%>

        var calendar = new FullCalendar.Calendar(calendarEl, {
            timeZone: 'UTC',
            locale: 'ko',
            initialView: 'dayGridMonth',
            events: events,
            eventClick: function(info) {
                var postid = info.event.extendedProps.postid;
                var link = document.querySelector('.btn-link[onclick*="' + postid + '"]');
                link.click();
            },
            editable: false
        });
        calendar.render();
    });
</script>
</body>
</html>