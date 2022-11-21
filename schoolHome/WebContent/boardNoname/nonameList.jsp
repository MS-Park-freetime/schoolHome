<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="nonameboard.NoNameDBBean"%>
<%@ page import="nonameboard.NoNameDataBean"%>
<%@ page import="user.GuestDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="java.io.PrintWriter" %><!-- ��ũ��Ʈ ������ �����Ҽ� �ֵ���. -->
<%@ page import="java.text.SimpleDateFormat"%>
<%@ include file="/view/color.jsp"%>

<%!//�����
    int pageSize = 10;
    SimpleDateFormat sdf = 
        new SimpleDateFormat("yyyy-MM-dd HH:mm");%>

<%
String userID = null; //�α����� �ѻ���̶�� userID�� ������ �ش� ���̵� ���� �ɰŰ� �׷��� ���� ����̶�� null���� ���Եȴ�.
if(session.getAttribute("userID") != null){
	userID = (String) session.getAttribute("userID");
}
	String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {
        pageNum = "1";
    }

    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * pageSize + 1;
    int endRow = currentPage * pageSize;
    int count = 0;
    int number=0;

    List articleList = null;
    NoNameDBBean dbPro = NoNameDBBean.getInstance();
    count = dbPro.getArticleCount();
    if (count > 0) {
        articleList = dbPro.getArticles(startRow, pageSize);
    }

	number=count-(currentPage-1)*pageSize;
	String emailChecked = new GuestDAO().getUserEmailChecked(userID);
	System.out.println(emailChecked);
	/*if(emailChecked.equals("FALSE")){
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'login/emailSendConfirm.jsp'");
		script.println("</script>");
		script.close();
	}*/
%>
<html>
<head>
<title>�Խ���</title>
<link href="../css/stylesheet.css" type="text/css" rel="stylesheet" />
<script src="../js/jquery-1.12.3.js" type="text/javascript"></script>
<script src="../js/script.js" defer="defer" type="text/javascript"></script>
<script type="text/javascript">
function getUnread(){
	$.ajax({
		type: "POST",
		url: ".././individualUnread",
		data: {
			userID: encodeURIComponent('<%=userID %>'),
		},
		success: function(result){
			if(result >= 1){
				showUnread(result);
			}else{
				showUnread('');
			}
		}
	});
}
function getInfiniteUnread(){
		setInterval(function(){
			getUnread();
		}, 1000);
	}
