package Login;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/Project/checkDuplicate") // 서블릿 매핑
public class CheckDuplicateServlet extends HttpServlet {
    final String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
    final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521:xe";
    Connection conn = null;

    // 서블릿 초기화 시에 데이터베이스 연결을 열어줍니다.
    @Override
    public void init() throws ServletException {
        open();
    }

    // 서블릿 종료 시에 데이터베이스 연결을 닫아줍니다.
    @Override
    public void destroy() {
        close();
    }

    public void open() {
        try {
            Class.forName(JDBC_DRIVER);
            conn = DriverManager.getConnection(JDBC_URL, "hr", "hr");
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public void close() {
        try {
            if (conn != null) {
                conn.close();
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String idToCheck = request.getParameter("id");
        boolean exists = checkDuplicate(idToCheck);

        // JSON 응답 반환
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.getWriter().write("{\"exists\": " + exists + "}");
    }

    private boolean checkDuplicate(String id) {
        boolean exists = false;

        try {
            // "TENANTCOMPLET" 테이블에서 "ID" 컬럼으로 중복 확인합니다.
            String query = "SELECT id FROM TENANTCOMPLET WHERE ID = ?";
            PreparedStatement pstmt = conn.prepareStatement(query);
            pstmt.setString(1, id);
            ResultSet resultSet = pstmt.executeQuery();
            
            exists = resultSet.next();  //결과가 존재하는지 여부를 판단


            resultSet.close();
            pstmt.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return exists;
    }
}