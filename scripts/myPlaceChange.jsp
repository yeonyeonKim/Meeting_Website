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
} catch (Exception e) {
    out.println("DB synchronization error : " + e.getMessage());
 }
String id;
id=request.getParameter("id");
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
            <th width="25%" bgcolor='FFD9EC'><a href="place.jsp?id=<%=id%>">장소추천</a></th>
            <th width="25%"><a href="meetingTip.jsp?id=<%=id%>">미팅의 정석</a></th>
            <th width="25%"><a href="mypage.jsp?id=<%=id%>">마이페이지</a></th>
         </tr>
      </thead>
   </table>
   <br>

   <table border="1" width="21%" height="150px" align="left">
      <tr>
         <td align="center"><a href="place.jsp?id=<%=id%>">TOP 10 장소</a></td>
      </tr>
      <tr>
         <td align="center"><a href="place_recommend.jsp?id=<%=id%>">장소 추천</a></td>
      </tr>
      <tr>
         <td align="center" bgcolor='FFD9EC'><a href="place_my.jsp?id=<%=id%>">나의 장소</a></td>
      </tr>
   </table>

   <form>
      <fieldset align="right">
         <%
            String pMyName = "", pMySchoolName = "", pMyAddr = "", pMyPng = "", pMyContent = "", pMyScore = "";
            int pMyID;
            //int pMyScore = 0;

           
            //place_my.jsp에서 체크한 글의 id를 받아옴
            pMyID = Integer.parseInt(request.getParameter("pMyID"));
            
         %>
            <input type="hidden" name="pMyID" value="<%=pMyID%>">
         <%
          
               String sql = "Select School.sh_name, Place.pl_name ,Place.pl_score,Place.pl_address,Place.pl_png,Place.pl_content From Place left outer join School on Place.sh_code = School.sh_code Where Place.pl_id='" + pMyID + "'";
               rs = stmt.executeQuery(sql);
           
            while(rs.next()){
                  pMyName = rs.getString("Place.pl_name");
                  pMySchoolName = rs.getString("School.sh_name");
                  pMyScore = rs.getString("Place.pl_score");
                  //pMyScore = Integer.parseInt(rs.getString("Place.pl_score"));
                  pMyAddr = rs.getString("Place.pl_address");
                  pMyPng = rs.getString("Place.pl_png");
                  pMyContent = rs.getString("Place.pl_content");
               }
         %>

         <br>
         <div align="left">
            장소 이름 :&nbsp;<input type="text" id="pMyName" name="pMyName" size="100" value="<%=pMyName%>" /><br>
            <br>
            <%
               pMyName = request.getParameter("pMyName");
            %>
            <input type="hidden" name="pMyName" value="<%=pMyName%>">
            
            학교 이름 :  <select id="pMySchoolName" name="pMySchoolName">
                     <option value="가톨릭대학교" <%if(pMySchoolName.equals("가톨릭대학교")){%>selected<%}%>>가톨릭대학교</option>
                     <option value="건국대학교" <%if(pMySchoolName.equals("건국대학교")){%>selected<%}%>>건국대학교</option>
                     <option value="경기대학교" <%if(pMySchoolName.equals("경기대학교")){%>selected<%}%>>경기대학교</option>
                     <option value="경희대학교" <%if(pMySchoolName.equals("경희대학교")){%>selected<%}%>>경희대학교</option>
                     <option value="고려대학교" <%if(pMySchoolName.equals("고려대학교")){%>selected<%}%>>고려대학교</option>
                     <option value="광운대학교" <%if(pMySchoolName.equals("광운대학교")){%>selected<%}%>>광운대학교</option>
                     <option value="국민대학교" <%if(pMySchoolName.equals("국민대학교")){%>selected<%}%>>국민대학교</option>
                     <option value="덕성여자대학교" <%if(pMySchoolName.equals("성여자대학교")){%>selected<%}%>>덕성여자대학교</option>
                     <option value="동국대학교" <%if(pMySchoolName.equals("동국대학교")){%>selected<%}%>>동국대학교</option>
                     <option value="동덕여자대학교" <%if(pMySchoolName.equals("동덕여자대학교")){%>selected<%}%>>동덕여자대학교</option>
                     <option value="명지대학교" <%if(pMySchoolName.equals("명지대학교")){%>selected<%}%>>명지대학교</option>
                     <option value="상명대학교" <%if(pMySchoolName.equals("상명대학교")){%>selected<%}%>>상명대학교</option>
                     <option value="서강대학교" <%if(pMySchoolName.equals("서강대학교")){%>selected<%}%>>서강대학교</option>
                     <option value="서경대학교" <%if(pMySchoolName.equals("서경대학교")){%>selected<%}%>>서경대학교</option>
                     <option value="서울대학교" <%if(pMySchoolName.equals("서울대학교")){%>selected<%}%>>서울대학교</option>
                     <option value="서울과학기술대학교" <%if(pMySchoolName.equals("서울과학기술대학교")){%>selected<%}%>>서울과학기술대학교</option>
                     <option value="서울교육대학교" <%if(pMySchoolName.equals("서울교육대학교")){%>selected<%}%>>서울교육대학교</option>
                    <option value="서울여자대학교" <%if(pMySchoolName.equals("서울여자대학교")){%>selected<%}%>>서울여자대학교</option>
                     <option value="성균관대학교" <%if(pMySchoolName.equals("성균관대학교")){%>selected<%}%>>성균관대학교</option>
                     <option value="성신여자대학교" <%if(pMySchoolName.equals("성신여자대학교")){%>selected<%}%>>성신여자대학교</option>
                     <option value="세종대학교" <%if(pMySchoolName.equals("세종대학교")){%>selected<%}%>>세종대학교</option>
                     <option value="숙명여자대학교" <%if(pMySchoolName.equals("숙명여자대학교")){%>selected<%}%>>숙명여자대학교</option>
                     <option value="숭실대학교" <%if(pMySchoolName.equals("숭실대학교")){%>selected<%}%>>숭실대학교</option>
                     <option value="연세대학교" <%if(pMySchoolName.equals("연세대학교")){%>selected<%}%>>연세대학교</option>
                     <option value="육군사관학교" <%if(pMySchoolName.equals("육군사관학교")){%>selected<%}%>>육군사관학교</option>
                     <option value="이화여자대학교" <%if(pMySchoolName.equals("이화여자대학교")){%>selected<%}%>>이화여자대학교</option>
                     <option value="중앙대학교" <%if(pMySchoolName.equals("중앙대학교")){%>selected<%}%>>중앙대학교</option>
                     <option value="한국외국어대학교" <%if(pMySchoolName.equals("한국외국어대학교")){%>selected<%}%>>한국외국어대학교</option>
                     <option value="한국체육대학교" <%if(pMySchoolName.equals("한국체육대학교")){%>selected<%}%>>한국체육대학교</option>
                     <option value="한성대학교" <%if(pMySchoolName.equals("한성대학교")){%>selected<%}%>>한성대학교</option>
                     <option value="한양대학교" <%if(pMySchoolName.equals("한양대학교")){%>selected<%}%>>한양대학교</option>
                  <option value="홍익대학교" <%if(pMySchoolName.equals("홍익대학교")){%>selected<%}%>>홍익대학교</option>
               </select><br><br>

            <%
               pMySchoolName = request.getParameter("pMySchoolName");
            %>
            <input type="hidden" name="pMySchoolName" value="<%=pMySchoolName%>">

            장소 주소 :&nbsp;<input type="text" id="pMyAddr" name="pMyAddr" size="100" value="<%=pMyAddr%>" /><br><br>
            <%
               pMyAddr = request.getParameter("pMyAddr");
            %>
            <input type="hidden" name="pMyAddr" value="<%=pMyAddr%>">
            
            장소 사진&nbsp;&nbsp;<input type="file" id="pMyPng" name="pMyPng" value="<%=pMyPng%>">  <font size="1" color="red">※ 장소 사진은 .jpg만 가능합니다.</font><br><br>
            <%
               pMyPng = request.getParameter("pMyPng");
            %>
            <input type="hidden" name="pMyPng" value="<%=pMyPng%>">

            장소 별점 :&nbsp; 
            <input type="radio" name="pMyScore" value="5" <%if(pMyScore.equals("5")){%>checked="checked"<%}%>>5점
            <input type="radio" name="pMyScore" value="4" <%if(pMyScore.equals("4")){%>checked="checked"<%}%>>4점
            <input type="radio" name="pMyScore" value="3" <%if(pMyScore.equals("3")){%>checked="checked"<%}%>>3점
            <input type="radio" name="pMyScore" value="2" <%if(pMyScore.equals("2")){%>checked="checked"<%}%>>2점 
            <input type="radio" name="pMyScore" value="1" <%if(pMyScore.equals("1")){%>checked="checked"<%}%>>1점 <br>
            <%
               pMyScore = request.getParameter("pMyScore");
            %>
            <input type="hidden" name="pMyScore" value="<%=pMyScore%>">
         
            <br> 장소 설명<br>
            <br>
            <textarea id="pMyContent" name="pMyContent" cols="150" rows="20">
<%=pMyContent%>
            </textarea>
            <%
               pMyContent = request.getParameter("pMyContent");
            %>
            <input type="hidden" name="pMyContent" value="<%=pMyContent%>">
            <br>
            <br>
         </div>
         <div align="right">
          <input type="hidden" name="id" value="<%=id %>">
            <input type="submit" value="목록으로" formaction="place_my.jsp?id=<%=id%> " />&nbsp;
            <input type="submit" value="수정"  formaction="/Webproject/index/hidden.jsp?id=<%=id%>">
         </div>
      </fieldset>
   </form>

</body>
</html>