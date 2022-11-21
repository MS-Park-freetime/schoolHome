<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "user.GuestDAO" %>
<%@ page import = "evaluation.EvaluationDAO" %>
<%@ page import = "likey.LikeyDAO" %>
<%@ page import = "java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width", initial-scale="1">
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../js/bootstrap.js"></script>
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/custom.css">
<link href="../css/stylesheet.css" type="text/css" rel="stylesheet" />
<script src="../js/jquery-1.12.3.js" type="text/javascript"></script>
<script src="../js/script.js" defer="defer" type="text/javascript"></script>
<title>Insert title here</title>
</head>
<body>
<%!
	public static String getClientIP(HttpServletRequest request){
		String ip = request.getHeader("X-FORWARDED-FOR");
		if(ip == null || ip.length() == 0){
			ip = request.getHeader("Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0){
			ip = request.getHeader("WL-Proxy-Client-IP");
		}
		if(ip == null || ip.length() == 0){
			ip = request.getRemoteAddr();
		}
		return ip;
}
%>
<%
	request.setCharacterEncoding("UTF-8");
	GuestDAO guestDAO = new GuestDAO();
	String userID = null;
	if(session.getAttribute("userID") != null){
		userID = (String)session.getAttribute("userID");
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
		script.close();
	}
	
	request.setCharacterEncoding("UTF-8");
	String evaluationID = null;
	if(request.getParameter("evaluationID") != null){
		evaluationID = request.getParameter("evaluationID");
	}
	EvaluationDAO evaluationDAO = new EvaluationDAO();
	LikeyDAO likeyDAO = new LikeyDAO();
	int result = likeyDAO.like(userID, evaluationID, getClientIP(request));
	if(result == 1){
		result = evaluationDAO.like(evaluationID);
		if(result == 1){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('추천이 완료되었습니다.')");
			script.println("location.href = 'evaluationMain.jsp'");
			script.println("</script>");
			script.close();		
		}else{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('추천이 되지않았습니다.')");
			script.println("location.href = 'evaluationMain.jsp'");
			script.println("</script>");
			script.close();		
		}
	}else{
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('이미 추천을 하였습니다.')");
		script.println("location.href = 'evaluationMain.jsp'");
		script.println("</script>");
		script.close();			
	}
%>
</body>
</html>