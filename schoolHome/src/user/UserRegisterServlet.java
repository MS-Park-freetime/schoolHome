package user;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import util.SHA256;

/**
 * Servlet implementation class UserRegisterServlet
 */
@WebServlet("/userRegister")
public class UserRegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserRegisterServlet() {
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
		String userPassword = request.getParameter("userPassword");
		String userPassword1 = request.getParameter("userPassword1");
		String userName = request.getParameter("userName");
		String userAge = request.getParameter("userAge");
		String userGender = request.getParameter("userGender");
		String userEmail = request.getParameter("userEmail");
		String userEmailHash = request.getParameter("userEmailHash");
		String userEmailChecked = request.getParameter("userEmailChecked");
		String userProfile = request.getParameter("userProfile");
		
		if(userID == null || userPassword == null || userPassword1 == null || userName == null ||
				userGender == null || userEmail == null || userAge == null || userID.equals("") || userEmail.equals("") || userPassword.equals("")
				|| userPassword1.equals("") || userName.equals("") || userAge.equals("")){
			request.getSession().setAttribute("messageType", "오류메세지");
			request.getSession().setAttribute("messageContent", "모든 내용을 입력하세요.");
			response.sendRedirect("login/ajaxLogin.jsp");
			return;
		}
		if(!userPassword.equals(userPassword1)) {
			request.getSession().setAttribute("messageType", "오류메세지");
			request.getSession().setAttribute("messageContent", "비밀번호가 일치하지 않습니다.");
			response.sendRedirect("login/ajaxLogin.jsp");
			return;
		}
		
		GuestDAO guestDAO = new GuestDAO();
		int result1 = guestDAO.registerCheck(userID);
		if(result1 != 1){
			request.getSession().setAttribute("messageType", "오류메세지");
			request.getSession().setAttribute("messageContent", "아이디 중복확인을 해주세요.");
			response.sendRedirect("login/ajaxLogin.jsp");
			return;
			/*PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('아이디 중복확인을 해주세요.')");
			script.println("history.back();");
			script.println("</script>");
			script.close();*/
		}else {
			int result = new GuestDAO().register(userID, userPassword, userName, userAge, userGender, userEmail, SHA256.getSHA256(userEmail), "FALSE", userProfile);
			if(result == -1) {
				request.getSession().setAttribute("messageType", "오류메세지");
				request.getSession().setAttribute("messageContent", "이미 존재하는 회원입니다.");
				response.sendRedirect("login/ajaxLogin.jsp");
				return;
			}else {
				request.getSession().setAttribute("userID", userID);
				request.getSession().setAttribute("messageType", "성공메세지");
				request.getSession().setAttribute("messageContent", "이메일 인증을 진행해 주세요.");
				response.sendRedirect("login/emailSendAction.jsp");
				return;
			}
		}

	}

}
