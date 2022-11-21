<%@page import="java.io.PrintWriter"%>
<%@page import="user.GuestDAO"%>
<%@page import="java.net.URLDecoder"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
		String userID = null; //로그인을 한사람이라면 userID란 변수에 해당 아이디가 담기게 될거고 그렇지 않은 사람이라면 null값이 담기게된다.
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		String toID = null;
		if(request.getParameter("toID") != null){
			toID = (String)request.getParameter("toID");
		}
		
		if(toID == null){
			session.setAttribute("messageType", "오류메세지");
			session.setAttribute("messageContent", "대화 상대가 지정되지 않았습니다.");
			response.sendRedirect("info/find.jsp");
			return;
		}
		
		if(userID.equals(URLDecoder.decode(toID, "UTF-8"))){
			session.setAttribute("messageType", "오류메세지");
			session.setAttribute("messageContent", "자신과는 대화를 할 수 없습니다.");
			response.sendRedirect("individualChattingBox.jsp");
			return;
		}
		String fromProfile = new GuestDAO().getProfile(userID);
		String toProfile = new GuestDAO().getProfile(toID);
%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/nonameChattingSheet.css">
<link href="css/stylesheet.css" type="text/css" rel="stylesheet" />
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<!-- <script src="js/jquery-1.12.3.js" type="text/javascript"></script>-->
<script src="js/bootstrap.js"></script>
<script src="js/script.js" defer="defer" type="text/javascript"></script>
<script type="text/javascript">
function autoClosingAlert(selector, delay) {
	var alert = $(selector).alert();
	alert.show();
	window.setTimeout(function() {alert.hide()}, delay);
}
function submitFunction(){
	var fromID = '<%=userID %>';
	var toID = '<%=toID %>';
	var individualContent = $('#individualContent').val();
	$.ajax({
		type: "POST",
		url: "./individualChatSubmit",
		data: {
			fromID: encodeURIComponent(fromID),
			toID: encodeURIComponent(toID),
			individualContent: encodeURIComponent(individualContent)
		},
		success: function(result){
			if(result == 1){
				autoClosingAlert('#successMessage', 2000);
			}else if(result == 0){
				autoClosingAlert('#cellMessage', 2000);
			}else{
				autoClosingAlert('#dangerMessage', 2000);
			}
		}
	});
	$('#individualContent').val("");
}
var lastID = 0;


