<%@ page contentType = "text/html; charset=euc-kr" %>
<%@ page import = "nonameboard.NoNameDBBean" %>
<%@ page import = "nonameboard.NoNameDataBean" %>
<%@ include file="/view/color.jsp"%>
<html>
<head>
<%
	String userID = null; //�α����� �ѻ���̶�� userID�� ������ �ش� ���̵� ���� �ɰŰ� �׷��� ���� ����̶�� null���� ���Եȴ�.
	if(session.getAttribute("userID") != null){
	userID = (String) session.getAttribute("userID");
	}
	int num = Integer.parseInt(request.getParameter("num"));
  String pageNum = request.getParameter("pageNum");
  try{
      NoNameDBBean dbPro = NoNameDBBean.getInstance();
      NoNameDataBean article =  dbPro.updateGetArticle(num);
%>
<title>�Խ���</title>
<script language="JavaScript" src="script.js"></script>
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
<center><b>�ۼ���</b>
<br>
<form method="post" name="writeform" action="nonameUpdatePro.jsp?pageNum=<%=pageNum%>" onsubmit="return writeSave()">
<table width="400" border="1" cellspacing="0" cellpadding="0"  bgcolor="<%=bodyback_c%>" align="center">
  <tr>
    <td  width="70"  bgcolor="<%=value_c%>" align="center">�� ��</td>
    <td align="left" width="330">
       <input type="text" size="10" maxlength="10" name="writer" value="<%=article.getWriter()%>">
	   <input type="hidden" name="num" value="<%=article.getNum()%>"></td>
  </tr>
  <tr>
    <td  width="70"  bgcolor="<%=value_c%>" align="center" >�� ��</td>
    <td align="left" width="330">
       <input type="text" size="40" maxlength="50" name="subject" value="<%=article.getSubject()%>"></td>
  </tr>
  <tr>
  <tr>
    <td  width="70"  bgcolor="<%=value_c%>" align="center" >�� ��</td>
    <td align="left" width="330">
     <textarea name="content" rows="13" cols="40"><%=article.getContent()%></textarea></td>
  </tr>
  <tr>
    <td  width="70"  bgcolor="<%=value_c%>" align="center" >��й�ȣ</td>
    <td align="left" width="330" >
     <input type="password" size="8" maxlength="12" name="passwd">
     
	 </td>
  </tr>
  <tr>      
   <td colspan=2 bgcolor="<%=value_c%>" align="center"> 
     <input type="submit" value="�ۼ���" >  
     <input type="reset" value="�ٽ��ۼ�">
     <input type="button" value="��Ϻ���" 
       onclick="document.location.href='nonameList.jsp?pageNum=<%=pageNum%>'">
   </td>
 </tr>
 </table>
</form>
<%
}catch(Exception e){}%>      
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
