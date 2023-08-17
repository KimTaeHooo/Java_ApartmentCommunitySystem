<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보</title>
</head>
<body>
	<h2>회원정보</h2>[<a href="/Project/complet">새로고침</a>]
	<hr>
	<table border="1">
		<a>TenanComplet 테이블</a>
		<tr><th>아이디</th><th>이름</th><th>비밀번호</th><th>가입일</th><th>거주지</th></tr>
		<c:forEach items="${complets}" var="s">
			<tr>
				<td>${s.id}</td> <td>${s.name}</td> <td>${s.password}</td>
				<td>${s.accessiondate}</td> <td>${s.residence}</td>
				<td><a href="/Project/complet?action=deletecomplet&id=${s.id}"><span
						class="badgebg-secoundary"> &times;</span></a></td>
			</tr>
		</c:forEach>
	</table>
	<table border="1">
		<a>TenanWait 테이블</a>
		<tr><th>아이디</th><th>이름</th><th>비밀번호</th><th>가입일</th><th>거주지</th></tr>
		<c:forEach items="${waits}" var="s">
			<tr>
				<td>${s.id}</td> <td>${s.name}</td> <td>${s.password}</td>
				<td>${s.accessiondate}</td> <td>${s.residence}</td>
				<td><a href="/Project/wait?action=deletewait&id=${s.id}">
				<span class="badgebg-secoundary"> &times;</span></a></td>
			</tr>
		</c:forEach>
	</table>
	<table border="1">
		<a>TenanBan 테이블</a>
		<tr><th>아이디</th>
		<c:forEach items="${bans}" var="s">
			<tr>
				<td>${s.banid}</td>
				<td><a href="/Project/wait?action=deleteban&id=${s.banid}">
				<span class="badgebg-secoundary"> &times;</span></a></td>
			</tr>
		</c:forEach>
	</table>
	<table border="1">
		<a>Post 테이블</a>
		<tr><th>게시글 번호</th><th>타입</th><th>게시글 제목</th><th>게시글 내용</th><th>작성일자</th><th>작성자</th><th>사진</th><th>조회수</th></tr>
		<c:forEach items="${posts}" var="s">
			<tr>
				<td>${s.postid}</td> <td>${s.type}</td> <td>${s.title}</td>
				<td>${s.text}</td> <td>${s.writingdate}</td> <td>${s.name}</td>
				<td>${s.img}</td> <td>${s.viewsnum}</td>
				<td><a href="/Project/wait?action=deletepost&id=${s.postid}">
				<span class="badgebg-secoundary"> &times;</span></a></td>
			</tr>
		</c:forEach>
	</table>
	<table border="1">
		<a>Calender 테이블</a>
		<tr><th>일정 번호</th><th>일정 날짜</th><th>일정 내용</th><th>게시글 번호</th></tr>
		<c:forEach items="${calenders}" var="s">
			<tr>
				<td>${s.calid}</td> <td>${s.cdate}</td> <td>${s.text}</td>
				<td>${s.postid}</td>
				<td><a href="/Project/wait?action=deletecalender&id=${s.calid}">
				<span class="badgebg-secoundary"> &times;</span></a></td>
			</tr>
		</c:forEach>
	</table>
	<h2>정보 추가</h2>
	<hr>
	<form method="post" action="/Project/complet?action=insertcomplet">
		<label>TenanComplet 테이블 삽입</label><br>
		<label>아이디</label> <input type="text" name="id"><br>
		<label>이름</label> <input type="text" name="name"><br>
		<label>비밀번호</label> <input type="text" name="password"><br>
		<label>가입일</label> <input type="text" name="accessiondate"><br>
		<label>거주지</label> <input type="text" name="residence"><br>
		<button type="submit">등록</button>
	</form>
	
	<form method="post" action="/Project/complet?action=insertwait">
		<label>TenanWait 테이블 삽입</label><br>
		<label>아이디</label> <input type="text" name="id"><br>
		<label>이름</label> <input type="text" name="name"><br>
		<label>비밀번호</label> <input type="text" name="password"><br>
		<label>가입일</label> <input type="text" name="accessiondate"><br>
		<label>거주지</label> <input type="text" name="residence"><br>
		<button type="submit">등록</button>
	</form>
	
	<form method="post" action="/Project/complet?action=insertwait">
		<label>TenanWait 테이블 삽입</label><br>
		<label>아이디</label> <input type="text" name="id"><br>
		<label>이름</label> <input type="text" name="name"><br>
		<label>비밀번호</label> <input type="text" name="password"><br>
		<label>가입일</label> <input type="text" name="accessiondate"><br>
		<label>거주지</label> <input type="text" name="residence"><br>
		<button type="submit">등록</button>
	</form>
	
	<form method="post" action="/Project/complet?action=insertwait">
		<label>TenanWait 테이블 삽입</label><br>
		<label>아이디</label> <input type="text" name="id"><br>
		<label>이름</label> <input type="text" name="name"><br>
		<label>비밀번호</label> <input type="text" name="password"><br>
		<label>가입일</label> <input type="text" name="accessiondate"><br>
		<label>거주지</label> <input type="text" name="residence"><br>
		<button type="submit">등록</button>
	</form>
	
	<form method="post" action="/Project/complet?action=insertwait">
		<label>TenanWait 테이블 삽입</label><br>
		<label>아이디</label> <input type="text" name="id"><br>
		<label>이름</label> <input type="text" name="name"><br>
		<label>비밀번호</label> <input type="text" name="password"><br>
		<label>가입일</label> <input type="text" name="accessiondate"><br>
		<label>거주지</label> <input type="text" name="residence"><br>
		<button type="submit">등록</button>
	</form>
</body>
</html>