<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "evaluation.EvaluationDTO" %>
<%@ page import = "evaluation.EvaluationDAO" %>
<%@ page import = "util.SHA256" %>
<%@ page import = "java.io.PrintWriter" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
	request.setCharacterEncoding("UTF-8");
	String userID = null; //로그인을 한사람이라면 userID란 변수에 해당 아이디가 담기게 될거고 그렇지 않은 사람이라면 null값이 담기게된다.
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	if(userID == null){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('로그인을 하세요.')");
		script.println("location.href='../login/login.jsp'");
		script.println("</script>");
		script.close();
	}
	
	String lectureName = null;
	String professorName = null;
	int lectureYear = 0;
	String semesterDivide = null;
	String lectureDivide = null;
	String evaluationTitle = null;
	String evaluationContent = null;
	String totalScore = null;
	String creditScore = null;
	String lectureScore = null;
	
	if(request.getParameter("lectureName") != null){
		lectureName = request.getParameter("lectureName");
	}
	if(request.getParameter("professorName") != null){
		professorName = request.getParameter("professorName");
	}
	if(request.getParameter("lectureYear") != null){
		try{
	lectureYear = Integer.parseInt(request.getParameter("lectureYear"));
		} catch(Exception e){
	System.out.println("강의 년도 오류");
		}
	}
	if(request.getParameter("semesterDivide") != null){
		semesterDivide = request.getParameter("semesterDivide");
	}
	if(request.getParameter("lectureDivide") != null){
		lectureDivide = request.getParameter("lectureDivide");
	}
	
	if(request.getParameter("evaluationTitle") != null){
		evaluationTitle = request.getParameter("evaluationTitle");
	}
	
	if(request.getParameter("evaluationContent") != null){
		evaluationContent = request.getParameter("evaluationContent");
	}
	
	if(request.getParameter("totalScore") != null){
		totalScore = request.getParameter("totalScore");
	}
	
	if(request.getParameter("creditScore") != null){
		creditScore = request.getParameter("creditScore");
	}
	
	if(request.getParameter("lectureScore") != null){
		lectureScore = request.getParameter("lectureScore");
	}
	
	if(lectureName == null || professorName == null || lectureYear == 0 ||
	semesterDivide == null || lectureDivide == null || evaluationTitle == null || evaluationContent == null
	|| totalScore == null || creditScore == null || lectureScore == null
	|| evaluationTitle.equals("") || evaluationContent.equals("")){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안 된 사항이 있습니다.')");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}
	EvaluationDAO evaluationDAO = new EvaluationDAO();
	int result = evaluationDAO.write(new EvaluationDTO(0, userID, lectureName, professorName, lectureYear,
			semesterDivide, lectureDivide, evaluationTitle, evaluationContent, totalScore, creditScore
			, lectureScore, 0));
	if(result == -1){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('등록이 실패했습니다.')");
		script.println("history.back();");
		script.println("</script>");
		script.close();
	}else{
		session.setAttribute("userID", userID);
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'evaluationMain.jsp'");
		script.println("</script>");
		script.close();
	}
%>
</body>
</html>