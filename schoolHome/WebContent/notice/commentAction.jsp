<%@page import="notice.NoticeCommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<% request.setCharacterEncoding("utf-8");%>
<%
	int comment_num = Integer.parseInt(request.getParameter("comment_num"));
	String pageNum = request.getParameter("pageNum");
	String userID = null; //로그인을 한사람이라면 userID란 변수에 해당 아이디가 담기게 될거고 그렇지 않은 사람이라면 null값이 담기게된다.
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	String comment_date = request.getParameter("comment_date");
	String comment_content = request.getParameter("comment_content");
	int comment_ref = Integer.parseInt(request.getParameter("comment_ref"));
	
	NoticeCommentDAO commentDAO = NoticeCommentDAO.getInstance();
	//commentDAO.insertComment(comment_num, userID, comment_date, comment_content, comment_ref);
%>


</body>
</html>