<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
   Connection conn = null;
   Statement stmt = null;
   ResultSet rs = null;
   java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
   String today = formatter.format(new java.util.Date());
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
   java.text.SimpleDateFormat formatter2 = new java.text.SimpleDateFormat("yyyyMMdd");
   java.text.SimpleDateFormat formatter3 = new java.text.SimpleDateFormat("yyyy-MM-dd");
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
            <th width="25%" bgcolor='FFD9EC'><a href="main1.jsp?id=<%=id%>">미팅관리</a></th>
            <th width="25%"><a href="place.jsp?id=<%=id%>">장소추천</a></th>
            <th width="25%"><a href="meetingTip.jsp?id=<%=id%>">미팅의 정석</a></th>
            <th width="25%"><a href="mypage.jsp?id=<%=id%>">마이페이지</a></th>
         </tr>
      </thead>
   </table>
   <br>

   <table border="1" width="21%" height="150px" align="left">
      <tr>
         <td align="center"><a href="main1.jsp?id=<%=id%>">인기 학교 순위</a></td>
      </tr>
      <tr>
         <td align="center" bgcolor='FFD9EC'><a href="meeting_search.jsp?id=<%=id%>">미팅 검색</a></td>
      </tr>
      <tr>
         <td align="center"><a href="meeting_my.jsp?id=<%=id%>">나의 미팅</a></td>
      </tr>
   </table>

   <form >
      <fieldset align="right">
         <%
            int me_id;
            String mTitle = "", mContent = "", mGender = "", mAvailable = "", mAge_from = "", mAge_to = "",
                  mWriter = "", mDeadline = "", mSchool = "", mAGender = "";
            me_id = Integer.parseInt(request.getParameter("me_id"));
            String deadline="";
            String mComName = "", mComCon = "", mComDate = "", mcomment; //comment
         %>
         <input type="hidden" name="accMeID" value="<%=me_id%>">
         <input type="hidden" name="comMeID" value="<%=me_id%>">
         <%
            String sql;
            
               sql = "Select School.sh_name, Meeting.me_title, Meeting.me_available_mf,Meeting.me_available_cnt,Meeting.me_age_from,Meeting.me_age_to,Meeting.me_deadline,Meeting.me_content,User.us_id From ((Meeting  left outer join School on School.sh_code=Meeting.sh_code)left outer join User on User.us_id=Meeting.us_id) Where Meeting.me_id='"
                     + me_id + "'";
               rs = stmt.executeQuery(sql);
            

            while (rs.next()) {
               mTitle = "[" + rs.getString("School.sh_name") + "]" + rs.getString("Meeting.me_title");
               mContent = rs.getString("Meeting.me_content");
               mGender = rs.getString("Meeting.me_available_mf");
               if (mGender.equals("f")) {
                  mGender = "여자";
               } else {
                  mGender = "남자";
               }
               mAvailable = rs.getString("Meeting.me_available_cnt");
               mAge_from = rs.getString("Meeting.me_age_from");
               mAge_to = rs.getString("Meeting.me_age_to");
               mDeadline = rs.getString("Meeting.me_deadline");
               mWriter = rs.getString("User.us_id");
               mSchool = rs.getString("School.sh_name");
               java.util.Date deadlinetemp = formatter2.parse(mDeadline);
               deadline = formatter3.format(deadlinetemp);
            }
         %>
         <br>
         <div align="left">
            &nbsp;
            <fieldset>
               <h3><%=mTitle%></h3>
            </fieldset>
         </div>
         <br> <br>
         <%
            int acccount = 0;
            String buttonable = "";
            String cbuttonable="";//comment
            try {
               sql = " Select count(Acceptance.ac_yesno='y') from Meeting left outer join Acceptance on Meeting.me_id=Acceptance.me_id where Meeting.me_id='"
                     + me_id + "' group by Acceptance.me_id";
               rs = stmt.executeQuery(sql);
            } catch (Exception e) {
               out.println("DB synchronization error : " + e.getMessage());
            }

            while (rs.next()) {
               acccount = Integer.parseInt(rs.getString("count(Acceptance.ac_yesno='y')"));
            }
            String userName = "", userId = "", userAge = "", userGender = "", userSchool = "";
            try {
               String userInfosql = "Select User.us_id, User.us_name,User.us_age,User.us_sex,University.uv_name from User left join University on User.uv_seq=University.uv_seq Where User.us_id='"+id+"'";
               rs = stmt.executeQuery(userInfosql);
            } catch (Exception e) {
               out.println("DB synchronization error : " + e.getMessage());
            }
            while (rs.next()) {
               userId = rs.getString("User.us_id");
               userName = rs.getString("User.us_name");
               userAge = rs.getString("User.us_age");
               userGender = rs.getString("User.us_sex");
               userSchool = rs.getString("University.uv_name");
            }
            try {
               String multiapplysql = "Select count(Acceptance.ac_id)as appcnt From (Acceptance left outer join Meeting on Meeting.me_id=Acceptance.me_id)left outer join User on User.us_id=Acceptance.us_id where Acceptance.me_id='"
                     + me_id + "' and User.us_id='"+id+"'";
               rs = stmt.executeQuery(multiapplysql);
            } catch (Exception e) {
               out.println("DB synchronization error : " + e.getMessage());
            }
            int mulappcnt=0;
            while(rs.next()){
               mulappcnt=Integer.parseInt(rs.getString("appcnt"));
            }
            //userId=request.getParameter(userId);
            if (mGender.equals("여자")) {
               mAGender = "f";
            } else {
               mAGender = "m";
            }
            if (Integer.parseInt(mAge_to) >= Integer.parseInt(userAge)
                  && Integer.parseInt(mAge_from) <= Integer.parseInt(userAge) && mAGender.equals(userGender)) {
               if (Integer.parseInt(today) <= Integer.parseInt(mDeadline) && mSchool.equals(userSchool)
                     && !userName.equals(mWriter)) {
                  if (acccount < Integer.parseInt(mAvailable)) {
                     buttonable = "abled";
                  } else {
                     buttonable = "disabled";
                  }
               } else {
                  buttonable = "disabled";
               }
            } else {
               buttonable = "disabled";
            }
            if (mulappcnt > 1) {
               buttonable = "disabled";
            }
         %>
         <input type="hidden" name="accUserId" value="<%=userId%>">
         <fieldset align="left">
            <br>&nbsp;모집 성별 :&nbsp;<%=mGender%><br> <br>&nbsp;모집
            인원 :&nbsp;<%=mAvailable%>명<br> <br>&nbsp;모집 나이 :&nbsp;<%=mAge_from%>
            이상
            <%=mAge_to%>이하<br> <br>&nbsp;마감일자 :&nbsp;<%=deadline%><br>
            <br>
         </fieldset>
         <br>
         <div align="left">

            <fieldset>
               <%=mContent%>
            </fieldset>

         </div>
         <br> <br>
         
         <div align="right">
            <input type="hidden" name="id" value=<%=id %>>
            <input type="submit" value="목록으로"
               formaction="meeting_search.jsp?id=<%=id %>" />&nbsp; <input
               type="submit" value="신청"
               formaction="/Webproject/index/hidden.jsp?id=<%=id %>" <%=buttonable%> />
         </div>
         </form>
         <form>
         <!-- comment -->
         <%
         try {
            String comment_sql = " Select User.us_name, Comment.ct_content, Comment.ct_write_date from (Comment left outer join User on User.us_id=Comment.us_id) left outer join Meeting on Meeting.me_id=Comment.me_id where Meeting.me_id='" + me_id + "' Order by Comment.ct_write_date DESC";
            rs = stmt.executeQuery(comment_sql);
         } catch (Exception e) {
            out.println("DB synchronization error : " + e.getMessage());
         }
         
         %>
         
         <br><br>
         <div align="left">
            <h3>[댓글]</h3>
            <table border="1" align="center" width="100%" height="10%">
                    <thead>
                        <tr>
                           <th>No</th>
                           <th>작성자</th>
                           <th>내용</th>
                           <th>작성날짜</th>
                        </tr>
                  </thead>
            <%
            	String comment_write="";
            int rownum=0;
            rs.last();
			rownum = rs.getRow();
			rs.beforeFirst();
               while (rs.next()) {
               mComName = rs.getString("User.us_name");
               mComCon = rs.getString("Comment.ct_content");
               mComDate = rs.getString("Comment.ct_write_date");
               java.util.Date commenttemp = formatter2.parse(mComDate);
               comment_write = formatter3.format(commenttemp);
            %>
            
            <tr>
                     <td align="center"><%=rownum%></td>
                     <td align="center"><%=mComName%></td>
                     <td align="center"><%=mComCon%></td>
                     <td align="center"><%=comment_write%></td>
               </tr>
               
            <%
            rownum--;
               }
            %>
            </table>
         </div>
            <br><br>
         <div align="left">
            <h3>[댓글 작성]</h3>
            <textarea id="mcomment" name="mcomment" cols="150" rows="3" placeholder="댓글을 입력해주세요"></textarea>&nbsp;
            <%
               mcomment = request.getParameter("mcomment");
            %>
            <input type="hidden" name="mcomment" value="<%=mcomment%>">
            
            <%
            if (Integer.parseInt(mAge_to) >= Integer.parseInt(userAge) && Integer.parseInt(mAge_from) <= Integer.parseInt(userAge) && mAGender.equals(userGender)) {
               if (Integer.parseInt(today) <= Integer.parseInt(mDeadline) && mSchool.equals(userSchool) && !userName.equals(mWriter)) {
                  if (acccount < Integer.parseInt(mAvailable)) {
                        cbuttonable = "abled";
                  }
                  else {
                        cbuttonable = "disabled";
                  }
               }
               else {
                        cbuttonable = "disabled";
               }
            }
            else {
                  cbuttonable = "disabled";
            }            
            %>
            <input type="hidden"  name="comment_me_id" value="<%=me_id%>">
             <input type="hidden" name="id" value=<%=id %>>
            <input type="submit" value="등록" formaction="/Webproject/index/hidden.jsp?id=<%=id %>" <%=cbuttonable %>/>   
         </div>
           </form>
      </fieldset>
 
</body>
</html>