function chatListFunction(type){
	var fromID = '<%=userID %>';
	var toID = '<%=toID %>';
	$.ajax({
		type: "POST",
		url: "./individualList",
		data: {
			fromID: encodeURIComponent(fromID),
			toID: encodeURIComponent(toID),
			listType: type
		},
		success: function(data){
			if(data == ""){
				return;
			}
			var parsed = JSON.parse(data);
			var result = parsed.result;
			for(var i = 0; i < result.length; i++){
				if(result[i][0].value == fromID){
					result[i][0].value = '나';
				}
				addChat(result[i][0].value, result[i][2].value, result[i][3].value);
			}
			lastID = Number(parsed.last);
		}
	});
}
function addChat(chatName, individualContent, individualTime){
	if(chatName == '나'){
		$('#chatList').append(
				'<div class="chat-body-content">' +
				'<div class="chat-body-profile">' +
				'<img src="<%=fromProfile%>" class="chat-profile-img">' +
				'</div>' +
				'<div class="chat-body-name">' +
				'<h4>' +
				chatName +
				'<span class="chat-clock">' +
				individualTime +
				'</span>' +
				'</h4>' +
				'<p>' +
				individualContent +
				'</p>' +
				'</div>' +
				'</div>'
		);
	} else{
		$('#chatList').append(
				'<div class="chat-body-content">' +
				'<div class="chat-body-profile">' +
				'<img src="<%=toProfile%>" class="chat-profile-img">' +
				'</div>' +
				'<div class="chat-body-name">' +
				'<h4>' +
				chatName +
				'<span class="chat-clock">' +
				individualTime +
				'</span>' +
				'</h4>' +
				'<p>' +
				individualContent +
				'</p>' +
				'</div>' +
				'</div>'
		);
	}
	$('#chatList').scrollTop($('#chatList')[0].scrollHeight);
}
$(document).ready(function(){
	getUnread();
	chatListFunction('0');
	getInfiniteChat();
});
function getInfiniteChat(){
	setInterval(function(){
		chatListFunction(lastID);
	}, 500);
}
function getUnread(){
	$.ajax({
		type: "POST",
		url: "./individualUnread",
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
<title>Insert title here</title>
</head>
<body>
<header class="all">
			<div class="header_box" class="all">
				<ul class="three_menu">
					<li><a href="index.jsp">처음으로&nbsp;|&nbsp;</a></li>
					<%
						if(userID == null){
					%>
					<li><a href="login/login.jsp">로그인&nbsp;&nbsp;</a></li>
					<%		
						}else{
					%>	
					<li><a href="login/logoutAction.jsp">로그아웃&nbsp;|&nbsp;</a></li>
					<li><a href="info/info.jsp">회원정보</a></li>
					<li><a href="info/loginSearch.jsp">|&nbsp;&nbsp;회원목록</a></li>
					<li><a href="info/find.jsp">|&nbsp;&nbsp;회원찾기</a></li>
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
				<a href="index.jsp"><img src="images/logo1.jpg" alt="대구대학교"> </a>
			</div>
			<nav>
				<ul class="nav">
					<li><a href="notice/notice.jsp">공지사항</a>
					<li><a href="#">게시판</a>
						<ul class="submenu">
							<li><a href="board/list.jsp">답글 게시판</a></li>
							<li><a href="#">답변게시판</a></li>
							<li><a href="boardNoname/nonameList.jsp">익명 게시판</a></li>
							<li><a href="boardFile/boardFileList.jsp">파일 게시판</a></li>
						</ul></li>
					<li><a href="#">채팅방<span id="unread" class="unread-label"></span></a>
						<ul class="submenu">
							<li><a href="anonymousChatting.jsp">익명채팅방</a></li>
							<li><a href="individualChattingBox.jsp">개인채팅방<span id="unread" class="unread-label"></span></a></li>
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
					<li><a href="evaluation/evaluationMain.jsp">평가하기</a>
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
	<div class="chat-div">
		<div class="chat-title-line">
			<h4 class="chat-title">개인채팅방</h4>	
		<div class="clear"></div>
		</div>
		<div id="chat" class="chat-body">
			<div id="chatList">
				
			</div>
		</div>
		<div class="clear"></div>
		<div class="chat-footer">
		<%
			if(userID == null){
		%>	
			<div class="chat-footer-box">
				<div class="individual-name-form-login"><a href="login/ajaxLogin.jsp">로그인</a>을 해주세요.</div>
			</div>
		
		<%
			}else{
		%>
			<div class="chat-footer-box">
				<div class="individual-name-form" id="chatName">
					<img src="<%=fromProfile %>" class="profile-img-size">
					<span class="individual-id"><%=userID %></span>
				</div>
			</div>
		<%
			}
		%>
			<div class="chat-footer-box">
				<div>
					<textarea id="individualContent" class="chat-content-form" placeholder="내용을 입력하세요." maxlength="100"></textarea>
				</div>
				<div class="chat-footer-button-align">
					<button type="button" onclick="submitFunction();" class="chat-content-submit">전송</button>
				</div>
			</div>			
		</div>
	<div id="successMessage" class="message-alert-success">
		<strong class="anony-message-align">메세지 전송이 완료되었습니다.</strong>
	</div>
	<div id="cellMessage" class="message-alert-cell">
		<strong class="anony-message-align">이름과 내용을 모두 입력해주세요.</strong>
	</div>
	<div id="dangerMessage" class="message-alert-danger">
		<strong class="anony-message-align">오류가 발생했습니다.</strong>
	</div>
</div>
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
	<script type="text/javascript">
		$('#messageModal').modal("show");
	</script>
<%
	session.removeAttribute("messageContent");
	session.removeAttribute("messageType");
	}
%>		

</body>
</html>