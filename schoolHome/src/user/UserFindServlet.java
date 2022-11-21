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
@WebServlet("/userFind")
public class UserFindServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserFindServlet() {
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
		
		if(userID == null || userID.equals("")){
			response.getWriter().write("-2");
		}else if(new GuestDAO().registerCheck(userID) == 0) {
			try {
				response.getWriter().write(find(userID));
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				response.getWriter().write("-1");
			}
		}else {
			response.getWriter().write("-1");
		}
	}
	
	public String find(String userID) throws Exception{
		StringBuffer result = new StringBuffer("");
		result.append("{\"userProfile\":\"" + new GuestDAO().getProfile(userID) + "\"}");
		return result.toString();
	}

}
