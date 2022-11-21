<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import = "notice.NoticeDAO" %>
<%@ page import = "notice.NoticeDTO" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import="java.io.PrintWriter" %>

<% request.setCharacterEncoding("utf-8");%>


<%
	String userID = null;
    String pageNum = request.getParameter("pageNum");

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
		script.println("location.href = 'list.jsp'");
		script.println("</script>");
	}
	//BoardDataBean article = new BoardDBBean().getArticle(num);
	NoticeDAO dbPro = NoticeDAO.getInstance();
  	NoticeDTO article = dbPro.updateGetArticle(num);
	if(!userID.equals(article.getUserID())){//글을 작성한 사람이 맞는가?
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다.')");
		script.println("location.href = 'notice.jsp'");
		script.println("</script>");
	} else{	
		if(request.getParameter("subject") == null || request.getParameter("content") == null
				|| request.getParameter("subject").equals("") || request.getParameter("content").equals("")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");//화면을 이전으로 돌림
			script.println("</script>");
		}else{
			//BoardDBBean dbbb = new BoardDBBean();
			NoticeDAO dbbb = NoticeDAO.getInstance();
   		 	int check = dbbb.update(num, request.getParameter("subject"), request.getParameter("content"));
   			if(check == -1){
   				PrintWriter script = response.getWriter();
   				script.println("<script>");
   				script.println("alert('글수정이 실패했습니다.");
   				script.println("history.back()");//화면을 이전으로 돌림
   				script.println("</script>");
   			}else {
   				PrintWriter script = response.getWriter();
   				script.println("<script>");
   				script.println("location.href = 'Notice.jsp'");
   				script.println("</script>");
   				
   			}
		}
	}
 
%>
  

 