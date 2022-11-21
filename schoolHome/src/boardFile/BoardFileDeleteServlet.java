package boardFile;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class BoardFileDeleteServlet
 */
@WebServlet("/boardFileDelete")
public class BoardFileDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardFileDeleteServlet() {
        super();
        // TODO Auto-generated constructor stub
    }
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		HttpSession session = request.getSession();
		String userID = (String) session.getAttribute("userID");
		int num = Integer.parseInt(request.getParameter("num"));
		
		if(num == 0) {
			request.getSession().setAttribute("messageType", "오류메세지");
			request.getSession().setAttribute("messageContent", "접근할 수 없습니다.");
			response.sendRedirect("boardFile/boardFileList.jsp");
			return;
		}
		BoardFileDAO boardFileDAO = new BoardFileDAO();
		BoardFileDTO boardFileDTO = boardFileDAO.getBoard(num);
		if(!userID.equals(boardFileDTO.getUserID())) {
			request.getSession().setAttribute("messageType", "오류메세지");
			request.getSession().setAttribute("messageContent", "접근할 수 없습니다.");
			response.sendRedirect("boardFile/boardFileList.jsp");
			return;
		}
		String savePath = request.getRealPath("/upload").replace("\\\\", "/");
		String prev = boardFileDAO.getRealFile(num);
		int result = boardFileDAO.delete(num);
		if(result == -1) {
			request.getSession().setAttribute("messageType", "오류메세지");
			request.getSession().setAttribute("messageContent", "접근할 수 없습니다.");
			response.sendRedirect("boardFile/boardFileList.jsp");
			return;
		}else {
			File prevFile = new File(savePath + "/" + prev);
			if(prevFile.exists()) {
				prevFile.delete();
			}
			request.getSession().setAttribute("messageType", "오류메세지");
			request.getSession().setAttribute("messageContent", "게시글이 삭제되었습니다.");
			response.sendRedirect("boardFile/boardFileList.jsp");
		}
	}

}
