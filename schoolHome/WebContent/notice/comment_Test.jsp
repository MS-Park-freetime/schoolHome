<%@page import="notice.NoticeCommentDTO"%>
<%@page import="notice.NoticeCommentDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="../css/stylesheet.css" type="text/css" rel="stylesheet" />
<script src="http://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="../js/bootstrap.js"></script>
<title>Insert title here</title>
</head>
<body>
<%
	String userID = null; //로그인을 한사람이라면 userID란 변수에 해당 아이디가 담기게 될거고 그렇지 않은 사람이라면 null값이 담기게된다.
	if(session.getAttribute("userID") != null){
		userID = (String) session.getAttribute("userID");
	}
%> 
<%
	if(userID == null){
%>
		<a href="../login/login.jsp">로그인&nbsp;&nbsp;</a>
<%		
	}else{
%>	
		<a href="../login/logoutAction.jsp">로그아웃&nbsp;|&nbsp;</a>
<% 	
	}
%>
    <div class="notice-comment">
    	<div id="comment" class="comment-body">
		</div>
		<div class="comment-footer">
			<div class="comment-footer-box">
				<div id="userID" class="comment-reply-userID">
				<!-- userID --><h4><%=userID %></h4>				
				</div>
				<div class="comment-content-form1" >
					<textarea id="comment_content" name="comment_content" class="comment-content-form" placeholder="내용을 입력하세요." maxlength="100"></textarea>
				</div>
				
				<div class="comment-footer-button-align">
					<button type="button" id="comment_button" class="comment-content-submit">등록</button>
				</div>
			</div>		
		</div>
	</div>
	<div id="successMessage" class="message-alert-success">
		<strong class="anony-message-align">댓글 등록이 완료되었습니다.</strong>
	</div>
	<div id="cellMessage" class="message-alert-cell">
		<strong class="anony-message-align">내용을 입력해주세요.</strong>
	</div>
	<div id="dangerMessage" class="message-alert-danger">
		<strong class="anony-message-align">오류가 발생했습니다.</strong>
	</div>
</body>
</html>