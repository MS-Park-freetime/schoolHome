<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "boardFile.BoardFileDAO" %>
<%@ page import = "java.io.*" %>
<%@ page import = "java.text.*" %>
<%@ page import = "java.lang.*" %>
<%@ page import = "java.util.*" %>
<%@ page import = "java.net.*" %>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 웹사이트</title>
</head>
<body>
	<%
		request.setCharacterEncoding("UTF-8");
		int num = Integer.parseInt(request.getParameter("num"));
		if(num == 0){
			session.setAttribute("messageType", "오류메세지");
			session.setAttribute("messageContent", "접근할 수 없습니다.");
			response.sendRedirect("boardFileList.jsp");
			return;
		}
		String root = request.getSession().getServletContext().getRealPath("/");
		String savdPath = root + "upload";
		String fileName = "";
		String realFile = "";
		BoardFileDAO boardFileDAO = new BoardFileDAO();
		fileName = boardFileDAO.getFile(num);
		realFile = boardFileDAO.getRealFile(num);
		if(fileName.equals("") || realFile.equals("")){
			session.setAttribute("messageType", "오류메세지");
			session.setAttribute("messageContent", "접근할 수 없습니다.");
			response.sendRedirect("boardFileList.jsp");
			return;
		}
		InputStream in = null;
		OutputStream os = null;
		File file = null;
		boolean skip = false;
		String client = "";
		try{
			try{
				file = new File(savdPath, realFile);
				in = new FileInputStream(file);
			}catch(FileNotFoundException e){
				skip = true;
			}
			client = request.getHeader("User-Agent");
			response.reset();
			response.setContentType("application/octet-stream");
			response.setHeader("Content-Description", "JSP Generated Data");
			if(!skip){
				if(client.indexOf("MSIE") != -1){
					response.setHeader("Content-Disposition", "attachment; filename=" + new String(fileName.getBytes("KSC5601"), "IOS8859_1"));
				}else{
					fileName = new String(fileName.getBytes("UTF-8"), "iso-8859-1");
					response.setHeader("Content-Disposition", "attachment; filename=\"" + fileName + "\"");
					response.setHeader("Content-Type", "application/octet-stream; charset=UTF-8");
				}
				response.setHeader("Content-Length", "" + file.length());
				out.clear();
				out = pageContext.pushBody();
				os = response.getOutputStream();
				byte b[] = new byte[(int)file.length()];
				int leng = 0;
				while((leng = in.read(b)) > 0){
					os.write(b, 0, leng);
				}
			}else{
				response.setContentType("text/html; charset=UTF-8");
				out.println("<script>alert('파일을 찾을 수 없습니다.');history.back();</script>");
			}
			in.close();
			os.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	%>
</body>
</html>