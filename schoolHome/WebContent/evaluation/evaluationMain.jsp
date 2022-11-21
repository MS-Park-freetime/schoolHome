<%@page import="java.io.PrintWriter"%>
<%@page import="user.GuestDAO"%>
<%@page import="evaluation.EvaluationDTO"%>
<%@page import="user.Guest"%> 
<%@page import="evaluation.EvaluationDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.net.URLEncoder" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
		request.setCharacterEncoding("UTF-8");
		String lectureDivide = "전체";
		String searchType = "최신순";
		String search = "";
		int pageNumber = 0;
		if(request.getParameter("lectureDivide") != null){
			lectureDivide = request.getParameter("lectureDivide");
		}
		if(request.getParameter("searchType") != null){
			searchType = request.getParameter("searchType");
		}
		if(request.getParameter("search") != null){
			search = request.getParameter("search");
		}
		if(request.getParameter("pageNumber") != null){
			try{
				pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
			}catch(Exception e){
				System.out.println("페이지 번호 오류");
			}
		}
		String userName = null;
		if(request.getParameter("userName") != null){
			userName = request.getParameter("userName");
		}
		String evaluationID = null;
		if(request.getParameter("evaluationID") != null){
			evaluationID = request.getParameter("evaluationID");
		}
		String userID = null; //로그인을 한사람이라면 userID란 변수에 해당 아이디가 담기게 될거고 그렇지 않은 사람이라면 null값이 담기게된다.
		if(session.getAttribute("userID") != null){
			userID = (String) session.getAttribute("userID");
		}
		String emailChecked = new GuestDAO().getUserEmailChecked(userID);
		System.out.println(emailChecked);
		if(emailChecked.equals("FALSE")){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href = 'login/emailSendConfirm.jsp'");
			script.println("</script>");
			script.close();
		}
		
	%>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Insert title here</title>
<script src="../js/jquery.min.js"></script>
<script src="../js/popper.js"></script>
<script src="../js/bootstrap.min.js"></script>
<script src="../js/jquery-1.12.3.js" type="text/javascript"></script>
<script src="../js/script.js" defer="defer" type="text/javascript"></script>
<link rel="stylesheet" href="../css/stylesheet.css">
<link rel="stylesheet" href="../css/copyupdatesheet.css">
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
<div class="header-div">
	<div class="header-line">
		<a class="header-title" href="evaluationMain.jsp">평가하기</a>
		<form action="evaluationMain.jsp" method="get" class="search-form">
			<input type="text" name="search" class="evaluationsearch" placeholder="내용을 입력하세요." aria-label="Search">
			<button class="search-button" type="submit">검색</button>
		</form>
	</div>
</div>
<section class="contents">
	<form method="get" action="evaluationMain.jsp">
		<select name="lectureDivide" class="select-modal">
			<option value="전체">전체</option>
			<option value="전공" <% if(lectureDivide.equals("전공")) out.println("selected"); %>>전공</option>
			<option value="교양" <% if(lectureDivide.equals("교양")) out.println("selected"); %>>교양</option>
			<option value="기타" <% if(lectureDivide.equals("기타")) out.println("selected"); %>>기타</option>
		</select>
		<select name="searchType" class="select-modal">
			<option value="최신순">최신순</option>
			<option value="추천순" <% if(searchType.equals("추천순")) out.println("selected"); %>>추천순</option>
		</select>
		<input type="text" name="search" class="text-modal" placeholder="내용을 입력하세요.">
		<button class="button-modal1" type="submit">검색</button>
		<a class="button-modal2" data-toggle="modal" href="#registerModal">등록하기</a>
		<a class="button-modal-red" data-toggle="modal" href="#reportModal">신고</a>
	</form>
<%
	ArrayList<EvaluationDTO> evaluationList = new ArrayList<EvaluationDTO>();
	evaluationList = new EvaluationDAO().getList(lectureDivide, searchType, search, pageNumber);
	if(evaluationList != null){
		for(int i = 0; i < evaluationList.size(); i++){
			if(i == 5){
				break;
			}
			EvaluationDTO evaluationDTO = evaluationList.get(i);
%>	
	
	<div class="card">
		<div class="card-header">
			<div class="row">
				<div class="text-left">강의명: <%=evaluationDTO.getLectureName() %>&nbsp;<small>교수명: <%=evaluationDTO.getProfessorName() %></small></div>
				<div class="text-right">
					종합<span><%=evaluationDTO.getTotalScore() %></span>
				</div>
			</div>
		</div>
		<div class="card-body">
			<h5 class="card-title"><%=evaluationDTO.getEvaluationTitle() %> &nbsp; <small>(<%=evaluationDTO.getLectureYear() %>년 <%=evaluationDTO.getSemesterDivide() %>)</small></h5>
			<p class="card-text"><%=evaluationDTO.getEvaluationContent() %></p>
			<div class="row">
				<div class="text-body-left">
					성적<span class="span-color"><%=evaluationDTO.getCreditScore() %></span>
					강의<span class="span-color"><%=evaluationDTO.getLectureScore() %></span>
					<span class="span-green">(추천: <%=evaluationDTO.getLikeCount() %>) </span>
				</div>
				<div class="content-like">
					<a onclick="return confirm('추천하시겠습니까?')" href="evaluation/likeAction.jsp?evaluationID=<%=evaluationDTO.getEvaluationID() %>">추천</a>
					<%
						if(userID != null && userID.equals(evaluationDTO.getUserID())){
					%>
					<a onclick="return confirm('삭제하시겠습니까?')" href="evaluation/deleteAction.jsp?evaluationID=<%=evaluationDTO.getEvaluationID()%>">삭제</a>
					<%
						}
					%>
				</div>
			</div>
		</div>
	</div>
<%
		}
	}
