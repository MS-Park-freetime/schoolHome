<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "board.BoardDBBean" %>
<%@ page import = "board.BoardDataBean" %>
<%@ page import = "java.util.List" %>
<%@ page import = "java.text.SimpleDateFormat" %>
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
<title>Insert title here</title>
<link href="css/stylesheet.css" type="text/css" rel="stylesheet" />
<script src="js/jquery-1.12.3.js" type="text/javascript"></script>
<script src="js/script.js" defer="defer" type="text/javascript"></script>
<script type="text/javascript">
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
</head>
<body>
<%!
	int pageSize = 5;
%>	
<%

       	SimpleDateFormat sdf = 
        	    new SimpleDateFormat("yyyy-MM-dd HH:mm");
       	int num = 0;
    	if(request.getParameter("num") != null){
    		num = Integer.parseInt(request.getParameter("num"));
    	}
       	String pageNum = request.getParameter("pageNum");
        if (pageNum == null) {
            pageNum = "1";
        }
        int currentPage = Integer.parseInt(pageNum);
        int startRow = (currentPage - 1) * pageSize + 1;
        int endRow = currentPage * pageSize;
        int count = 0;
        int number=0;

        List articleList = null;
        BoardDBBean bdbb = BoardDBBean.getInstance();
        count = bdbb.getArticleCount();
        if (count > 0) {
            articleList = bdbb.getArticles(startRow, pageSize);
        }

    	number=count-(currentPage-1)*pageSize;
	%>
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

	<div id="imageslide" class="all">
		<div class="imgs">
			<ul id="slides">
				<li><img src="images/sc11.jpg" alt="no"></li>
				<li><img src="images/sc33.jpg" alt="no"></li>
				<li><img src="images/sc22.jpg" alt="no"></li>
				<li><img src="images/sc55.jpg" alt="no"></li>
				<li><img src="images/sc44.jpg" alt="no"></li>
			</ul>
			<div class="welcome">
				<h2>
					<span>대구대학교 셔틀버스 홈페이지</span>
				</h2>
			</div>
			<div id="btn_slides">
				<a href="#" class="btn_slides_prev off">이전</a> <a href="#"
					class="btn_slides_next">다음</a>
			</div>
		</div>
	</div>
	<div class="clear"></div>



	<!-- <div id="imageslide" class="wrap">
  <div id="imgs">
    <img src="images/sc11.jpg" alt=""/>
    <img src="images/sc33.jpg" alt=""/>
    <img src="images/sc22.jpg" alt=""/>
    <img src="images/sc44.jpg" alt=""/>
    <img src="images/sc55.jpg" alt=""/>  
  </div>
  <ul id="imgsbar">
      <li>
      <a href="#" class="active" img-left="0px">
      <img src="images/button/dot.png" alt="no" />
      </a>
      </li>
      <li>
      <a href="#" img-left="0px">
      <img src="images/button/dot.png" alt="no" />
      </a>
      </li>
      <li>
      <a href="#" img-left="0px">
      <img src="images/button/dot.png" alt="no" />
      </a>
      </li>
      <li>
      <a href="#" img-left="0px">
      <img src="images/button/dot.png" alt="no" />
      </a>
      </li>
      <li>
      <a href="#" img-left="0px">
      <img src="images/button/dot.png" alt="no" />
      </a>				
      </li>        
  </ul>
  <div class="welcome">
      <h2>대구대학교 셔틀버스 홈페이지</h2> 
  </div>  
</div>
<div class="clear"></div>

</div>
<div class="clear"></div> -->

	<div id="contents" class="wrap">
		<div class="contentBox">
			<div class="notice">
				<div class="more_view_title">
				<span class="font_inline">공지사항</span>
				<a href="notice/notice.jsp"><span class="font_inline_right">더보기</span></a>
				</div>
				<table class="table">
					<tr>
						<th class="table_content_rate">내용</th>
						<th>날짜</th>
					</tr>
					<tr>
						<td class="table_content_rate"><a href="#">공지사항 제작중</a></td>
						<td></td>
					</tr>
					<tr>
						<td class="table_content_rate"><a href="#">공지사항 제작중</a></td>
						<td>2019-01-20</td>
					</tr>
					<tr>
						<td class="table_content_rate"><a href="#">공지사항 제작중</a></td>
						<td>2019-01-03</td>
					</tr>
					<tr>
						<td class="table_content_rate"><a href="#">공지사항 제작중</a></td>
						<td>2018-12-24</td>
					</tr>
					<tr>
						<td class="table_content_rate"><a href="#">공지사항 제작중</a></td>
						<td>2018-11-17</td>
					</tr>
				</table>
			</div>

			<div class="partner">
				<div class="more_view_title">
				<span class="font_inline">학생게시판</span>
				<a href="board/list.jsp"><span class="font_inline_right">더보기</span></a>
				</div>
				<table class="table">
					<tr>
						<th class="table_content_rate">내용</th>
						<th>날짜</th>
					</tr>
					<%  
  					      for (int i = 0 ; i < articleList.size() ; i++) {
          						BoardDataBean article = (BoardDataBean)articleList.get(i);
					%>		
					<tr>
						<td class="table_content_rate"><a href="board/content.jsp?num=<%=article.getNum()%>&pageNum=<%=currentPage%>"><%=article.getSubject() %></a></td>
						<td><%=article.getReg_date() %></td>
					</tr>
					<%
  					      }
					%>
				</table>
			</div>

			<!-- 	<div class="icon">
					<div class="icons">
						<div class="imgbtn">
							<button onClick="winOpen();">학생</button>
						</div>
						<div class="imgbtn">
							<button onClick="winOpen();">관리자</button>
						</div>
						<div class="imgbtn">
							<button onClick="winOpen();">운전자</button>
						</div>
					</div>
				</div> -->

				<div class="box">
				<div class="box_faster_menu">
				<h2>빠른메뉴</h2>
				<h5>이용자 주요서비스를 한눈에 확인하세요.</h5>
				</div>
					<div class="box_faster">
						<div class="faster_img">
							<a href="#"><img src="images/icons/data.png" alt="data"
								width="40px" height="102px"></a><br>
							<h6>데이터</h6>
						</div>
						<div class="faster_img">
							<a href="#"><img src="images/icons/login.png" alt="login"
								width="40px" height="102px"></a>
							<h6>로그인</h6>
						</div>
						<div class="faster_img">
							<a href="#"><img src="images/icons/money.png" alt="money"
								width="40px" height="102px"></a>
							<h6>포인트</h6>
						</div>
						<div class="faster_img">
							<a href="#"><img src="images/icons/nfc.png" alt="NFC"
								width="40px" height="102px"></a>
							<h6>NFC</h6>
						</div>
						<div class="faster_img">
							<a href="#"><img src="images/icons/portfolio.png"
								alt="portfolio" width="40px" height="102px"></a>
							<h6>포트폴리오</h6>
						</div>
					</div>
				</div>
		</div>
		<div class="clear"></div>
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
</body>
</html>