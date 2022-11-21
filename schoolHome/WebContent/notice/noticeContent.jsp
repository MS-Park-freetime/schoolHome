<%@ page contentType = "text/html; charset=utf-8" %>
<%@ page import = "notice.NoticeDAO" %>
<%@ page import = "notice.NoticeDTO" %>
<%@ page import = "user.GuestDAO" %>
<%@ page import="java.io.PrintWriter" %><!-- 스크립트 문장을 실행할수 있도록. -->
<%@ page import="java.util.List" %><!-- 스크립트 문장을 실행할수 있도록. -->
<%@ page import = "java.text.SimpleDateFormat" %>
<%@ include file="/view/color.jsp"%>
<html>
<head>
<%! //선언부
    int pageSize = 10;
%>

<% 
	String userID = null; //로그인을 한사람이라면 userID란 변수에 해당 아이디가 담기게 될거고 그렇지 않은 사람이라면 null값이 담기게된다.
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
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
   	String pageNum = request.getParameter("pageNum");

    NoticeDAO dbPro = NoticeDAO.getInstance();
    NoticeDTO notice = dbPro.getArticle(num);
  
	
    if (pageNum == null) {
        pageNum = "1";
    }
    String replyContent = null;
	if(request.getParameter("replyContent") != null){
		replyContent = request.getParameter("replyContent");
	}

    int currentPage = Integer.parseInt(pageNum);
    int startRow = (currentPage - 1) * pageSize + 1;
    int endRow = currentPage * pageSize;
    int count = 0;
    int number=0;

    List noticeList = null;
    NoticeDAO noticeDAO = NoticeDAO.getInstance();
    count = noticeDAO.getArticleCount();
    if (count > 0) {
        noticeList = noticeDAO.getArticles(startRow, pageSize);
    }

	number=count-(currentPage-1)*pageSize;
%>
<title>게시판</title>
<link href="../style.css" rel="stylesheet" type="text/css">
<meta charset="UTF-8">
<meta name="viewport" content="width-device-width, initial-scale=1">
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../js/bootstrap.js"></script>
<link rel="stylesheet" href="../css/bootstrap.css">
<link rel="stylesheet" href="../css/custom.css">
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
<body>  
<center><b>글내용 보기</b>
<br>
<form>
<table width="750" border="1" cellspacing="0" cellpadding="0" align="center">  
  <tr height="30">
    <td align="center" width="125">글번호</td>
    <td align="center" width="125" align="center">
	     <%=notice.getNum()%></td>
    <td align="center" width="125">조회수</td>
    <td align="center" width="125" align="center">
	     <%=notice.getReadcount()%></td>
</tr>
<tr height="30">
    <td align="center" width="125">작성자</td>
    <td align="center" width="125" align="center">
	     <%=notice.getUserID()%></td>
    <td align="center" width="125">작성일</td>
    <td align="center" width="125" align="center">
	     <%= notice.getReg_date()%></td>
  </tr>
  <tr height="30">
    <td align="center" width="125">글제목</td>
    <td align="center" width="625" align="center" colspan="3">
	     <%=notice.getSubject()%></td>
  </tr>
  <tr>
    <td align="center" width="125">글내용</td>
    <td align="left" width="625" colspan="3"><pre><%=notice.getContent()%></pre></td>
  </tr>
  <tr height="30">      
    <td colspan="4" align="right" > 
    <%
		if(userID != null && userID.equals("coco")){
	%>
	  <input type="button" value="글수정" 
       onclick="document.location.href='noticeUpdateForm.jsp?num=<%=notice.getNum()%>&pageNum=<%=pageNum%>'">
	   &nbsp;&nbsp;&nbsp;&nbsp;
	  <a href="noticeDeletePro.jsp?num=<%=notice.getNum()%>&pageNum=<%=pageNum%>"><input type="button" value="글삭제" onClick="return confirm('정말로 삭제하시겠습니까?')"></a>
	   &nbsp;&nbsp;&nbsp;&nbsp;
	<% 		
		}
	%>
       <input type="button" value="글목록" 
       onclick="document.location.href='notice.jsp?pageNum=<%=pageNum%>'">
    </td>
  </tr>
</table>
    <div>
    	<div id="comment" class="chat-body">
			<div id="commentList">
				
			</div>
		</div>
		<div class="clear"></div>
		<div class="chat-footer">
			<div class="chat-footer-box">
				<!-- userID -->
			</div>
			<div class="chat-footer-box">
				<div>
					<textarea id="commentContent" class="chat-content-form" placeholder="내용을 입력하세요." maxlength="100"></textarea>
				</div>
				<div class="chat-footer-button-align">
					<button type="button" onclick="submitFunction();" class="chat-content-submit">댓글쓰기</button>
				</div>
			</div>			
		</div>
    </div>
</form>      
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
				<a href="contact.html"><img src="images/logo_footer_bb.PNG" alt="no"></a>
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
</body>
</html>      