function showUnread(result){
	$('#unread').html(result);
}
</script>
</head>
<body bgcolor="<%=bodyback_c%>">
<header class="all">
			<div class="header_box" class="all">
				<ul class="three_menu">
					<li><a href="../index.jsp">ó������&nbsp;|&nbsp;</a></li>
					<%
						if(userID == null){
					%>
					<li><a href="../login/login.jsp">�α���&nbsp;&nbsp;</a></li>
					<%		
						}else{
					%>	
					<li><a href="../login/logoutAction.jsp">�α׾ƿ�&nbsp;|&nbsp;</a></li>
					<li><a href="../info/info.jsp">ȸ������</a></li>
					<li><a href="../info/loginSearch.jsp">|&nbsp;&nbsp;ȸ�����</a></li>
					<li><a href="../info/find.jsp">|&nbsp;&nbsp;ȸ��ã��</a></li>
					<% 
						}
					%>
				</ul>

				<ul class="four_menu">
					<li><a href="#">JAPANESE&nbsp;|&nbsp;</a></li>
					<li><a href="#">CHINESE&nbsp;|&nbsp;</a></li>
					<li><a href="#">ENGLISH&nbsp;|&nbsp;</a></li>
					<li><a href="#">KOREAN&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a></li>
				</ul>
			</div>
		<div id="header_div" class="wrap">
			<div class="logo">
				<a href="../index.jsp"><img src="../images/logo1.jpg" alt="�뱸���б�"> </a>
			</div>
			<nav>
				<ul class="nav">
					<li><a href="../notice/notice.jsp">��������</a>
					<li><a href="#">�Խ���</a>
						<ul class="submenu">
							<li><a href="../board/list.jsp">��� �Խ���</a></li>
							<li><a href="#">�亯�Խ���</a></li>
							<li><a href="../boardNoname/nonameList.jsp">�͸� �Խ���</a></li>
							<li><a href="../boardFile/boardFileList.jsp">���� �Խ���</a></li>
						</ul></li>
					<li><a href="#">ä�ù�<span id="unread" class="unread-label"></span></a>
						<ul class="submenu">
							<li><a href="../anonymousChatting.jsp">�͸�ä�ù�</a></li>
							<li><a href="../individualChattingBox.jsp">����ä�ù�<span id="unread" class="unread-label"></span></a></li>
							<li><a href="#">3-3</a></li>
							<li><a href="#">3-4</a></li>
						</ul></li>
					<li><a href="#">�������</a>
						<ul class="submenu">
							<li><a href="#">5-1</a></li>
							<li><a href="#">5-2</a></li>
							<li><a href="#">5-3</a></li>
							<li><a href="#">5-4</a></li>
						</ul></li>
					<li><a href="../evaluation/evaluationMain.jsp">���ϱ�</a>
					<li><a href="#">����</a>
						<ul class="submenu">
							<li><a href="#">4-1</a></li>
							<li><a href="#">4-2</a></li>
							<li><a href="#">4-3</a></li>
							<li><a href="#">4-4</a></li>
						</ul></li>
					<li class="clear"></li>
				</ul>
			</nav>
		</div>
	</header>
	<div class="clear"></div>
	<center>
		<b>�۸��(��ü ��:<%=count%>)
		</b>
		<table width="700">
			<tr>
				<td align="right" bgcolor="<%=value_c%>"><a
					href="nonameWriteForm.jsp">�۾���</a></td>
		</table>

		<%
			if (count == 0) {
		%>
		<table width="700" border="1" cellpadding="0" cellspacing="0">
			<tr>
				<td align="center">�Խ��ǿ� ����� ���� �����ϴ�.</td>
		</table>

		<%
			} else {
		%>
		<table border="1" width="700" cellpadding="0" cellspacing="0"
			align="center">
			<tr height="30" bgcolor="<%=value_c%>">
				<td align="center" width="50">�� ȣ</td>
				<td align="center" width="250">�� ��</td>
				<td align="center" width="100">�ۼ���</td>
				<td align="center" width="150">�ۼ���</td>
				<td align="center" width="50">�� ȸ</td>
			</tr>
			<%
				for (int i = 0 ; i < articleList.size() ; i++) {
			          NoNameDataBean article = (NoNameDataBean)articleList.get(i);
			%>
			<tr height="30">
				<td align="center" width="50"><%=number--%></td>
				<td width="250">
					<%
	      int wid=0; 
	      if(article.getRe_level()>0){
	        wid=5*(article.getRe_level());
	%> <img src="../images/level.gif" width="<%=wid%>" height="16"> <img
					src="../images/re.gif"> <%}else{%> <img src="../images/level.gif"
					width="<%=wid%>" height="16"> <%}%> <a
					href="nonameContent.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>">
						<%=article.getSubject()%></a> <% if(article.getReadcount()>=10){%> <img
					src="../images/hot.gif" border="0" height="16">
					<%}%>
				</td>
				<td align="center" width="100"><%=article.getWriter()%></td>
				<td align="center" width="150"><%= sdf.format(article.getReg_date())%></td>
				<td align="center" width="50"><%=article.getReadcount()%></td>
			</tr>
			<%}%>
		</table>
		<%}%>

		<%
    if (count > 0) {
        int pageCount = count / pageSize + ( count % pageSize == 0 ? 0 : 1);
		
        int startPage = (int)(currentPage/10)*10+1;
		int pageBlock=10;
        int endPage = startPage + pageBlock-1;
        if (endPage > pageCount) endPage = pageCount;
        
        if (startPage > 10) {    %>
		<a href="nonameList.jsp?pageNum=<%= startPage - 10 %>">[����]</a>
		<%      }
        for (int i = startPage ; i <= endPage ; i++) {  %>
		<a href="nonameList.jsp?pageNum=<%= i %>">[<%= i %>]
		</a>
		<%
        }
        if (endPage < pageCount) {  %>
		<a href="nonameList.jsp?pageNum=<%= startPage + 10 %>">[����]</a>
		<%
        }
    }
%>
	</center>
<div class="clear"></div>

	<footer>
		<div class="all">
			<div class="footer_box">
				<ul>
					<li><a href="#">��������ó����ħ</a></li>
					<li><a href="#">�̸��Ϲ��ܼ����ź�</a></li>
					<li><a href="#">�뱸���б�</a></li>
					<li><a href="#">����Ϲ���</a></li>
				</ul>
			</div>
			<ul>
				<a href="contact.html"><img src="../images/logo_footer_bb.PNG" alt="no"></a>
			</ul>
			<p>
				38453) ���ϵ� ���� ������ �뱸��� 201 TEL 053-850-5000 (��ǥ��ȣ,
				�л��ູ�ݼ���) FAX 053-850-5009<br> Copyright(c) 2018 By Daegu
				University All right Reserved.
			</p>
		</div>
		<div class="clear"></div>
	</footer>
	<%
	if(userID != null){
%>
	<script type="text/javascript">
		$(document).ready(function(){
			getUnread();
			getInfiniteUnread();
		});
	</script>
<%
	}
%>
</body>
</html>

