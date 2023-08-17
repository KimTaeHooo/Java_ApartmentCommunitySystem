package dbsql;

import java.sql.PreparedStatement;

import table.*;

public class Delete extends DBSQL{
	public Delete(String table) {
		super(table);
	}
	
	public void DBDelete(Tenant t, String id) { // TenantComplet, TenantWait 테이블에 id에 해당하는 회원 정보를 삭제하는 함수
		open(); // DB 연결
		String sql = "DELETE FROM " + table + " WHERE id = ?"; // sql 쿼리문 

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, id); // sql 쿼리문에 첫번째 ?에 해당하는 값 셋팅 

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(); // DB 연결 해제
		}
	}

	public void DBDelete(Post p, int postid) { // Post 테이블에 psotid에 해당하는 게시글 정보를 삭제하는 함수
		open(); // DB 연결
		String sql = "DELETE FROM " + table + " WHERE postid = ?"; // sql 쿼리문 

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, postid); // sql 쿼리문에 첫번째 ?에 해당하는 값 셋팅 

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(); // DB 연결 해제
		}
	}

	public void DBDelete(Calendar c, int calid) { // Calendar 테이블에 calid에 해당하는 일정 정보를 삭제하는 함수
		open(); // DB 연결
		String sql = "DELETE FROM " + table + " WHERE calid = ?"; // sql 쿼리문 

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, calid); // sql 쿼리문에 첫번째 ?에 해당하는 값 셋팅 

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(); // DB 연결 해제
		} 
	}

	public void DBDelete(TenantBan b, String banid) { // TenantBan 테이블에 banid에 해당하는 차단 당한 회원 정보를 삭제하는 함수
		open();
		String sql = "DELETE FROM " + table + " WHERE banid = ?"; // sql 쿼리문 

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, banid); // sql 쿼리문에 첫번째 ?에 해당하는 값 셋팅 

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(); // DB 연결 해제
		}
	}
}
