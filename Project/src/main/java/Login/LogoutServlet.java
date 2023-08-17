package Login;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		String view = "";
		if (action == null) {
			getServletContext().getRequestDispatcher("/logout?action=logout").forward(request, response);
		} else {
			switch (action) {
			case "logout":
				view = logout(request, response);
				break;
			}
			getServletContext().getRequestDispatcher("/ACS/" + view).forward(request, response);
		}
	}

	private String logout(HttpServletRequest request, HttpServletResponse response) {
		// 세션을 가져온 후 무효화
		HttpSession session = request.getSession();
		session.invalidate();

		return "Login.jsp";
	}
}
