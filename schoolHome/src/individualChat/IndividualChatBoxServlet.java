package individualChat;

import java.io.IOException;
import java.net.URLDecoder;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class IndividualChatBoxServlet
 */
@WebServlet("/individualChatBox")
public class IndividualChatBoxServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IndividualChatBoxServlet() {
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
			response.getWriter().write("");
		}else {
			try {
				HttpSession session = request.getSession();
				if(!URLDecoder.decode(userID, "UTF-8").equals((String)session.getAttribute("userID"))) {
					response.getWriter().write("");
					return;
				}
				userID = URLDecoder.decode(userID, "UTF-8");
				response.getWriter().write(getBox(userID));
			} catch (Exception e) {
				// TODO: handle exception
				response.getWriter().write("");
			}
		}
	}
	
	public String getBox(String userID) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		IndividualDAO individualDAO = new IndividualDAO();
		ArrayList<IndividualDTO> individualList = individualDAO.getIndividualChattingBox(userID);
		if(individualList.size() == 0) {
			return "";
		}
		for(int i = individualList.size() - 1; i >= 0; i--) {
			String unread = "";
			if(userID.equals(individualList.get(i).getToID())) {
				unread = individualDAO.getUnreadChatCount(individualList.get(i).getFromID(), userID) + "";
				if(unread.equals("0")){
					unread = "";
				}
						
			}
			result.append("[{\"value\": \"" + individualList.get(i).getFromID() + "\"},");
			result.append("{\"value\": \"" + individualList.get(i).getToID() + "\"},");
			result.append("{\"value\": \"" + individualList.get(i).getIndividualContent() + "\"},");
			result.append("{\"value\": \"" + individualList.get(i).getIndividualTIme() + "\"},");
			result.append("{\"value\": \"" + unread + "\"}]");
			if(i != 0) {
				result.append(",");
			}
		}
		result.append("], \"last\":\"" + individualList.get(individualList.size() - 1).getIndividualID() + "\"}");
		return result.toString();
 	}
}
