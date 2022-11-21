package user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.SHA256;

/**
 * Servlet implementation class UserRegisterServlet
 */
@WebServlet("/userInfoUpdate")
public class UserInfoUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserInfoUpdateServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html;charset=UTF-8");
		String userID = request.getParameter("userID");
		HttpSession session = request.getSession();
		if(!userID.equals((String)session.getAttribute("userID"))) {
			session.setAttribute("messageType", "오류메세지");
			session.setAttribute("messageContent", "접근할 수 없습니다.");
			response.sendRedirect("index.jsp");
			return;
		}
		String userPassword = request.getParameter("userPassword");
		String userPassword1 = request.getParameter("userPassword1");
		String userName = request.getParameter("userName");
		int userAge = Integer.parseInt(request.getParameter("userAge"));
		String userGender = request.getParameter("userGender");
		String userEmail = request.getParameter("userEmail");
		
		if(userID == null || userPassword == null || userPassword1 == null || userName == null ||
				userGender == null || userEmail == null || userID.equals("") || userEmail.equals("") || userPassword.equals("")
				|| userPassword1.equals("") || userName.equals("")){
			request.getSession().setAttribute("messageType", "오류메세지");
			request.getSession().setAttribute("messageContent", "모든 내용을 입력하세요.");
			response.sendRedirect("info/info.jsp");
			return;
		}
		if(!userPassword.equals(userPassword1)) {
			request.getSession().setAttribute("messageType", "오류메세지");
			request.getSession().setAttribute("messageContent", "비밀번호가 일치하지 않습니다.");
			response.sendRedirect("info/info.jsp");
			return;
		}
			int result = new GuestDAO().infoUpdate(userID, userPassword, userName, userAge, userGender, userEmail);
			if(result == -1) {
				request.getSession().setAttribute("messageType", "오류메세지");
				request.getSession().setAttribute("messageContent", "오류입니다.");
				response.sendRedirect("info/info.jsp");
				return;
			}else {
				request.getSession().setAttribute("userID", userID);
				request.getSession().setAttribute("messageType", "성공메세지");
				request.getSession().setAttribute("messageContent", "회원 정보 수정에 성공하였습니다.");
				response.sendRedirect("index.jsp");
				return;
			}

	}

}
