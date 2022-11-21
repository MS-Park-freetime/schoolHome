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
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.1.2.min.js"></script>
<script src="../js/jquery-1.12.3.js" type="text/javascript"></script>
<script src="../js/script.js" defer="defer" type="text/javascript"></script>
<link href="../css/stylesheet.css" type="text/css" rel="stylesheet" />


<script type="text/javascript">
	var request = new XMLHttpRequest();
	function searchFunction() {
		request.open("Post", ".././userSearch?userID=" + encodeURIComponent(document.getElementById("userID").value), true);
		request.onreadystatechange = searchProcess;
		request.send(null);
	}
	function searchProcess() {
		var table = document.getElementById("ajaxTable");
		table.innerHTML = "";
		if(request.readyState == 4 && request.status == 200){
			var object = eval('(' + request.responseText + ')');
			var result = object.result;
			for (var i = 0; i < result.length; i++) {
				var row = table.insertRow(0);
				for (var j = 0; j < result[i].length; j++) {
					var cell = row.insertCell(j);
					cell.innerHTML = result[i][j].value;
				}
			}
		}
	}
		window.onload = function(){
			searchFunction();
		}
</script>
</head>
<body>

<%
		String userID = null; //로그인을 한사람이라면 userID란 변수에 해당 아이디가 담기게 될거고 그렇지 않은 사람이라면 null값이 담기게된다.
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		String emailChecked = new GuestDAO().getUserEmailChecked(userID);
		System.out.println(emailChecked);
		if(emailChecked.equals("FALSE")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = '../login/emailSendConfirm.jsp'");
			script.println("</script>");
			script.close();
		}
	%>
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
					<li><a href="#">포인트</a>
						<ul class="submenu">
							<li><a href="#">3-1</a></li>
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

	<div class="search">
		<div class="search-right">
			<input class="search-right-text" id="userID" onkeyup="searchFunction()" type="text" size="20">
			
			<button class="search-right-button" onclick="searchFunction()" type="button">검색</button>
		</div>
	</div>
	<div class="table-box">
		<table class="table-ti">
			<thead>
				<tr>
					<th>아이디</th>
					<th>이름</th>
					<th>나이</th>
					<th>성별</th>
					<th>이메일</th>
				</tr>
			</thead>
			<tbody id="ajaxTable">
			</tbody>
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
</body>
</html>
