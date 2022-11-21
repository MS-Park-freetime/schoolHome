package individualChat;

import java.io.IOException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class ChatSubmitServlet
 */
@WebServlet("/individualList")
public class IndividualListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public IndividualListServlet() {
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
		String listType = request.getParameter("listType");
		if(fromID == null || fromID.equals("") || toID == null || toID.equals("") || listType == null || listType.equals("")) {
			response.getWriter().write("");
		}else if(listType.equals("ten")) {
			response.getWriter().write(getTen(URLDecoder.decode(fromID, "UTF-8"), URLDecoder.decode(toID, "UTF-8")));
		}else {
			try {
				HttpSession session = request.getSession();
				if(!URLDecoder.decode(fromID, "UTF-8").equals((String)session.getAttribute("userID"))) {
					response.getWriter().write("");
					return;
				}
				Integer.parseInt(listType);
				response.getWriter().write(getID(URLDecoder.decode(fromID, "UTF-8"), URLDecoder.decode(toID, "UTF-8"), listType));
			} catch (Exception e) {
				// TODO: handle exception
				response.getWriter().write("");
			}
		}
	
	}
	
	public String getTen(String fromID, String toID) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		IndividualDAO individualDAO = new IndividualDAO();
		ArrayList<IndividualDTO> individualList = individualDAO.getChatListByRecent(fromID, toID, 100);
		if(individualList.size() == 0) {
			return "";
		}
		for(int i = 0; i < individualList.size(); i++) {
			result.append("[{\"value\": \"" + individualList.get(i).getFromID() + "\"},");
			result.append("{\"value\": \"" + individualList.get(i).getToID() + "\"},");
			result.append("{\"value\": \"" + individualList.get(i).getIndividualContent() + "\"},");
			result.append("{\"value\": \"" + individualList.get(i).getIndividualTIme() + "\"}]");
			if(i != individualList.size() - 1) {
				result.append(",");
			}
		}
		result.append("], \"last\":\"" + individualList.get(individualList.size() - 1).getIndividualID() + "\"}");
		individualDAO.readChat(fromID, toID);
		return result.toString();
	}
	
	public String getID(String fromID, String toID, String individualID) {
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		IndividualDAO individualDAO = new IndividualDAO();
		ArrayList<IndividualDTO> individualList = individualDAO.getChatListByID(fromID, toID, individualID);
		for(int i = 0; i < individualList.size(); i++) {
			result.append("[{\"value\": \"" + individualList.get(i).getFromID() + "\"},");
			result.append("{\"value\": \"" + individualList.get(i).getToID() + "\"},");
			result.append("{\"value\": \"" + individualList.get(i).getIndividualContent() + "\"},");
			result.append("{\"value\": \"" + individualList.get(i).getIndividualTIme() + "\"}]");
			if(i != individualList.size() - 1) {
				result.append(",");
			}
		}
		result.append("], \"last\":\"" + individualList.get(individualList.size() - 1).getIndividualID() + "\"}");
		individualDAO.readChat(fromID, toID);
		return result.toString();
	}
}