%>
</section>

<ul class="pageform">
	<li class="page-item">
<%
	if(pageNumber <= 0){
%>
 	<a class="page-link disabled">이전</a>
<% 
	}else{
%>		
	<a class="page-link" href="evaluationMain.jsp?lectureDivide=<%=URLEncoder.encode(lectureDivide, "UTF-8") %>&searchType=
	<%=URLEncoder.encode(searchType, "UTF-8") %>&search=<%=URLEncoder.encode(search, "UTF-8") %>&pageNumber=<%=pageNumber - 1 %>">이전</a>
<%
	}
%>	
	</li>
	<li class="page-item">
<%
	if(evaluationList.size() < 6){
%>
 	<a class="page-link disabled">다음</a>
<% 
	}else{
%>		
	<a class="page-link" href="evaluationMain.jsp?lectureDivide=<%=URLEncoder.encode(lectureDivide, "UTF-8") %>&searchType=
	<%=URLEncoder.encode(searchType, "UTF-8") %>&search=<%=URLEncoder.encode(search, "UTF-8") %>&pageNumber=<%=pageNumber + 1 %>">다음</a>
<%
	}
%>	
	</li>
	
</ul>
<div class="modal fade" id="registerModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="modal">평가 등록</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">			
				<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form action="evaluationRegisterAction.jsp" method="post">
					<div class="form-row">
						<div class="form-group col-sm-4">
							<label>강의명</label>
							<input type="text" name="lectureName" class="form-control" maxlength="20">  
						</div>
						<div class="form-group col-sm-4">
							<label>교수명</label>
							<input type="text" name="professorName" class="form-control" maxlength="20">  
						</div>
					</div>
					<div class="form-row">
						<div class="form-group col-sm-3">
							<label>수강 연도</label>
							<select name="lectureYear" class="form-control">
								<option value="2007">2007</option>
								<option value="2008">2008</option>
								<option value="2009">2009</option>
								<option value="2010">2010</option>
								<option value="2011">2011</option>
								<option value="2012">2012</option>
								<option value="2013">2013</option>
								<option value="2014">2014</option>
								<option value="2015">2015</option>
								<option value="2016">2016</option>
								<option value="2017">2017</option>
								<option value="2018">2018</option>
								<option value="2019">2019</option>
								<option value="2020">2020</option>
								<option value="2021">2021</option>
								<option value="2022">2022</option>
								<option value="2023">2023</option>
								<option value="2024">2024</option>
								<option value="2025">2025</option>
								<option value="2026">2026</option>
								<option value="2027">2027</option>
								<option value="2028">2028</option>
								<option value="2029">2029</option>
								<option value="2030">2030</option>
								<option value="2031">2031</option>
								<option value="2032">2032</option>
								<option value="2033">2033</option>
							</select>
						</div>
						<div class="form-group col-sm-3">
							<label>수강 학기</label>
							<select name="semesterDivide" class="form-control">
								<option value="1학기" selected>1학기</option>
								<option value="여름계절학기">여름계절학기</option>
								<option value="2학기">2학기</option>
								<option value="겨울계절학기">겨울계절학기</option>
							</select>
						</div>
						<div class="form-group col-sm-3">
							<label>강의 구분</label>
							<select name="lectureDivide" class="form-control">
								<option value="전공" selected>전공</option>
								<option value="교양" selected>교양</option>
								<option value="기타" selected>기타</option>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label>제목</label>
						<input type="text" name="evaluationTitle" class="form-control" maxlength="30">
					</div>
					<div class="form-group">
						<label>내용</label>
						<textarea name="evaluationContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
					</div>
					<div class="form-row">
						<div class="form-group col-sm-3">
							<label>평점</label>
							<select name="totalScore" class="form-control">
								<option value="A" selected>A</option>
								<option value="B">B</option>
								<option value="C">C</option>
								<option value="D">D</option>
								<option value="F">F</option>
							</select>
						</div>
						<div class="form-group col-sm-3">
							<label>성적</label>
							<select name="creditScore" class="form-control">
								<option value="A" selected>A</option>
								<option value="B">B</option>
								<option value="C">C</option>
								<option value="D">D</option>
								<option value="F">F</option>
							</select>
						</div>
						<div class="form-group col-sm-3">
							<label>강의</label>
							<select name="lectureScore" class="form-control">
								<option value="A" selected>A</option>
								<option value="B">B</option>
								<option value="C">C</option>
								<option value="D">D</option>
								<option value="F">F</option>
							</select>
						</div>
					</div>
					<div class="modal-footer">
						<button type="submit" class="button-modal3">등록하기</button>
						<button type="button" class="button-modal2" data-dismiss="modal">취소</button>
					</div>
				</form>
			</div>
		</div>
	</div>
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

<div class="modal fade" id="reportModal" tabindex="-1" role="dialog" aria-labelledby="modal" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="modal">신고하기</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">			
				<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form action="reportAction.jsp" method="post">
					<div class="form-group">
						<label>신고 제목</label>
						<input type="text" name="reportTitle" class="form-control" maxlength="30">
					</div>
					<div class="form-group">
						<label>신고 내용</label>
						<textarea name="reportContent" class="form-control" maxlength="2048" style="height: 180px;"></textarea>
					</div>
					<div class="modal-footer">
						<button type="submit" class="button-modal-red1">신고하기</button>
						<button type="button" class="button-modal2" data-dismiss="modal">취소</button>
					</div>
				</form>
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