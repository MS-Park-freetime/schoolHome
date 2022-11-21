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
	String pageNum = request.getParameter("pageNum");

	NoNameDBBean dbPro = NoNameDBBean.getInstance();
    int check = dbPro.updateArticle(article);

    if(check==1){
%>
	  <meta http-equiv="Refresh" content="0;url=nonameList.jsp?pageNum=<%=pageNum%>" >
<% }else{%>
      <script language="JavaScript">      
      <!--      
        alert("비밀번호가 맞지 않습니다");
        history.go(-1);
      -->
     </script>
<%
    }
 %>  

 