<%@page import="java.io.PrintWriter"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="boardFile.BoardFileDTO"%>
<%@ page import="boardFile.BoardFileDAO"%>
<%@ page import="user.GuestDAO" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ include file="/view/color.jsp"%>

<%! //선언부
    int pageSize = 10;
%>

<%
	String userID = null; //로그인을 한사람이라면 userID란 변수에 해당 아이디가 담기게 될거고 그렇지 않은 사람이라면 null값이 담기게된다.
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	ArrayList<BoardFileDTO> boardFileList = null;
   
	String pageNum = request.getParameter("pageNum");
    if (pageNum == null) {
        pageNum = "1";
    }

    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * pageSize + 1;
    int endRow = currentPage * pageSize;
    int count = 0;
    int number=0;
	
   // List articleList = null;
   	BoardFileDAO boardFileDAO = BoardFileDAO.getInstance();
    count = boardFileDAO.getArticleCount();
    if (count > 0) {
        boardFileList = boardFileDAO.getArticles(startRow, pageSize);
    }

	number=count-(currentPage-1)*pageSize;
%>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="../css/bootstrap.css">
<link href="../style.css" rel="stylesheet" type="text/css">
<link href="../css/stylesheet.css" type="text/css" rel="stylesheet" />
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../js/bootstrap.js"></script>
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
<title>게시판</title>
</head>
<header class="all">
			<div class="header_box" class="all">
				<ul class="three_menu">
					<li><a href="../index.jsp">처음으로&nbsp;|&nbsp;</a></li>
					<%
						if(userID == null){
					%>
					<li><a href="../login/login.jsp">로그인&nbsp;&nbsp;</a></li>
					<%		
						}else{
					%>	
					<li><a href="../login/logoutAction.jsp">로그아웃&nbsp;|&nbsp;</a></li>
					<li><a href="../info/info.jsp">회원정보</a></li>
					<li><a href="../info/loginSearch.jsp">|&nbsp;&nbsp;회원목록</a></li>
					<li><a href="../info/find.jsp">|&nbsp;&nbsp;회원찾기</a></li>
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
				<a href="../index.jsp"><img src="../images/logo1.jpg" alt="대구대학교"> </a>
			</div>
			<nav>
				<ul class="nav">
					<li><a href="../notice/notice.jsp">공지사항</a>
					<li><a href="#">게시판</a>
						<ul class="submenu">
							<li><a href="../board/list.jsp">답글 게시판</a></li>
							<li><a href="#">답변게시판</a></li>
							<li><a href="../boardNoname/nonameList.jsp">익명 게시판</a></li>
							<li><a href="../boardFile/boardFileList.jsp">파일 게시판</a></li>
						</ul></li>
					<li><a href="#">채팅방<span id="unread" class="unread-label"></span></a>
						<ul class="submenu">
							<li><a href="../anonymousChatting.jsp">익명채팅방</a></li>
							<li><a href="../individualChattingBox.jsp">개인채팅방<span id="unread" class="unread-label"></span></a></li>
							<li><a href="#">3-3</a></li>
							<li><a href="#">3-4</a></li>
						</ul></li>
					<li><a href="#">스쿨버스</a>
						<ul class="submenu">
							<li><a href="#">5-1</a></li>
							<li><a href="#">5-2</a></li>
							<li><a href="#">5-3</a></li>
							<li><a href="#">5-4</a></li>
						</ul></li>
					<li><a href="../evaluation/evaluationMain.jsp">평가하기</a>
					<li><a href="#">쇼핑</a>
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
<body bgcolor="<%=bodyback_c%>">
	<center>
		<b>글목록(전체 글:<%=count%>)
		</b>
		<table width="700">
			<tr>
				<td align="right" bgcolor="<%=value_c%>"><a
					href="../boardFile/boardFileWriteForm.jsp">글쓰기</a></td>
		</table>

		<%
    if (count == 0) {
%>
		<table width="700" border="1" cellpadding="0" cellspacing="0">
			<tr>
				<td align="center">게시판에 저장된 글이 없습니다.</td>
		</table>

		<%  } else {    %>
		<table border="1" width="700" cellpadding="0" cellspacing="0"
			align="center">
			<tr height="30" bgcolor="<%=value_c%>">
				<td align="center" width="50">번 호</td>
				<td align="center" width="250">제 목</td>
				<td align="center" width="100">작성자</td>
				<td align="center" width="150">작성일</td>
				<td align="center" width="50">조 회</td>
			</tr>
			<%  
        for (int i = 0 ; i < boardFileList.size() ; i++) {
           BoardFileDTO boardFile = boardFileList.get(i);
%>
			<tr height="30">
				<td align="center" width="50"><%=number--%></td>
				<td width="250">
					<%
	      int wid=0; 
	      if(boardFile.getRe_level()>0){
	        wid=5*(boardFile.getRe_level());
	%> <img src="../images/level.gif" width="<%=wid%>" height="16"> <img
					src="../images/re.gif"> <%}else{%> <img src="../images/level.gif"
					width="<%=wid%>" height="16"> <%}%> <a
					href="../boardFile/boardFileContent.jsp?num=<%=boardFile.getNum()%>&pageNum=<%=currentPage%>">
						<%=boardFile.getBoardTitle()%></a> <% if(boardFile.getReadcount()>=30){%> <img
					src="../images/hot.gif" border="0" height="16">
					<%}%>
				</td>
				<td align="center" width="100"><%=boardFile.getUserID()%></td>
				<td align="center" width="150"><%=boardFile.getBoardDate()%></td>
				<td align="center" width="50"><%=boardFile.getReadcount()%></td>
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
		<a href="boardFileList.jsp?pageNum=<%= startPage - 10 %>">[이전]</a>
		<%      }
        for (int i = startPage ; i <= endPage ; i++) {  %>
		<a href="boardFilelist.jsp?pageNum=<%= i %>">[<%= i %>]
		</a>
		<%
        }
        if (endPage < pageCount) {  %>
		<a href="boardFilelist.jsp?pageNum=<%= startPage + 10 %>">[다음]</a>
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
					<li><a href="#">개인정보처리방침</a></li>
					<li><a href="#">이메일무단수집거부</a></li>
					<li><a href="#">대구대학교</a></li>
					<li><a href="#">모바일버전</a></li>
				</ul>
			</div>
			<ul>
				<a href="contact.html"><img src="../images/logo_footer_bb.PNG" alt="no"></a>
			</ul>
			<p>
				38453) 경상북도 경산시 진량읍 대구대로 201 TEL 053-850-5000 (대표번호,
				학생행복콜센터) FAX 053-850-5009<br> Copyright(c) 2018 By Daegu
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
	<%
	String messageContent = null;
	if(session.getAttribute("messageContent") != null){
		messageContent = (String) session.getAttribute("messageContent");
	}
	String messageType = null;
	if(session.getAttribute("messageType") != null){
		messageType = (String) session.getAttribute("messageType");
	}
	if(messageContent != null){
%>
	<div class="modal fade topalign" id="messageModal" tableindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-total-align">
			<div class="modal-dialog">
				<div class="modal-content modal-content-align" <%if(messageType.equals("오류메세지")) {out.println("warning");}else{out.println("success");} %>>
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times</span>
							<span class="button-close">close</span>
						</button>
						<h4 class="modal-title">
							<%=messageType %>
						</h4>
					</div>
					<div class="modal-body">
						<%=messageContent %>
					</div>
					<div class="modal-footer">
						<button type="button" class="message-button" data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script>
		$('#messageModal').modal("show");
	</script>
<%
	session.removeAttribute("messageContent");
	session.removeAttribute("messageType");
	}
%>		
</body>
</html>

