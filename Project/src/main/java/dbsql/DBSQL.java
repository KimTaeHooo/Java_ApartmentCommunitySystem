package dbsql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class DBSQL {
	String table;
	Connection conn = null;
	PreparedStatement pstmt;

	// 오라클 드라이버 설정
	final String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
	final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521:xe";

	public DBSQL(String table) { // 생성자
		this.table = table.toUpperCase();
	}

	public void open() { // DB 연결 연결
		try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(JDBC_URL, "hr", "hr"); // hr 로 접속
		} catch (Exception e) { // DB 연결 중 오류가 나면 
			e.printStackTrace();
		}
	}

	public void close() { // DB 연결 해제
		try {
			if (pstmt != null) {
				pstmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		} catch (Exception e) { // DB 연결 해제 중 오류가 나면 
			e.printStackTrace();
		}
	}
}