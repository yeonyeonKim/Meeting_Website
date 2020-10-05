<%@ page language ="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*"%>
<%
Connection conn = null;
Statement stmt = null;
ResultSet rs = null;
try {
    Class.forName("com.mysql.jdbc.Driver");
    String jdbcurl = "jdbc:mysql://localhost:3306/webmeeting?serverTimezone=UTC&useSSL=false";
    conn = DriverManager.getConnection(jdbcurl, "root", "tmddus");
    stmt = conn.createStatement();
} catch (Exception e) {
    out.println("DB synchronization error : " + e.getMessage());
 }
 String id;
 id=request.getParameter("id");
 String fileName1 = request.getParameter("pPng");
 String originalName1 = request.getParameter("originalName1");
%>
<html>
<head>
   <title>두근두근 연결고리</title>
</head>
<body>
   <a href="main1.jsp?id=<%=id%>">
      <img src="logo.jpg" width="250" height="125">
   </a>

   <table border="1", align="center", width="98%">
      <thead>
         <tr>
            <th width="25%"><a href="main1.jsp?id=<%=id%>"> 미팅관리 </a></th>
            <th width="25%" bgcolor='FFD9EC'><a href="place.jsp?id=<%=id%>">장소추천</a></th>
            <th width="25%"><a href="meetingTip.jsp?id=<%=id%>">미팅의 정석</a></th>
            <th width="25%"><a href="mypage.jsp?id=<%=id%>">마이페이지</a></th>
         </tr>      
      </thead>
   </table>
   <br>

   <table border="1" width="21%" height="150px" align="left">
      <tr>
         <td align="center"><a href ="place.jsp?id=<%=id%>">Top10장소</a></td>
      </tr>
      <tr>
         <td align="center" bgcolor='FFD9EC'><a href ="place_recommend.jsp?id=<%=id%>">장소추천</a></td>
      </tr>
      <tr>
         <td align="center"><a href ="place_my.jsp?id=<%=id%>">나의 장소</a></td>
      </tr>
   </table>

   <form>
   <fieldset align="right">
   <%
      int pid, pScore = 0;
   
     String pName="", pAddr="", pPng="", pContent="";
      pid= Integer.parseInt(request.getParameter("pid"));
     
         String sql ="Select School.sh_name, Place.pl_name ,Place.pl_score,Place.pl_address,Place.pl_png,Place.pl_content From Place left outer join School on Place.sh_code = School.sh_code Where Place.pl_id='" + pid + "'";
         rs = stmt.executeQuery(sql);
      
      while(rs.next()){
         pName = "[" + rs.getString("School.sh_name") + "] " + rs.getString("Place.pl_name");
         pScore = rs.getInt("Place.pl_score");
         pAddr = rs.getString("Place.pl_address");
         pPng = rs.getString("Place.pl_png");
         pContent = rs.getString("Place.pl_content");
      }
      %>
      <h1 align="left"><%=pName %> <% for(int i = 0; i < pScore; i++) out.println("★"); for(int j = 0; j < 5 -  pScore; j++) out.println("☆"); %></h1>
      <fieldset align="left" height="550px">
      <img src="image/<%=pPng %>.jpg" width="500" height="500" align="left">
      [주소] <%=pAddr %><br><br>
      [설명] <%=pContent %>
       <br><br>
      </fieldset><br>
      <div  align="right">
      <input type="hidden" name="id" value="<%=id %>">
         <input type="submit" value="목록으로" formaction="place_recommend.jsp?id=<%=id%>">
      </div>
   </fieldset>
   </form>
</body>
</html>