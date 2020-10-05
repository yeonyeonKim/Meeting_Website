<%@ page language ="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*"%>
<%@page import="java.text.*"%>
 <%
            String mMyTitle = "", mMyPeople = "", mMyGender = "", mMyAge_to = "", mMyAge_from = "", mMyDeadline = "", mMySchool = "", mMyContent = "";
            int mMyID;
            Connection conn = null;
            Statement stmt = null;
            ResultSet rs = null;
            
            //place_my.jsp에서 체크한 글의 id를 받아옴
            mMyID = Integer.parseInt(request.getParameter("mMyID"));
            String id;
            id=request.getParameter("id");
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
			<td align="center" ><a href="meeting_search.jsp?id=<%=id%>">미팅
					검색</a></td>
		</tr>
		<tr>
			<td align="center" bgcolor='FFD9EC'><a href="meeting_my.jsp?id=<%=id%>">나의 미팅</a></td>
		</tr>
   </table>

   <form>
      <fieldset align="right">
      
        
            <input type="hidden" name="mMyID" value="<%=mMyID%>">
         <%
            try {
               Class.forName("com.mysql.jdbc.Driver");
               String jdbcurl = "jdbc:mysql://localhost:3306/webmeeting?serverTimezone=UTC&useSSL=false";
               conn = DriverManager.getConnection(jdbcurl, "root", "tmddus");
               stmt = conn.createStatement();
               String sql = "Select School.sh_name, Meeting.me_title, Meeting.me_available_mf,Meeting.me_available_cnt,Meeting.me_age_from,Meeting.me_age_to,Meeting.me_deadline,Meeting.me_content From Meeting  left outer join School on School.sh_code=Meeting.sh_code Where Meeting.me_id='" + mMyID + "'";
               rs = stmt.executeQuery(sql);
            } catch (Exception e) {
               out.println("DB synchronization error : " + e.getMessage());
            }
            while(rs.next()){
               mMyTitle = rs.getString("Meeting.me_title");
               mMyPeople = rs.getString("Meeting.me_available_cnt");
               mMyGender = rs.getString("Meeting.me_available_mf");
               mMyAge_from = rs.getString("Meeting.me_age_from");
               mMyAge_to = rs.getString("Meeting.me_age_to");
               mMyDeadline = rs.getString("Meeting.me_deadline");
               mMySchool = rs.getString("School.sh_name");
               mMyContent = rs.getString("Meeting.me_content");
                 
            }
            String myDeadline="";
            myDeadline=mMyDeadline;
            myDeadline=myDeadline.substring(0,4)+"-"+myDeadline.substring(4,6)+"-"+myDeadline.substring(6,8);
            mMyDeadline=myDeadline;
         %>
         
         <br>
            <div align="left">제목&nbsp;<input type="text" id="mMyTitle" name="mMyTitle" size="90%" value="<%=mMyTitle%>"/></div>
         <br>
         <%
               mMyTitle = request.getParameter("mMyTitle");
         %>
         <input type="hidden" name="mMyTitle" value="<%=mMyTitle%>">
         
         <br>
         <fieldset align="left">
            <br>&nbsp;모집 성별 :&nbsp;
            <%if(mMyGender.equals("m")){ %>
            <input type="radio" name="mMyGender" value="m" checked="checked">남성&nbsp;
               <input type="radio" name="mMyGender" value="f">여성&nbsp;
         <%}
         else if(mMyGender.equals("f")){ %>
             <input type="radio" name="mMyGender" value="m">남성&nbsp;
               <input type="radio" name="mMyGender" value="f" checked="checked">여성&nbsp;
         <%}%>
            <%
            mMyGender = request.getParameter("mMyGender");
         %>
         <input type="hidden" name="mMyGender" value="<%=mMyGender%>">
            
         <br><br>
            &nbsp;모집 인원 :&nbsp;
            <select id = "mMyPeople" name="mMyPeople">
               <option value="1" <%if(mMyPeople.equals("1")){%>selected<%}%>>1</option>
               <option value="2" <%if(mMyPeople.equals("2")){%>selected<%}%>>2</option>
                <option value="3" <%if(mMyPeople.equals("3")){%>selected<%}%>>3</option>
                <option value="4" <%if(mMyPeople.equals("4")){%>selected<%}%>>4</option>
                <option value="5" <%if(mMyPeople.equals("5")){%>selected<%}%>>5</option>    
            </select>
            <br><br>
            <%
            mMyPeople = request.getParameter("mMyPeople");
         %>
         <input type="hidden" name="mMyPeople" value="<%=mMyPeople%>">           
           
            &nbsp;모집 나이 :&nbsp;
            <select id="mMyAge_from" name="mMyAge_from">
            <option value="20" <%if(mMyAge_from.equals("20")){%>selected<%}%>>20</option>
                <option value="21" <%if(mMyAge_from.equals("21")){%>selected<%}%>>21</option>
                <option value="22" <%if(mMyAge_from.equals("22")){%>selected<%}%>>22</option>
                <option value="23" <%if(mMyAge_from.equals("23")){%>selected<%}%>>23</option>
                <option value="24" <%if(mMyAge_from.equals("24")){%>selected<%}%>>24</option>
                <option value="25" <%if(mMyAge_from.equals("25")){%>selected<%}%>>25</option>
                <option value="26" <%if(mMyAge_from.equals("26")){%>selected<%}%>>26</option>
                <option value="27" <%if(mMyAge_from.equals("27")){%>selected<%}%>>27</option>
                <option value="28" <%if(mMyAge_from.equals("28")){%>selected<%}%>>28</option>
                <option value="29" <%if(mMyAge_from.equals("29")){%>selected<%}%>>29</option>
                <option value="30" <%if(mMyAge_from.equals("30")){%>selected<%}%>>30</option>   
            </select> &nbsp;이상&nbsp;
            <%
            mMyAge_from = request.getParameter("mMyAge_from");
         %>
         <input type="hidden" name="mMyAge_from" value="<%=mMyAge_from%>">  
         
            <select id="mMyAge_to" name="mMyAge_to">
            <option value="20" <%if(mMyAge_to.equals("20")){%>selected<%}%>>20</option>
                <option value="21" <%if(mMyAge_to.equals("21")){%>selected<%}%>>21</option>
                <option value="22" <%if(mMyAge_to.equals("22")){%>selected<%}%>>22</option>
                <option value="23" <%if(mMyAge_to.equals("23")){%>selected<%}%>>23</option>
                <option value="24" <%if(mMyAge_to.equals("24")){%>selected<%}%>>24</option>
                <option value="25" <%if(mMyAge_to.equals("25")){%>selected<%}%>>25</option>
                <option value="26" <%if(mMyAge_to.equals("26")){%>selected<%}%>>26</option>
                <option value="27" <%if(mMyAge_to.equals("27")){%>selected<%}%>>27</option>
                <option value="28" <%if(mMyAge_to.equals("28")){%>selected<%}%>>28</option>
                <option value="29" <%if(mMyAge_to.equals("29")){%>selected<%}%>>29</option>
                <option value="30" <%if(mMyAge_to.equals("30")){%>selected<%}%>>30</option>
            </select> &nbsp;이하
            <br><br>
            <%
            mMyAge_to = request.getParameter("mMyAge_to");
         %>
         <input type="hidden" name="mMyAge_to" value="<%=mMyAge_to%>">  
          
            &nbsp;마감일자 :&nbsp;<input type="date" id="mMyDeadline" name="mMyDeadline" value="<%=mMyDeadline%>"><br><br>
           <%
               mMyDeadline = request.getParameter("mMyDeadline");
         %>
         <input type="hidden" name="mMyDeadline" value="<%=mMyDeadline%>">
            
            &nbsp;모집학교 :&nbsp;
            <select id="mMySchool" name="mMySchool">
               <option value="가톨릭대학교" <%if(mMySchool.equals("가톨릭대학교")){%>selected<%}%>>가톨릭대학교</option>
               <option value="건국대학교" <%if(mMySchool.equals("건국대학교")){%>selected<%}%>>건국대학교</option>
               <option value="경기대학교" <%if(mMySchool.equals("경기대학교")){%>selected<%}%>>경기대학교</option>
               <option value="경희대학교" <%if(mMySchool.equals("경희대학교")){%>selected<%}%>>경희대학교</option>
               <option value="고려대학교" <%if(mMySchool.equals("고려대학교")){%>selected<%}%>>고려대학교</option>
               <option value="광운대학교" <%if(mMySchool.equals("광운대학교")){%>selected<%}%>>광운대학교</option>
               <option value="국민대학교" <%if(mMySchool.equals("국민대학교")){%>selected<%}%>>국민대학교</option>
               <option value="덕성여자대학교" <%if(mMySchool.equals("성여자대학교")){%>selected<%}%>>덕성여자대학교</option>
               <option value="동국대학교" <%if(mMySchool.equals("동국대학교")){%>selected<%}%>>동국대학교</option>
               <option value="동덕여자대학교" <%if(mMySchool.equals("동덕여자대학교")){%>selected<%}%>>동덕여자대학교</option>
               <option value="명지대학교" <%if(mMySchool.equals("명지대학교")){%>selected<%}%>>명지대학교</option>
               <option value="상명대학교" <%if(mMySchool.equals("상명대학교")){%>selected<%}%>>상명대학교</option>
               <option value="서강대학교" <%if(mMySchool.equals("서강대학교")){%>selected<%}%>>서강대학교</option>
               <option value="서경대학교" <%if(mMySchool.equals("서경대학교")){%>selected<%}%>>서경대학교</option>
               <option value="서울대학교" <%if(mMySchool.equals("서울대학교")){%>selected<%}%>>서울대학교</option>
               <option value="서울과학기술대학교" <%if(mMySchool.equals("서울과학기술대학교")){%>selected<%}%>>서울과학기술대학교</option>
               <option value="서울교육대학교" <%if(mMySchool.equals("서울교육대학교")){%>selected<%}%>>서울교육대학교</option>
               <option value="서울여자대학교" <%if(mMySchool.equals("서울여자대학교")){%>selected<%}%>>서울여자대학교</option>
               <option value="성균관대학교" <%if(mMySchool.equals("성균관대학교")){%>selected<%}%>>성균관대학교</option>
               <option value="성신여자대학교" <%if(mMySchool.equals("성신여자대학교")){%>selected<%}%>>성신여자대학교</option>
               <option value="세종대학교" <%if(mMySchool.equals("세종대학교")){%>selected<%}%>>세종대학교</option>
               <option value="숙명여자대학교" <%if(mMySchool.equals("숙명여자대학교")){%>selected<%}%>>숙명여자대학교</option>
               <option value="숭실대학교" <%if(mMySchool.equals("숭실대학교")){%>selected<%}%>>숭실대학교</option>
               <option value="연세대학교" <%if(mMySchool.equals("연세대학교")){%>selected<%}%>>연세대학교</option>
               <option value="육군사관학교" <%if(mMySchool.equals("육군사관학교")){%>selected<%}%>>육군사관학교</option>
               <option value="이화여자대학교" <%if(mMySchool.equals("이화여자대학교")){%>selected<%}%>>이화여자대학교</option>
               <option value="중앙대학교" <%if(mMySchool.equals("중앙대학교")){%>selected<%}%>>중앙대학교</option>
               <option value="한국외국어대학교" <%if(mMySchool.equals("한국외국어대학교")){%>selected<%}%>>한국외국어대학교</option>
               <option value="한국체육대학교" <%if(mMySchool.equals("한국체육대학교")){%>selected<%}%>>한국체육대학교</option>
               <option value="한성대학교" <%if(mMySchool.equals("한성대학교")){%>selected<%}%>>한성대학교</option>
               <option value="한양대학교" <%if(mMySchool.equals("한양대학교")){%>selected<%}%>>한양대학교</option>
               <option value="홍익대학교" <%if(mMySchool.equals("홍익대학교")){%>selected<%}%>>홍익대학교</option>
            </select><br><br>
            <%
            mMySchool = request.getParameter("mMySchool");
         %>
         <input type="hidden" name="mMySchool" value="<%=mMySchool%>">  
         </fieldset><br>
         <div align="left">
           <textarea id="mMyContent" name="mMyContent" cols="150" rows="20">
<%=mMyContent%>
         </textarea>
         </div>
         <%
            mMyContent = request.getParameter("mMyContent");
         %>
         <input type="hidden" name="mMyContent" value="<%=mMyContent%>"> 
         <font size="2" color="red">※ 주의) 나이, 마감 일자를 제대로 입력하지 않으면 폼이 초기화됩니다.</font>
         <div align="right">
         	<input type="hidden" name="id" value="<%=id %>">
            <input type="submit" value="목록으로"  formaction = "meeting_my.jsp?id=<%=id%>" />&nbsp;
            <input type="submit" value="수정"  formaction="/Webproject/index/hidden.jsp?id=<%=id %>"/>
         </div>
      </fieldset>
   </form>
</body>
</html>