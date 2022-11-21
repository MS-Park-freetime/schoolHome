<%@ page contentType="text/html; charset=utf-8" %>
<%@ include file="/view/color.jsp"%>
<%@ page import = "user.Guest" %>
<%@ page import = "user.GuestDAO" %>
<%@ page import="java.io.PrintWriter" %><!-- 스크립트 문장을 실행할수 있도록. -->
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
<title>게시판</title>
</head>
<% 
	String userID = null; //로그인을 한사람이라면 userID란 변수에 해당 아이디가 담기게 될거고 그렇지 않은 사람이라면 null값이 담기게된다.
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
	Guest guest = new GuestDAO().getUserInfo(userID);
%>
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
<body bgcolor="<%=bodyback_c%>">  
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
<center><b>글쓰기</b>
<br>
<form method="post" name="writeform" action=".././boardFileWrite" enctype="multipart/form-data">

<table class="board-table" bgcolor="<%=bodyback_c%>" align="center">
   <tr>
    <td align="right" colspan="2" bgcolor="<%=value_c%>" class="board-table-top">
	    <a href="boardFileList.jsp">글목록</a> 
   </td>
   </tr>
  <tr>
    <td class="board-table-title">아 이 디</td>
    <td class="board-table-content"><h5><%=guest.getUserID() %></h5>
       <input type="hidden" class="board-table-input" name="userID" value="<%=guest.getUserID()%>"></td>
  </tr>
  <tr>
    <td class="board-table-title">제 목</td>
    <td class="board-table-content">
       <input type="text" class="board-table-input" name="boardTitle"></td>
  </tr>
  <tr>
    <td bgcolor="<%=value_c%>" align="center">내 용</td>
    <td>
     <textarea name="boardContent" rows="13" cols="40" class="board-table-textarea"></textarea> </td>
  </tr>
  <tr>
	<td class="join-form-title"><h5>파일 업로드</h5></td>
	<td colspan="2">
		<input type="file" name="boardFile" class="profile-file">
		<div class="profile-group">
			<span class="profile-group-span"><i></i></span>
			<input type="text" class="profile-search-form1" disabled placeholder="파일을 선택해주세요.">
			<span>
				<button class="profile-search" type="button"><i class=""></i>파일 찾기</button>
			</span>
		</div>
	</td>
</tr>
<tr>      
 <td colspan=2 bgcolor="<%=value_c%>" align="center"> 
  <input class="board-input-button" type="submit" value="글쓰기" >  
  <input class="board-input-button" type="reset" value="다시작성">
  <input class="board-input-button" type="button" value="목록보기" OnClick="window.location='boardFileList.jsp'">
</td></tr></table>    
 <%/*
  }catch(Exception e){}*/
%>     
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
		$(document).on('click', '.profile-search', function(){
			var file = $(this).parent().parent().parent().find('.profile-file');
			file.trigger('click');
		});
		$(document).on('change','.profile-file', function(){
			$(this).parent().find('.profile-search-form1').val($(this).val().replace(/C:\\fakepath\\/i, ''));
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
