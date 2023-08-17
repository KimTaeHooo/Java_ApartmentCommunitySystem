<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.Date"%>
<%@ page import="dbsql.*"%>
<%@page import="table.*"%>
<%@ page import="java.util.List"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>달력</title>
</head>
<body>
	<%-- Java 코드 작성 (스크립트릿) --%>
	<%
	String btnCalendarInsert = request.getParameter("btnCalendarInsert");
	String btnCalendarDelete = request.getParameter("btnCalendarDelete");
	String btnCalendarUpdate = request.getParameter("btnCalendarUpdate");
	
	// 관리자가 일정 추가
	if (btnCalendarInsert != null && btnCalendarInsert.equals("true")) {
		Date startdate = Date.valueOf(request.getParameter("startdate"));
		Date enddate = Date.valueOf(request.getParameter("enddate"));
		String postTitle = request.getParameter("postTitle");
		String postImg = request.getParameter("postImg");
		// DBSQL 객체 생성
		Calendar calendar = new Calendar();
		Post post = new Post();
		
		String id = (String) session.getAttribute("ID");
		String name = (String) session.getAttribute("NAME");
		// Post 데이터를 삽입합니다.
		Insert insertpost = new Insert("Post");
		
		post.setType("일정");
		post.setTitle(postTitle);
		post.setWritingdate(new Date(System.currentTimeMillis()));
		post.setId(id);
		post.setName(name);
		post.setImg(postImg);
		post.setViewsnum(0);
		
		insertpost.DBInsert(post);
		// Calendar 데이터를 삽입합니다.
		Insert insertcal = new Insert("Calendar");
		
		calendar.setStartdate(startdate);
		calendar.setEnddate(enddate);
		calendar.setText(postTitle);
		
		insertcal.DBInsert(calendar);

		out.println("요청이 성공적으로 처리되었습니다.");
		out.println("서버 응답: " + "데이터가 성공적으로 저장되었습니다."); 
	}

	// 관리자가 일정 삭제
	if (btnCalendarDelete != null && btnCalendarDelete.equals("true")) {
		int calid = Integer.parseInt(request.getParameter("calid"));
		int postid = Integer.parseInt(request.getParameter("postid"));
		// Calendar 데이터를 삭제합니다.
		// DBSQL 객체 생성
		Calendar calendar = new Calendar();
		Delete dbsqlcal = new Delete("Calendar");

		dbsqlcal.DBDelete(calendar, calid);
		
		// Post 데이터를 삭제합니다.
		// DBSQL 객체 생성
		Post post = new Post();
		Delete dbsqlpost = new Delete("Post");
		dbsqlpost.DBDelete(post, postid);

		out.println("요청이 성공적으로 처리되었습니다.");
		out.println("서버 응답: " + "데이터가 성공적으로 저장되었습니다."); 
	}
	%>
</body>
</html>