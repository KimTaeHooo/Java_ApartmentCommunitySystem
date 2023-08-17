package dbsql;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import table.*;

public class Select extends DBSQL {

	public Select(String table) {
		super(table);
	}

	public List<Tenant> DBSelect(Tenant t) { // TenantComplet, TenantWait 테이블에 회원을 전부 Select하는 함수
		open(); // DB 연결
		List<Tenant> tenant = new ArrayList<>();
		String sql = "SELECT * FROM " + table; // sql 쿼리문
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) { // 데이터 베이스에서 가져온 데이터를 Tenant 객체에 할당
				t = new Tenant(); // 가져온 sql쿼리문에 관련된 객체 생성
				t.setId(rs.getString("id"));
				t.setName(rs.getString("name"));
				t.setPassword(rs.getString("password"));
				t.setAccessiondate(rs.getDate("accessiondate"));
				t.setResidence(rs.getString("residence"));

				tenant.add(t);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(); // DB 연결 해제
		}
		return tenant; // 객체에 추가 후 객체 리턴
	}

	public List<Tenant> DBSelect(Tenant t, int id) { // TenantComplet, TenantWait 테이블의 id에 해당하는 회원을 Select하는 함수
		open(); // DB 연결
		List<Tenant> tenant = new ArrayList<>();
		String sql = "SELECT * FROM " + table + " WHERE id=?"; // sql 쿼리문
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, id); // sql 쿼리문에 첫번째 ?에 해당하는 값 셋팅
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) { // 데이터 베이스에서 가져온 데이터를 Tenant 객체에 할당
				t = new Tenant(); // 가져온 sql쿼리문에 관련된 객체 생성
				t.setId(rs.getString("id"));
				t.setName(rs.getString("name"));
				t.setPassword(rs.getString("password"));
				t.setAccessiondate(rs.getDate("accessiondate"));
				t.setResidence(rs.getString("residence"));

				tenant.add(t);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(); // DB 연결 해제
		}
		return tenant; // 객체에 추가 후 객체 리턴
	}

	public List<Post> DBSelect(Post p) { // Post 테이블에 게시글을 전부 Select하는 함수
		open(); // DB 연결
		List<Post> post = new ArrayList<>();
		String sql = "SELECT * FROM " + table; // sql 쿼리문
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) { // 데이터 베이스에서 가져온 데이터를 Post 객체에 할당
				p = new Post(); // 가져온 sql쿼리문에 관련된 객체 생성
				p.setPostid(rs.getInt("postid"));
				p.setType(rs.getString("type"));
				p.setTitle(rs.getString("title"));
				p.setText(rs.getString("text"));
				p.setWritingdate(rs.getDate("writingdate"));
				p.setId(rs.getString("id"));
				p.setName(rs.getString("name"));
				p.setImg(rs.getString("img"));
				p.setViewsnum(rs.getInt("viewsnum"));

				post.add(p);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(); // DB 연결 해제
		}
		return post; // 객체에 추가 후 객체 리턴
	}

	public List<Post> DBSelect(Post p, int postid) { // Post 테이블의 postid에 해당하는 게시글을 Select하는 함수
		open(); // DB 연결
		List<Post> post = new ArrayList<>();
		String sql = "SELECT * FROM " + table + " WHERE postid=?"; // sql 쿼리문
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, postid); // sql 쿼리문에 첫번째 ?에 해당하는 값 셋팅
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) { // 데이터 베이스에서 가져온 데이터를 Post 객체에 할당
				p = new Post(); // 가져온 sql쿼리문에 관련된 객체 생성
				p.setPostid(rs.getInt("postid"));
				p.setType(rs.getString("type"));
				p.setTitle(rs.getString("title"));
				p.setText(rs.getString("text"));
				p.setWritingdate(rs.getDate("writingdate"));
				p.setId(rs.getString("id"));
				p.setName(rs.getString("name"));
				p.setImg(rs.getString("img"));
				p.setViewsnum(rs.getInt("viewsnum"));

				post.add(p);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(); // DB 연결 해제
		}
		return post; // 객체에 추가 후 객체 리턴
	}

	public List<Post> DBSelect(Post p, double postsPerPage) {
		open(); // DB 연결
		List<Post> post = new ArrayList<>();
		String sql = "SELECT * FROM post WHERE ROWNUM <= " + postsPerPage; // sql 쿼리문

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) { // 데이터 베이스에서 가져온 데이터를 Post 객체에 할당
				p = new Post(); // 가져온 sql쿼리문에 관련된 객체 생성
				p.setPostid(rs.getInt("postid"));
				p.setType(rs.getString("type"));
				p.setTitle(rs.getString("title"));
				p.setText(rs.getString("text"));
				p.setWritingdate(rs.getDate("writingdate"));
				p.setId(rs.getString("id"));
				p.setName(rs.getString("name"));
				p.setImg(rs.getString("img"));
				p.setViewsnum(rs.getInt("viewsnum"));

				post.add(p);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(); // DB 연결 해제
		}
		return post; // 객체에 추가 후 객체 리턴
	}

	public List<Post> DBSelect(Post p, String type) { // Post 테이블의 type에 해당하는 게시글을 Select하는 함수
		open(); // DB 연결
		List<Post> post = new ArrayList<>();
		String sql = "SELECT * FROM " + table + " WHERE type=?"; // sql 쿼리문
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, type); // sql 쿼리문에 첫번째 ?에 해당하는 값 셋팅
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) { // 데이터 베이스에서 가져온 데이터를 Post 객체에 할당
				p = new Post(); // 가져온 sql쿼리문에 관련된 객체 생성
				p.setPostid(rs.getInt("postid"));
				p.setType(rs.getString("type"));
				p.setTitle(rs.getString("title"));
				p.setText(rs.getString("text"));
				p.setWritingdate(rs.getDate("writingdate"));
				p.setId(rs.getString("id"));
				p.setName(rs.getString("name"));
				p.setImg(rs.getString("img"));
				p.setViewsnum(rs.getInt("viewsnum"));

				post.add(p);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(); // DB 연결 해제
		}
		return post; // 객체에 추가 후 객체 리턴
	}
	
	// Post 테이블에서 likeProperty값 중에 str가포함되어 있는 것을Select 하는 함수
	public List<Post> DBSelect(Post p, String likeProperty, String str) throws SQLException { 
		open(); // DB 연결
		List<Post> post = new ArrayList<>();
		String sql = "SELECT * FROM post WHERE " + likeProperty + " LIKE '%" + str + "%'";
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) { // 데이터 베이스에서 가져온 데이터를 TenantBan 객체에 할당
				p = new Post(); // 가져온 sql쿼리문에 관련된 객체 생성
				p.setPostid(rs.getInt("postid"));
				p.setType(rs.getString("type"));
				p.setTitle(rs.getString("title"));
				p.setText(rs.getString("text"));
				p.setWritingdate(rs.getDate("writingdate"));
				p.setId(rs.getString("id"));
				p.setName(rs.getString("name"));
				p.setImg(rs.getString("img"));
				p.setViewsnum(rs.getInt("viewsnum"));

				post.add(p);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(); // DB 연결 해제
		}
		return post; // 객체에 추가 후 객체 리턴
	}
	
	// Select 하는 함수
	public List<Post> DBSelect(Post p, String likeProperty, String str, String type) throws SQLException { 
		open(); // DB 연결
		List<Post> post = new ArrayList<>();
		String sql = "SELECT * FROM post WHERE " + likeProperty + " LIKE '%" + str + "%' AND type=" +"'"+ type+"'";
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) { // 데이터 베이스에서 가져온 데이터를 TenantBan 객체에 할당
				p = new Post(); // 가져온 sql쿼리문에 관련된 객체 생성
				p.setPostid(rs.getInt("postid"));
				p.setType(rs.getString("type"));
				p.setTitle(rs.getString("title"));
				p.setText(rs.getString("text"));
				p.setWritingdate(rs.getDate("writingdate"));
				p.setId(rs.getString("id"));
				p.setName(rs.getString("name"));
				p.setImg(rs.getString("img"));
				p.setViewsnum(rs.getInt("viewsnum"));

				post.add(p);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(); // DB 연결 해제
		}
		return post; // 객체에 추가 후 객체 리턴
	}

	public List<Calendar> DBSelect(Calendar c) { // Calendar 테이블에 일정을 전부 Select하는 함수
		open(); // DB 연결
		List<Calendar> Calendar = new ArrayList<>();
		String sql = "SELECT * FROM " + table; // sql 쿼리문
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) { // 데이터 베이스에서 가져온 데이터를 Calendar 객체에 할당
				c = new Calendar(); // 가져온 sql쿼리문에 관련된 객체 생성
				c.setCalid(rs.getInt("calid"));
				c.setStartdate(rs.getDate("startdate"));
				c.setEnddate(rs.getDate("enddate"));
				c.setText(rs.getString("text"));
				c.setPostid(rs.getInt("postid"));

				Calendar.add(c);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(); // DB 연결 해제
		}
		return Calendar; // 객체에 추가 후 객체 리턴
	}

	public List<Calendar> DBSelect(Calendar c, int calid) { // Calendar 테이블의 calid에 해당하는 일정을 Select하는 함수
		open(); // DB 연결
		List<Calendar> Calendar = new ArrayList<>();
		String sql = "SELECT * FROM " + table + " WHERE calid=?"; // sql 쿼리문
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			ResultSet rs = pstmt.executeQuery();
			pstmt.setInt(1, calid); // sql 쿼리문에 첫번째 ?에 해당하는 값 셋팅
			while (rs.next()) { // 데이터 베이스에서 가져온 데이터를 Calendar 객체에 할당
				c = new Calendar(); // 가져온 sql쿼리문에 관련된 객체 생성
				c.setCalid(rs.getInt("calid"));
				c.setStartdate(rs.getDate("startdate"));
				c.setEnddate(rs.getDate("enddate"));
				c.setText(rs.getString("text"));
				c.setPostid(rs.getInt("postid"));

				Calendar.add(c);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(); // DB 연결 해제
		}
		return Calendar; // 객체에 추가 후 객체 리턴
	}

	public List<TenantBan> DBSelect(TenantBan b) { // TenantBan 테이블에 차단 당한 회원을 전부 Select하는 함수
		open(); // DB 연결
		List<TenantBan> ban = new ArrayList<>();
		String sql = "SELECT * FROM " + table; // sql 쿼리문
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) { // 데이터 베이스에서 가져온 데이터를 TenantBan 객체에 할당
				b = new TenantBan(); // 가져온 sql쿼리문에 관련된 객체 생성
				b.setBanid(rs.getString("banid"));
				b.setBandate(rs.getDate("bandate"));

				ban.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(); // DB 연결 해제
		}
		return ban; // 객체에 추가 후 객체 리턴
	}

	public List<TenantBan> DBSelect(TenantBan b, String banid) { // TenantBan 테이블의 banid에 해당하는 차단 당한 회원을 Select하는 함수
		open(); // DB 연결
		List<TenantBan> ban = new ArrayList<>();
		String sql = "SELECT * FROM " + table + " WHERE banid=?"; // sql 쿼리문
		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			ResultSet rs = pstmt.executeQuery();
			pstmt.setString(1, banid); // sql 쿼리문에 첫번째 ?에 해당하는 값 셋팅
			while (rs.next()) { // 데이터 베이스에서 가져온 데이터를 TenantBan 객체에 할당
				b = new TenantBan(); // 가져온 sql쿼리문에 관련된 객체 생성
				b.setBanid(rs.getString("banid"));
				b.setBandate(rs.getDate("bandate"));

				ban.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(); // DB 연결 해제
		}
		return ban; // 객체에 추가 후 객체 리턴
	}
}
