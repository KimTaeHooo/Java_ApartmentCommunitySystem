package dbsql;

import java.sql.PreparedStatement;

import table.*;

public class Update extends DBSQL {
	public Update(String table) {
		super(table);
	}

	public void DBUpdate(Tenant t) { // TenantComplet, TenantWait 테이블에 회원 정보를 수정하는 함수
		open(); // DB 연결
		// sql 쿼리문
		String sql = "UPDATE " + table + " SET id=?, name=?, password=?, accessiondate=?, residence=?";

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
			close();
		}
	}

	public void DBUpdate(Post p, int id) { // Post 테이블에 회원 정보를 수정하는 함수
		open(); // DB 연결
		// sql 쿼리문
		String sql = "UPDATE " + table
				+ " SET type=?, title=?, text=?, writingdate=?, id=?, name=?, img=?, viewsnum=? WHERE postid=?";
		
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, p.getType()); // sql 쿼리문에 type에 해당하는 값 셋팅
			pstmt.setString(2, p.getTitle()); // sql 쿼리문에 title에 해당하는 값 셋팅
			pstmt.setString(3, p.getText()); // sql 쿼리문에 text에 해당하는 값 셋팅
			pstmt.setDate(4, p.getWritingdate()); // sql 쿼리문에 writingdate에 해당하는 값 셋팅
			pstmt.setString(5, p.getId()); // sql 쿼리문에 id에 해당하는 값 셋팅
			pstmt.setString(6, p.getName()); // sql 쿼리문에 name에 해당하는 값 셋팅
			pstmt.setString(7, p.getImg()); // sql 쿼리문에 img에 해당하는 값 셋팅
			pstmt.setInt(8, p.getViewsnum()); // sql 쿼리문에 viewsnum에 해당하는 값 셋팅
			pstmt.setInt(9, id); // sql 쿼리문에 postid에 해당하는 값 셋팅

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(); // DB 연결 해제
		}
	}

	public void DBUpdate(Post p, int id, int viewsnum) { // Post 테이블에 게시글 정보를 수정하는 함수(게시글 조회수 증가에 사용)
		open();
		String sql = "UPDATE " + table + " SET viewsnum=? WHERE postid=?"; // sql 쿼리문

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, viewsnum + 1); // sql 쿼리문에 viewsnum에 해당하는 값 셋팅
			pstmt.setInt(2, id); // sql 쿼리문에 postid에 해당하는 값 셋팅

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(); // DB 연결 해제
		}
	}

	public void DBUpdate(Calendar c) { // Calendar 테이블에 일정 정보를 수정하는 함수
		open(); // DB 연결
		// sql 쿼리문
		String sql = "UPDATE " + table + " SET calid=?, startdate=?, enddate=?, text=?, postid=?";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, c.getCalid()); // sql 쿼리문에 calid에 해당하는 값 셋팅
			pstmt.setDate(2, c.getStartdate()); // sql 쿼리문에 cdate에 해당하는 값 셋팅
			pstmt.setDate(3, c.getEnddate()); // sql 쿼리문에 cdate에 해당하는 값 셋팅
			pstmt.setString(4, c.getText()); // sql 쿼리문에 text에 해당하는 값 셋팅
			pstmt.setInt(5, c.getPostid()); // sql 쿼리문에 postid에 해당하는 값 셋팅

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	public void DBUpdate(TenantBan b) { // TenantBan 테이블에 차단 당한 회원의 정보를 수정하는 함수
		open(); // DB 연결
		// sql 쿼리문
		String sql = "UPDATE " + table + " SET banid=?, bandate=?";

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