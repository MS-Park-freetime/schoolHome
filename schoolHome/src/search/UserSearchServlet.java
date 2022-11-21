package search;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import user.Guest;

/**
 * Servlet implementation class UserSearchServlet
 */
@WebServlet("/userSearch")
public class UserSearchServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public UserSearchServlet() {
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
		response.getWriter().write(getJSON(userID));
	}
	
	public String getJSON(String userID) { //�Ľ��ϱ� ���� �ϳ��� ���� ȸ���� �˻������� JSON ���·� ���
											//�ٽ� �Ľ��ؼ� �м��ؼ� ������.
		if(userID == null) {
			userID = "";
		}
		StringBuffer result = new StringBuffer("");
		result.append("{\"result\":[");
		UserSearchDAO userSearchDAO = new UserSearchDAO();
		ArrayList<Guest> searchList = userSearchDAO.search(userID);
		for (int i = 0; i < searchList.size(); i++) {
			result.append("[{\"value\": \"" + searchList.get(i).getUserID() + "\"},");
			result.append("{\"value\": \"" + searchList.get(i).getUserName() + "\"},");
			result.append("{\"value\": \"" + searchList.get(i).getUserAge() + "\"},");
			result.append("{\"value\": \"" + searchList.get(i).getUserGender() + "\"},");
			result.append("{\"value\": \"" + searchList.get(i).getUserEmail() + "\"}],");
		
		}
		result.append("]}");
		return result.toString();
	}

}
