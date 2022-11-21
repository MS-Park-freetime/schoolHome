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
%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="css/nonameChattingSheet.css">
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<link href="css/stylesheet.css" type="text/css" rel="stylesheet" />
<script src="js/jquery-1.12.3.js" type="text/javascript"></script>
<script src="js/script.js" defer="defer" type="text/javascript"></script>
<script type="text/javascript">
var lastID = 0;
function submitFunction(){
	var chatName = $('#chatName').val();
	var chatContent = $('#chatContent').val();
	$.ajax({
		type: "POST",
		url: "./chatSubmitServlet",
		data: {
			chatName: encodeURIComponent(chatName),
			chatContent: encodeURIComponent(chatContent)
		},
		success: function(result){
			if(result == 1){
				autoClosingAlert('#successMessage', 2000);
			}else if(result == 0){
				autoClosingAlert('#dangerMessage', 2000);
			}else{
				autoClosingAlert('#cellMessage', 2000);
			}
		}
	});
	$('#chatContent').val("");
}

function autoClosingAlert(selector, delay) {
	var alert = $(selector).alert();
	alert.show();
	window.setTimeout(function() {alert.hide()}, delay);
}

function chatListFunction(type){
	$.ajax({
		type: "POST",
		url: "./chatList",
		data: {
			listType: type
		},
		success: function(data){
			if(data == ""){
				return;
			}
			var parsed = JSON.parse(data);
			var result = parsed.result;
			for(var i = 0; i < result.length; i++){
				addChat(result[i][0].value, result[i][1].value, result[i][2].value);
			}
			lastID = Number(parsed.last);
		}
	});
	
}
function addChat(chatName, chatContent, chatTime){
	$('#chatList').append(
			'<div class="chat-body-content">' +
			'<div class="chat-body-profile">' +
			'<img src="images/profile.png" class="chat-profile-img">' +
			'</div>' +
			'<div class="chat-body-name">' +
			'<h4>' +
			chatName +
			'<span class="chat-clock">' +
			chatTime +
			'</span>' +
			'</h4>' +
			'<p>' +
			chatContent +
			'</p>' +
			'</div>' +
			'</div>'
	);
	$('#chatList').scrollTop($('#chatList')[0].scrollHeight);
}
$(document).ready(function(){
	chatListFunction('ten');
	getInfinitChat();
});
function getInfinitChat(){
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
			<h4 class="chat-title">익명채팅방</h4>	
		<div class="clear"></div>
		</div>
		<div id="chat" class="chat-body">
			<div id="chatList">
				
			</div>
		</div>
		<div class="clear"></div>
		<div class="chat-footer">
			<div class="chat-footer-box">
				<input type="text" id="chatName" class="chat-name-form" placeholder="이름" maxlength="20">
			</div>
			<div class="chat-footer-box">
				<div>
					<textarea id="chatContent" class="chat-content-form" placeholder="내용을 입력하세요." maxlength="100"></textarea>
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
			getUnread();
			getInfiniteUnread();
		});
	</script>
<%
	}
%>
</body>
</html>