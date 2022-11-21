<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 웹사이트</title>
</head>
<body>
	<%
		session.invalidate(); //현재 이 페이지에 접속한 회원이 세션을 뺴앗기도록 만들어서 로그아웃을 시켜줌
	%>
	<script>location.href = '../index.jsp';</script>
</body>
</html>