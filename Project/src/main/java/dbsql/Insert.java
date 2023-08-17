package dbsql;

import java.sql.PreparedStatement;

import table.*;

public class Insert extends DBSQL {
	public Insert(String table) {
		super(table);
	}

	public void DBInsert(Tenant t) { // TenantComplet, TenantWait 테이블에 회원 정보를 삽입하는 함수
		open(); // DB 연결
		// sql 쿼리문
		String sql = "INSERT INTO " + table + "(ID, NAME, PASSWORD, ACCESSIONDATE, RESIDENCE) VALUES(?, ?, ?, ?, ?)";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, t.getId()); // sql 쿼리문에 id에 해당하는 값 셋팅
			pstmt.setString(2, t.getName()); // sql 쿼리문에 name에 해당하는 값 셋팅
			pstmt.setString(3, t.getPassword()); // sql 쿼리문에 password에 해당하는 값 셋팅
			pstmt.setDate(4, t.getAccessiondate()); // sql 쿼리문에 accessiondate에 해당하는 값 셋팅
			pstmt.setString(5, t.getResidence()); // sql 쿼리문에 residence에 해당하는 값 셋팅

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(); // DB 연결 해제
		}
	}

	public void DBInsert(Post p) { // Post 테이블에 게시글 정보를 삽입하는 함수
		open(); // DB 연결
		// sql 쿼리문 (postid는 시퀀스로 1씩증가 POSTID_SEQ.NEXTVAL)
		String sql = "INSERT INTO " + table
				+ "(postid, type, title, text, writingdate, id, name, img, viewsnum) VALUES (POSTID_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?, ?)";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, p.getType()); // sql 쿼리문에 type에 해당하는 값 셋팅
			pstmt.setString(2, p.getTitle()); // sql 쿼리문에 title에 해당하는 값 셋팅
			pstmt.setString(3, p.getText()); // sql 쿼리문에 text에 해당하는 값 셋팅
			pstmt.setDate(4, p.getWritingdate()); // sql 쿼리문에 writingdate에 해당하는 값 셋팅
			pstmt.setString(5, p.getId()); // sql 쿼리문에 id에 해당하는 값 셋팅
			pstmt.setString(6, p.getName()); // sql 쿼리문에 name에 해당하는 값 셋팅
			pstmt.setString(7, p.getImg()); // sql 쿼리문에 img에 해당하는 값 셋팅
			pstmt.setInt(8, p.getViewsnum()); // sql 쿼리문에 viewsnum에 해당하는 값 셋팅

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	public void DBInsert(Calendar c) { // Calendar 테이블에 일정 정보를 삽입하는 함수
		open(); // DB 연결
		// sql 쿼리문
		String sql = "INSERT INTO " + table + "(calid, startdate, enddate, text, postid) VALUES (CALID_SEQ.NEXTVAL, ?, ?, ?, POSTID_SEQ.NEXTVAL - 1)";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setDate(1, c.getStartdate()); // sql 쿼리문에 cdate에 해당하는 값 셋팅
			pstmt.setDate(2, c.getEnddate()); // sql 쿼리문에 cdate에 해당하는 값 셋팅
			pstmt.setString(3, c.getText()); // sql 쿼리문에 text에 해당하는 값 셋팅

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	public void DBInsert(TenantBan b) { // TenantBan 테이블에 차단 당한 회원의 정보를 삽입하는 함수
		open(); // DB 연결
		String sql = "INSERT INTO " + table + "(banid, bandate) VALUES (?, ?)"; // sql 쿼리문

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, b.getBanid()); // sql 쿼리문에 banid에 해당하는 값 셋팅
			pstmt.setDate(2, b.getBandate()); // sql 쿼리문에 bandate에 해당하는 값 셋팅

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(); // DB 연결 해제
		}
	}

}
