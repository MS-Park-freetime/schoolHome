<%@ page contentType="text/html;charset=euc-kr" %>
<%@ include file="/view/color.jsp"%>


<html>
<head>
<%
  int num = Integer.parseInt(request.getParameter("num"));
  String pageNum = request.getParameter("pageNum");

%>
<% 
	String userID = null; //로그인을 한사람이라면 userID란 변수에 해당 아이디가 담기게 될거고 그렇지 않은 사람이라면 null값이 담기게된다.
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
%>	
<title>게시판</title>
<link href="../css/stylesheet.css" type="text/css" rel="stylesheet" />
<script src="../js/jquery-1.12.3.js" type="text/javascript"></script>
<script src="../js/script.js" defer="defer" type="text/javascript"></script>

<script language="JavaScript">      
<!--      
  function deleteSave(){	
	if(document.delForm.passwd.value==''){
	alert("비밀번호를 입력하십시요.");
	document.delForm.passwd.focus();
	return false;
 }
}    
// -->      
</script>
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
<center><b>글삭제</b>
<br>
<form method="POST" name="delForm"  action="nonameDeletePro.jsp?pageNum=<%=pageNum%>" 
   onsubmit="return deleteSave()"> 
 <table border="1" align="center" cellspacing="0" cellpadding="0" width="360">
  <tr height="30">
     <td align=center  bgcolor="<%=value_c%>">
       <b>비밀번호를 입력해 주세요.</b></td>
  </tr>
  <tr height="30">
     <td align=center >비밀번호 :   
       <input type="password" name="passwd" size="8" maxlength="12">
	   <input type="hidden" name="num" value="<%=num%>"></td>
 </tr>
 <tr height="30">
    <td align=center bgcolor="<%=value_c%>">
      <input type="submit" value="글삭제" >
      <input type="button" value="글목록" 
       onclick="document.location.href='nonameList.jsp?pageNum=<%=pageNum%>'">     
   </td>
 </tr>  
</table> 
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
	</script>
<%
	}
%>
</body>
</html> 
