<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "notice.NoticeDTO" %>
<%@ page import = "notice.NoticeDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>

<html>
<head>
<meta charset="UTF-8">
<title>게시판 웹사이트</title>
</head>
<body>
	<%	
 	String pageNum = request.getParameter("pageNum");
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");//세션을 확인해서 userID라는 이름으로 세션이 존재하는 아이디는 해당하는 값을 넣도록한다.
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href = '../login/login.jsp'");
		script.println("</script>");
	}
	int num = 0;
	if(request.getParameter("num") != null){
		num = Integer.parseInt(request.getParameter("num"));
	}
	if(num == 0){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글입니다.')");
		script.println("location.href = 'notice.jsp'");
		script.println("</script>");
	}  
		NoticeDTO noticeDTO = new NoticeDAO().getArticle(num);
	if(!userID.equals(noticeDTO.getUserID())){//글을 작성한 사람이 맞는가?
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href = 'notice.jsp'");
		script.println("</script>");
	} else{	
		NoticeDAO noticeDAO = new NoticeDAO();
		int result = noticeDAO.deleteArticle(num, userID);
		if(result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글삭제가 실패했습니다.");
			script.println("history.back()");//화면을 이전으로 돌림
			script.println("</script>");
		}else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'notice.jsp'");
			script.println("</script>");
		}
	}
	%>

</body>
</html>