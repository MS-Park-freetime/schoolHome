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
	if(userID != null){
		session.setAttribute("messageType", "오류메세지");
		session.setAttribute("messageContent", "로그인이 되어 있습니다.");
		response.sendRedirect("../index.jsp");
		return;
	}
%>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="../css/ajaxLoginSheet.css">
<link rel="stylesheet" href="../css/copyupdatesheet.css">
<link href="../css/stylesheet.css" type="text/css" rel="stylesheet" />
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../js/bootstrap.js"></script>
<script src="../js/script.js" defer="defer" type="text/javascript"></script>
<script type="text/javascript">
function registerCheckFunction(){
	var userID = $('#userID').val();
	$.ajax({
		type: 'POST',
		url: '.././userRegisterCheck',
		data: {userID: userID},
		success: function(result){
			if(result == 1){
				$('#checkMessage').html('사용할 수 있는 아이디입니다.');
				$('#checkType').attr('class', 'modal-content success');
			}else{
				$('#checkMessage').html('사용할 수 없는 아이디입니다.');
				$('#checkType').attr('class', 'modal-content warning');
			}
			$('#checkModal').modal("show");
		}
	})
}
function passwordCheckFunction(){
	var userPassword = $('#userPassword').val();
	var userPassword1 = $('#userPassword1').val();
	if(userPassword != userPassword1){
		$('#passwordCheckMessage').html('비밀번호가 서로 일치하지 않습니다.');			
	}else{
		$('#passwordCheckMessage').html('');	
	}
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
<title>Insert title here</title>
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
<div class="join-container">
	<form action=".././userRegister" method="post" class="join-form">
		<table class="join-table">
			<thead>
				<tr>
					<th colspan="3" class="join-title"><h3>회원가입</h3></th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td class="join-form-title"><h5>아이디</h5></td>
					<td><input class="join-idform-id" type="text" id="userID" name="userID" maxlength="20" placeholder="아이디를 입력해주세요.">
					<button class="join-form-button" onclick="registerCheckFunction();" type="button">아이디 중복체크</button></td>
				</tr>
				<tr>
					<td class="join-form-title"><h5>비밀번호</h5></td>
					<td colspan="2"><input class="join-idform" type="password" onkeyup="passwordCheckFunction();" id="userPassword" name="userPassword" maxlength="20" placeholder="비밀번호를 입력해주세요."></td>
				</tr>
				<tr>
					<td class="join-form-title"><h5>비밀번호 확인</h5></td>
					<td colspan="2"><input class="join-idform" type="password" onkeyup="passwordCheckFunction();" id="userPassword1" name="userPassword1" maxlength="20" placeholder="비밀번호를 한번 더 입력하세요.">
						<h5 style="color: red" id="passwordCheckMessage"></h5>
					</td>
				</tr>
				<tr>
					<td class="join-form-title"><h5>이름</h5></td>
					<td colspan="2"><input class="join-idform" type="text" id="userName" name="userName" maxlength="20" placeholder="이름을 입력해주세요."></td>
				</tr>
				<tr>
					<td class="join-form-title"><h5>나이</h5></td>
					<td colspan="2"><input class="join-idform" type="text" id="userAge" name="userAge" maxlength="20" placeholder="나이를 입력해주세요."></td>
				</tr>
				<tr>
					<td class="join-form-title"><h5>성별</h5></td>
					<td colspan="2">
						<div class="join-idform">
							<div data-toggle="buttons">
							<label>
								<input type="radio" name="userGender" autocomplete="off" value="남자" checked>남자
							</label>
							<label>
								<input type="radio" name="userGender" autocomplete="off" value="여자" checked>여자
							</label>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<td class="join-form-title"><h5>이메일</h5></td>
					<td colspan="2"><input class="join-idform" type="email" id="userEmail" name="userEmail" maxlength="50" placeholder="이메일을 입력해주세요."></td>
				</tr>
				<tr>
					<td colspan="3" style="text-align: right;"><input class="join-register" type="submit" value="회원가입"></td>
				</tr>
			</tbody>
		</table>
	</form>
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