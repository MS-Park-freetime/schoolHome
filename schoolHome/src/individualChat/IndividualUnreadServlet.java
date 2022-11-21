package individualChat;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class IndividualUnreadServlet
 */
@WebServlet("/individualUnread")
public class IndividualUnreadServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IndividualUnreadServlet() {
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
		if(userID == null || userID.equals("")) {
			response.getWriter().write("0");
		}else {
			userID = URLDecoder.decode(userID, "UTF-8");
			HttpSession session = request.getSession();
			if(!URLDecoder.decode(userID, "UTF-8").equals((String)session.getAttribute("userID"))) {
				response.getWriter().write("");
				return;
			}
			response.getWriter().write(new IndividualDAO().getUnreadChat(userID) + "");
		}
		
	}

}
