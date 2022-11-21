<%@ page contentType="text/html;charset=euc-kr" %>
<%@ page import = "nonameboard.NoNameDBBean" %>
<%@ page import = "java.sql.Timestamp" %>

<%
	request.setCharacterEncoding("euc-kr");
%>

<jsp:useBean id="article" scope="page" class="nonameboard.NoNameDataBean">
   <jsp:setProperty name="article" property="*"/>
</jsp:useBean>
 
<%
 	article.setReg_date(new Timestamp(System.currentTimeMillis()) );

     NoNameDBBean dbPro = NoNameDBBean.getInstance();
     dbPro.insertArticle(article);

     response.sendRedirect("nonameList.jsp");
 %>
