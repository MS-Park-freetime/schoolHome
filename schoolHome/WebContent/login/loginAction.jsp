<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.GuestDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="user" class="user.Guest" scope="page"></jsp:useBean> <!-- 현재페이지 안에서만 useBean이 사용됨 -->
<jsp:setProperty name="user" property="userID"/> <!-- 로그인페이지에서 넘겨준 유저아이드를 그대로 받아서 한명의 사용자인 유저아이디에 넣어줌 -->
<jsp:setProperty name="user" property="userPassword"/>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 웹사이트</title>
</head>
<body> 
	<%
		String userID = null;
		if(session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");//세션을 확인해서 userID라는 이름으로 세션이 존재하는 아이디는 해당하는 값을 넣도록한다.
		}
		if(userID != null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인이 되어있습니다.')");
			script.println("location.href = '../index.jsp'");
			script.println("</script>");
		}
		GuestDAO guestDAO = new GuestDAO();
		int result = guestDAO.login(user.getUserID(), user.getUserPassword());
		if(result == 1){
			session.setAttribute("userID", user.getUserID());//세션을 부여해줌
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = '../index.jsp'");
			script.println("</script>");
		}else if (result == 0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('비밀번호가 틀립니다.')");
			script.println("history.back()");//화면을 이전으로 돌림
			script.println("</script>");
		}else if (result == -1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 아이디입니다.')");
			script.println("history.back()");//화면을 이전으로 돌림
			script.println("</script>");
		}else if (result == -2){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('데이터베이스 오류가 발생하였습니다.')");
			script.println("history.back()");//화면을 이전으로 돌림
			script.println("</script>");
		}
	%>
</body>
</html>