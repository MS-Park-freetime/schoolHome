<%@page import="search.UserSearchDAO"%>
<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="user.GuestDAO" %>
<%@ page import="user.Guest" %>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<%
		String userID = null; //로그인을 한사람이라면 userID란 변수에 해당 아이디가 담기게 될거고 그렇지 않은 사람이라면 null값이 담기게된다.
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		if(userID == null){
			session.setAttribute("messageType", "오류메세지");
			session.setAttribute("messageContent", "로그인을 해주세요.");
			response.sendRedirect("../login/login.jsp");
			return;
		}
	/*	String emailChecked = new GuestDAO().getUserEmailChecked(userID);
		System.out.println(emailChecked);
		if(emailChecked.equals("FALSE")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = '../login/emailSendConfirm.jsp'");
			script.println("</script>");
			script.close();
		}*/
	%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../js/bootstrap.js"></script>
<script src="../js/script.js" defer="defer" type="text/javascript"></script>
<link href="../css/stylesheet.css" type="text/css" rel="stylesheet" />
<link rel="stylesheet" href="../css/copyupdatesheet.css">

<script type="text/javascript">
function findFunction(){
	var userID = $('#findName').val();
	$.ajax({
		type: "POST",
		url: '.././userFind',
		data: {userID: userID},
		success: function(result){
			if(result == -1){
				$('#checkMessage').html('회원을 찾을수 없습니다.');
				$('#checkType').attr('class','modal-content warning');
				failFriend();
			}else if(result == -2){
				$('#checkMessage').html('회원아이디를 입력해주세요.');
				$('#checkType').attr('class','modal-content warning');
				failFriend();
			}else{
				$('#checkMessage').html('회원찾기에 성공했습니다.');
				$('#checkType').attr('class','modal-content success');
				var data = JSON.parse(result);
				var profile = data.userProfile;
				getFriend(userID, profile);
			}
			$('#checkModal').modal("show");
		}
	});
}
function getFriend(findName, userProfile){
	$('#friendResult').html('<thead>' +
			'<tr>' +
			'<th class="find-title" colspan="2"><h3>회원 찾기</h3></th>' +
			'</tr>' +
			'</thead>' +
			'<tbody>' +
			'<tr>' +
			'<td class="find-body-title"><h5>회원 아이디</h5></td>' +	
			'<td class="find-body-title2">' +
			'<img class="find-profile-img" src="' + userProfile + '">' +
			'<span class="find-profile-id">' +
			findName +
			'</span>' +
			'<a href="../individualChatting.jsp?toID=' +
			encodeURIComponent(findName) +
			'" class="find-body-button">' +
			'메세지 보내기</a></td>' +
			'</tr>' +
			'</tbody>');
}
function failFriend(){
	$('#friendResult').html('');
}
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
<body>
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
					<li><a href="info.jsp">회원정보</a></li>
					<li><a href="loginSearch.jsp">|&nbsp;&nbsp;회원찾기</a></li>
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
					<li><a href="#">공지사항</a>
						<ul class="submenu">
							<li><a href="#">1-1</a></li>
							<li><a href="#">1-2</a></li>
							<li><a href="#">1-3</a></li>
							<li><a href="#">1-4</a></li>
						</ul></li>
					<li><a href="#">게시판</a>
						<ul class="submenu">
							<li><a href="../board/list.jsp">답글게시판</a></li>
							<li><a href="#">답변게시판</a></li>
							<li><a href="../boardNoname/nonameList.jsp">익명게시판</a></li>
							<li><a href="#">2-4</a></li>
						</ul></li>
					<li><a href="#">채팅방<span id="unread" class="unread-label"></span></a>
						<ul class="submenu">
							<li><a href="../anonymousChatting.jsp">익명채팅방</a></li>
							<li><a href="#">3-2</a></li>
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

	<div class="find">
		<table class="find-table">
			<thead>
				<tr>
					<th class="find-title" colspan="2"><h3>회원 찾기</h3></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="find-body-title"><h5>회원 아이디</h5></td>	
					<td class="find-body-title2"><input class="find-body-name" id="findName" placeholder="찾을 회원 아이디를 입력하세요." type="text" size="20"></td>
				</tr>
				<tr>
					<td colspan="2"><button class="find-body-button" onclick="findFunction()" type="button">검색</button></td>
				</tr>
			</tbody>
		</table>
	</div>
	<div class="find">
		<table id="friendResult" class="find-table">
			
		</table>
	</div>
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
	<script type="text/javascript">
		$('#messageModal').modal("show");
	</script>
<%
	session.removeAttribute("messageContent");
	session.removeAttribute("messageType");
	}
%>	
	<div class="modal fade topalign" id="checkModal" tableindex="-1" role="dialog" aria-hidden="true">
		<div class="modal-total-align">
			<div class="modal-dialog">
				<div id="checkType" class="modal-content modal-content-align">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">
							<span aria-hidden="true">&times</span>
							<span class="button-close">close</span>
						</button>
						<h4 class="modal-title">
							확인메세지
						</h4>
					</div>
					<div class="modal-body" id="checkMessage">
						
					</div>
					<div class="modal-footer">
						<button type="button" class="message-button" data-dismiss="modal">확인</button>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
