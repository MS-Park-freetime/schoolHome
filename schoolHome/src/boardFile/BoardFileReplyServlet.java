package boardFile;

import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

/**
 * Servlet implementation class UserProfileServlet
 */
@WebServlet("/boardFileReply")
public class BoardFileReplyServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BoardFileReplyServlet() {
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
		MultipartRequest multi = null;
		int fileMaxSize = 10 * 1024 * 1024;
		String savePath = request.getRealPath("/upload").replace("\\\\", "/");
		try {
			multi = new MultipartRequest(request, savePath, fileMaxSize, "UTF-8", new DefaultFileRenamePolicy());
		} catch (Exception e) {
			// TODO: handle exception
			request.getSession().setAttribute("messageType", "오류메세지");
			request.getSession().setAttribute("messageContent", "파일크기는 10MB를 넘을 수 없습니다.");
			response.sendRedirect("boardFile/boardFileWriteForm.jsp");
			return;
		}
		String userID = multi.getParameter("userID");
		HttpSession session = request.getSession();
		/*if(!userID.equals((String)session.getAttribute("userID"))){
			session.setAttribute("messageType", "오류메세지");
			session.setAttribute("messageContent", "접근할 수 없습니다.");
			response.sendRedirect("index.jsp");
			return;
		}*/
		int num = Integer.parseInt(multi.getParameter("num"));
		if(num == 0) {
			session.setAttribute("messageType", "오류메세지");
			session.setAttribute("messageContent", "접근할 수 없습니다.");
			response.sendRedirect("boardFile/boardFileList.jsp");
			return;
		}
		String boardTitle = multi.getParameter("boardTitle");
		String boardContent = multi.getParameter("boardContent");
		if(boardTitle == null || boardTitle.equals("") || boardContent == null || boardContent.equals("")) {
			session.setAttribute("messageType", "오류메세지");
			session.setAttribute("messageContent", "내용을 모두 채워주세요.");
			response.sendRedirect("boardFile/boardFileReplyForm.jsp");
			return;
		}
		String boardFile = "";
		String boardRealFile = "";
		File file = multi.getFile("boardFile");
		if(file != null) {
			boardFile = multi.getOriginalFileName("boardFile");
			boardRealFile = file.getName();
		}
		BoardFileDAO boardFileDAO = new BoardFileDAO();
		BoardFileDTO parent = boardFileDAO.getBoard(num);
		boardFileDAO.replyUpdate(parent);
		boardFileDAO.reply(userID, boardTitle, boardContent, boardFile, boardRealFile, parent);
		session.setAttribute("messageType", "성공메세지");
		session.setAttribute("messageContent", "답변이 등록되었습니다.");
		response.sendRedirect("boardFile/boardFileList.jsp");
		return;
	}

}
