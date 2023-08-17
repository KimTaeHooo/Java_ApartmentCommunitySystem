<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.Date"%>
<%@ page import="dbsql.*"%>
<%@ page import="table.*"%>
<%@ page import="java.util.Calendar"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원</title>
</head>
<body>
<%-- Java 코드 작성 (스크립트릿) --%>
<%
    // 클라이언트로부터 전송된 데이터 받기
    String btnRequest = request.getParameter("btnRequest");
    String btnAccept = request.getParameter("btnAccept");
	String btnTemporary = request.getParameter("btnTemporary");
	String btnPermanently = request.getParameter("btnPermanently");
    String id = request.getParameter("id");
    String name = request.getParameter("name");
    String password = request.getParameter("password");
    Date accessiondate = Date.valueOf(request.getParameter("accessiondate"));
    String residence = request.getParameter("residence");
    
    // 요청 파라미터에서 confirm 값을 확인하여 데이터 삽입 여부를 결정
    if (btnRequest != null && btnRequest.equals("true")) {
        // DBSQL 객체 생성
        Tenant tenant = new Tenant();
        Insert dbsql = new Insert("TenantWait");
        tenant.setId(id);
        tenant.setName(name);
        tenant.setPassword(password);
        tenant.setAccessiondate(accessiondate);
        tenant.setResidence(residence);

        // 데이터를 삽입합니다.
        dbsql.DBInsert(tenant);

        // Send the response to the Eclipse console using JSP's 'out' object
        out.println("요청이 성공적으로 처리되었습니다.");
        out.println("서버 응답: " + "데이터가 성공적으로 저장되었습니다."); // You can customize this message as needed
    }
    
    if (btnAccept != null && btnAccept.equals("true")) {
        // DBSQL 객체 생성
        Tenant tenant = new Tenant();
        Insert dbsqlInsert = new Insert("TenantComplet");
        tenant.setId(id);
        tenant.setName(name);
        tenant.setPassword(password);
        tenant.setAccessiondate(accessiondate);
        tenant.setResidence(residence);

        // 데이터를 삽입합니다.
        dbsqlInsert.DBInsert(tenant);

        // Send the response to the Eclipse console using JSP's 'out' object
        out.println("요청이 성공적으로 처리되었습니다.");
        out.println("서버 응답: " + "데이터가 성공적으로 저장되었습니다."); // You can customize this message as needed
        
        // 성공적으로 테이블 삽입 후에 기존에 있던 테이블에서 정보 삭제

        Delete deletedbsql = new Delete("TenantWait");
        
        // 데이터 삭제
        deletedbsql.DBDelete(tenant, id);
    }
    
    if (btnTemporary != null && btnTemporary.equals("true")) {
    	Calendar cal = Calendar.getInstance(); // 현재 날짜와 시간을 가진 캘린더 인스턴스 생성
    	cal.add(Calendar.DATE, 3); // 현재 날짜에 3일 더하기

    	Date sqlDate = new Date(cal.getTimeInMillis()); // java.sql.Date 객체 생성
    	
        // DBSQL 객체 생성
        TenantBan tenant = new TenantBan();
        Insert dbsql = new Insert("TenantBan");
        tenant.setBanid(id);
        tenant.setBandate(sqlDate);

        // 데이터를 삽입합니다.
        dbsql.DBInsert(tenant);

        // Send the response to the Eclipse console using JSP's 'out' object
        out.println("요청이 성공적으로 처리되었습니다.");
        out.println("서버 응답: " + "데이터가 성공적으로 저장되었습니다."); // You can customize this message as needed
    }
    
    if (btnPermanently != null && btnPermanently.equals("true")) {
    	Calendar cal = Calendar.getInstance(); // 현재 날짜와 시간을 가진 캘린더 인스턴스 생성
    	cal.add(Calendar.DATE, 99999); // 현재 날짜에 99999일 더하기

    	Date sqlDate = new Date(cal.getTimeInMillis()); // java.sql.Date 객체 생성
    	
        // DBSQL 객체 생성
        TenantBan tenant = new TenantBan();
        Insert dbsql = new Insert("TenantBan");
        tenant.setBanid(id);
        tenant.setBandate(sqlDate);

        // 데이터를 삽입합니다.
        dbsql.DBInsert(tenant);

        // Send the response to the Eclipse console using JSP's 'out' object
        out.println("요청이 성공적으로 처리되었습니다.");
        out.println("서버 응답: " + "데이터가 성공적으로 저장되었습니다."); // You can customize this message as needed
    }
%>
</body>
</html>