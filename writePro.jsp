<%@ page contentType="text/html;charset=utf-8" %>
<%@ page import = "board.BoardDBBean" %>
<%@ page import = "java.sql.Timestamp" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("utf-8");%>

<jsp:useBean id="article" scope="page" class="board.BoardDataBean">
   <jsp:setProperty name="article" property="*"/>
</jsp:useBean>
 
<%
    article.setReg_date(new Timestamp(System.currentTimeMillis()) );
	
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
	}else{	
		if(article.getSubject() == null || article.getContent() == null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('입력이 안 된 사항이 있습니다.')");
			script.println("history.back()");//화면을 이전으로 돌림
			script.println("</script>");
		}else{
			BoardDBBean bdbb = BoardDBBean.getInstance();
    		int result = bdbb.insertArticle(article, userID);
			if(result == -1){
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('글쓰기에 실패했습니다.");
				script.println("history.back()");//화면을 이전으로 돌림
				script.println("</script>");
			}else {
				/*PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'list.jsp'");
				script.println("</script>");
	*/
				response.sendRedirect("list.jsp");
			}
		}
	}
    //BoardDBBean dbPro = BoardDBBean.getInstance();
    //dbPro.insertArticle(article, userID);

    //response.sendRedirect("list.jsp");
%>
