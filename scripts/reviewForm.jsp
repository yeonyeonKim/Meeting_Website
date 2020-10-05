<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
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
}
catch (Exception e) {
   out.println("DB synchronization error : " + e.getMessage());
}
String id;
id= request.getParameter("id") ;
%>
<html>
<head>
<title>두근두근 연결고리</title>
</head>
<body>
   <a href="main1.jsp?id=<%=id%>"> <img src="logo.jpg" width="250" height="125">
   </a>

   <table border="1" , align="center" , width="98%">
      <thead>
         <tr>
            <th width="25%"><a href="main1.jsp?id=<%=id%>"> 미팅관리 </a></th>
            <th width="25%"><a href="place.jsp?id=<%=id%>">장소추천</a></th>
            <th width="25%" bgcolor='FFD9EC'><a href="meetingTip.jsp?id=<%=id%>">미팅의 정석</a></th>
            <th width="25%"><a href="mypage.jsp?id=<%=id%>">마이페이지</a></th>
         </tr>
      </thead>
   </table>
   <br>

   <table border="1" align="left" width="21%" height="150px">
      <tr>
         <td align="center"><a href="meetingTip.jsp?id=<%=id%>">의상 추천</a></td>
      </tr>
      <tr>
         <td align="center" bgcolor='FFD9EC'><a href="successReview.jsp?id=<%=id%>">성공 후기</a></td>
      </tr>
      <tr>
         <td align="center"><a href="myReview.jsp?id=<%=id%>">내가 쓴 후기</a></td>
      </tr>
   </table>

   <form>
      <fieldset align="right">
         <div align="left">
            <%
               String rTitle, rContent;
               String rMeetingID;

                  String sql1 = "Select Meeting.me_id, School.sh_name, Meeting.me_write_date from (Meeting left outer join User on User.us_id = Meeting.us_id) left outer join School on School.sh_code = Meeting.sh_code where User.us_id='"+id+"'";
                  
                  rs = stmt.executeQuery(sql1);   
              
            %>
            
            상대 학교&nbsp;
            <select name="rMeetingID">
            <%
               while(rs.next()){
            %>
                  <option value="<%=rs.getInt("Meeting.me_id")%>"><%=rs.getString("Meeting.me_write_date") + " / " + rs.getString("School.sh_name")%></option>
            <%
               }
               rs.beforeFirst();
               try{
                  String sql2 = "Select Acceptance.me_id, School.sh_name, Meeting.me_write_date from ((Acceptance left outer join User on Acceptance.us_id = User.us_id AND Acceptance.ac_yesno = 'y') left outer join Meeting on Acceptance.me_id = Meeting.me_id) left outer join School on School.sh_code = Meeting.sh_code where User.us_id='"+id+"'";
                  rs = stmt.executeQuery(sql2);
               }
               catch (Exception e) {
                  out.println("DB synchronization error : " + e.getMessage());
               }
               while(rs.next()){
            %>
               <option value="<%=rs.getInt("Acceptance.me_id")%>"><%=rs.getString("Meeting.me_write_date") + " / " + rs.getString("School.sh_name")%></option>
            <%
               }
            %>
            </select><br>
            <%
               rMeetingID = request.getParameter("rMeetingID");
            %>
            <input type="hidden" name="rMeetingID" value="<%=rMeetingID%>">
            
            <br> 제목 <input type="text" id="rTitle" name="rTitle" size="100%" placeholder="제목을 입력해주세요."><br>
            <br>
            <%
               rTitle = request.getParameter("rTitle");
            %>
            <input type="hidden" name="rTitle" value="<%=rTitle%>">

            <textarea name="rContent" id="rContent" rows="20" cols="150" placeholder="내용을 입력해주세요."></textarea>
            <%
               rContent = request.getParameter("rContent");
            %>
            <input type="hidden" name="rContent" value="<%=rContent%>">
         </div>
         <br>
         <br>
         <div align="right">
         <input type="hidden" name="id" value="<%=id %>">
            <input type="submit" value="목록으로" formaction="successReview.jsp?id=<%=id%>">
            <input type="submit" value="등록" formaction="/Webproject/index/hidden.jsp?id=<%=id%>">
         </div>   
      </fieldset>
   </form>

</body>
</html>