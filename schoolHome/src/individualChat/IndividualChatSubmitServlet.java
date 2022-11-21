package individualChat;

import java.io.IOException;
import java.net.URLDecoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import individualChat.IndividualDAO;

/**
 * Servlet implementation class ChatSubmitServlet
 */
@WebServlet("/individualChatSubmit")
public class IndividualChatSubmitServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IndividualChatSubmitServlet() {
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
		String fromID = request.getParameter("fromID");
		String toID = request.getParameter("toID");
		String individualContent = request.getParameter("individualContent");
		if(
			individualContent == null || individualContent.equals("")) {
			response.getWriter().write("0");
		}else if(fromID.equals(toID)) {
			response.getWriter().write("-1");
		}else {
			fromID = URLDecoder.decode(fromID, "UTF-8");
			toID = URLDecoder.decode(toID, "UTF-8");
			HttpSession session = request.getSession();
			if(!URLDecoder.decode(fromID, "UTF-8").equals((String)session.getAttribute("userID"))) {
				response.getWriter().write("");
				return;
			}
			individualContent = URLDecoder.decode(individualContent, "UTF-8");
			response.getWriter().write(new IndividualDAO().submit(fromID, toID, individualContent) + "");
		}
	
	
	}

}
