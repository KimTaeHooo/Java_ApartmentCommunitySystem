package Login;

import java.io.IOException;
import java.lang.reflect.Method;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.Date;

import table.Tenant;


@WebServlet("/lc")
public class LoginController extends HttpServlet {
	LoginDAO dao = new LoginDAO();
	
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        
        String view = "";

        Method m = null;

        if (action == null) {
            action = "login";
            
        } 
        
        try {
        	switch (action) {
        	case "login":
                m = this.getClass().getMethod("login", HttpServletRequest.class);
                view = (String) m.invoke(this, req);
                break;
        	
        	case "logout":
                m = this.getClass().getMethod("logout", HttpServletRequest.class);
                view = (String) m.invoke(this, req);
                break;
        	}
        } catch (NoSuchMethodException e) {
            req.setAttribute("error", "존재하지 않는 액션 요청입니다!");
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (view.startsWith("redirect:")) {
            view = view.substring("redirect:".length());
            resp.sendRedirect(view);
        } else {
            RequestDispatcher rd = req.getRequestDispatcher(view);
            rd.forward(req, resp);
        }
    }

    public String login(HttpServletRequest req) {
        if (req.getMethod().equalsIgnoreCase("post")) {
            String id = req.getParameter("ID");
            String pass = req.getParameter("PW");
            

            HttpSession session = req.getSession(true);

            Tenant result = dao.login(id, pass);
            
            if (dao.isIdBlocked(id)) {
            
                session.setAttribute("error", "차단된 아이디입니다. 관리자에게 문의하세요.");
                return "/ACS/Login.jsp";
            }

            if (!result.getId().contains("Error")) {
            	Date getAccessiondate = result.getAccessiondate();
            	SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            	String accessiondateStr = dateFormat.format(getAccessiondate);
                session.setAttribute("result", "로그인에 성공했습니다.");
                
                session.setAttribute("loginuser", result);
                session.setAttribute("ID", result.getId()); //ID를 세션에 저장
                session.setAttribute("NAME", result.getName());  //이름을 세션에 저장
                session.setAttribute("RESIDENCE", result.getResidence()); //입주정보를 세션에 저장
                session.setAttribute("ACCESSIONDATE", accessiondateStr);
                System.out.println("1"+result+result.getId() + result.getPassword() + result.getName() + result.getResidence() + result.getAccessiondate()+ accessiondateStr);
                return "redirect:/Project/ACS/MainView.jsp";  //로그인 성공하면 메인뷰로 이동
            } else {
            	// "Error:-1" -> ["Error", "-1"]
            	int errorcode = Integer.parseInt(result.getId().split(":")[1]);   //에러코드는 split함수를 이용해 -1,-2,-3 경우 분리
            	switch (errorcode) {
            	case -1:
            		session.setAttribute("error", "아이디가 다릅니다.");
            		break;
            	case -2:
            		session.setAttribute("error", "아이디 or 비밀번호가 다릅니다.");
            		break;
            	case -3:
            		session.setAttribute("error", "데이터베이스에 정보가 확인이 안됨.");
            		break;
            	
            	}
            	// 로그인 실패 시 다시 로그인 화면으로 보여주되, 에러 메시지와 함께 보여줌
                return "/ACS/Login.jsp";
            }
        } else if (req.getMethod().equalsIgnoreCase("get")) {
        	return "/ACS?Login.jsp";
        }

            return "/ACS/Login.jsp";
    }
    
    

        /*public String logout(HttpServletRequest req) {
        	System.out.println("로그아웃 버튼을 클릭하고 이 함수가 실행이 되고있는거냐?");
            HttpSession session = req.getSession(true); // 새로 세션을 생성하도록 수정
            session.invalidate(); // 현재 세션 무효화
            
            return "/ACS/Login.jsp"; // 로그인 페이지로 리다이렉트
        }*/
    

    
    

}