<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="reply.ReplyDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="reply" class="reply.Reply" scope="page"/>
<jsp:setProperty name="reply" property="replyContent" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>충북대 소프트웨어학과 과목별 게시판</title>
</head>
<body>
	 <%
      String userID = null;
      if(session.getAttribute("userID")!=null){
         userID=(String)session.getAttribute("userID");
      }
      
      if(userID==null){
         PrintWriter script=response.getWriter();
         script.println("<script>");
         script.println("alert('로그인을 하세요')");
         script.println("location.href='login.jsp'");
         script.println("</script>");
      }
          else{
             int bbsID = 0; 
             if (request.getParameter("bbsID") != null){
                bbsID = Integer.parseInt(request.getParameter("bbsID"));
             }
             
             if (bbsID == 0){
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('유효하지 않은 글입니다.')");
                script.println("location.href = 'login.jsp'");
                script.println("</script>");
             }
             if (reply.getReplyContent() == null){
                PrintWriter script = response.getWriter();
                script.println("<script>");
                script.println("alert('입력이 안된 사항이 있습니다.')");
                script.println("history.back()");
                script.println("</script>");
             } else {
                ReplyDAO replyDAO = new ReplyDAO();
                int result = replyDAO.write(bbsID, reply.getReplyContent(),userID);
                if (result == -1){
                   PrintWriter script = response.getWriter();
                   script.println("<script>");
                   script.println("alert('댓글 쓰기에 실패했습니다.')");
                   script.println("history.back()");
                   script.println("</script>");
                }
                else{
                   PrintWriter script = response.getWriter();
                   script.println("<script>");
                   script.println("location.href=document.referrer;");
                   script.println("</script>");
                }
                
             }
          }
       %>
</body>
</html>