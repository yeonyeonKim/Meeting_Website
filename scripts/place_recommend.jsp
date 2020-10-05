<%@ page language ="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import = "java.sql.*" %>
<%
int totalRecord = 0; //전체 레코드 수
Connection conn = null;
PreparedStatement stmt = null;
ResultSet rs = null;
String sql = null;

try {
   Class.forName("com.mysql.jdbc.Driver");
   String jdbcurl = "jdbc:mysql://localhost:3306/webmeeting?serverTimezone=UTC&useSSL=false";
   conn = DriverManager.getConnection(jdbcurl, "root", "tmddus");
   sql = "select count(*) cnt from Place";
   stmt = conn.prepareStatement(sql);
   rs = stmt.executeQuery();
   rs.next();
   totalRecord = rs.getInt(1);

}
catch(Exception e){
   out.println("DB synchronization error : " + e.getMessage());
}
String id;
id=request.getParameter("id");
//paging
int numPerPage = 5; //한 페이지당 보일 레코드 수
int totalPage = 0; //전체 페이지 수
if(totalRecord != 0){
   if((totalRecord % numPerPage) == 0){
      totalPage = (totalRecord / numPerPage);
   }
   else{
      totalPage = (totalRecord / numPerPage + 1);
   }
}

int curPage = (request.getParameter("curPage") == null) ? 1 : Integer.parseInt(request.getParameter("curPage")); //현재 페이지 넘버
int startRecord = (curPage - 1) * numPerPage + 1; //시작 레코드
int endRecord = startRecord + numPerPage - 1; //마지막 레코드
if(endRecord > totalRecord) endRecord = totalRecord;

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
         <td align="center"><a href="place.jsp?id=<%=id%>">TOP 10 장소</a></td>
      </tr>
      <tr>
         <td align="center" bgcolor='FFD9EC'><a href="place_recommend.jsp?id=<%=id%>">장소 추천</a></td>
      </tr>
      <tr>
         <td align="center"><a href="place_my.jsp?id=<%=id%>">나의 장소</a></td>
      </tr>
   </table>

   <form>
      <fieldset align="right">
         <br>
         <center>
         <%
            String schoolName = request.getParameter("schoolName");
              if(schoolName == null)
                schoolName="";
            %>
            
            <form name="search" align="right" method = "get" action="place_recommend.jsp?id=<%=id%>" onsubmit="true"> 
            <h3>검색 할 학교&nbsp;<input type="text" name="schoolName" value="<%=schoolName %>" size="70" />
            <button type='submit'>조회</button></h3>
            </form>
         </center>
         <br><br>
         
         <table border="1" align="center" width="90%" height="45%">
            <thead>
               <tr>
                  <th>No</th>
                  <th>장소명</th>
                  <th>별점</th>
               </tr>
            </thead>
            <%
            int rownum=0;
            String pid;
            String page_sql = "";
            if(schoolName == ""){
                page_sql = "Select pl_id, sh_name, pl_name, pl_score from (Select @ROWNUM := @ROWNUM + 1 ROWNUM, A.* from (Select distinct Place.pl_id, School.sh_name, Place.pl_name, Place.pl_score From ((Place left outer join School on School.sh_code=Place.sh_code) left outer join University on School.sh_name=University.uv_name) left outer join User on University.uv_seq=User.uv_seq Order by Place.pl_score DESC) A, (select @ROWNUM := 0) R) M where ROWNUM between " + startRecord + " and " + endRecord;
             }
             else{
                page_sql = "Select pl_id, sh_name, pl_name, pl_score from (Select @ROWNUM := @ROWNUM + 1 ROWNUM, A.* from (Select distinct Place.pl_id, School.sh_name, Place.pl_name, Place.pl_score From ((Place left outer join School on School.sh_code=Place.sh_code) left outer join University on School.sh_name=University.uv_name) left outer join User on University.uv_seq=User.uv_seq Where School.sh_name like '%"+schoolName+"%' Order by Place.pl_score DESC) A, (select @ROWNUM := 0) R) M where ROWNUM between " + startRecord + " and " + endRecord;
             }
             
             //paging
                stmt = conn.prepareStatement(page_sql);
                rs = stmt.executeQuery();
               
                rs.last();
                rownum = rs.getRow();
                rs.beforeFirst();

             while(rs.next()) {
                pid=(rs.getString("pl_id"));
                
                if(schoolName != "") totalRecord = rownum;
                    
                   totalPage = 0; //전체 페이지 수
                    if(totalRecord != 0){
                        if((totalRecord % numPerPage) == 0){
                            totalPage = (totalRecord / numPerPage);
                        }
                        else{
                            totalPage = (totalRecord / numPerPage + 1);
                        }
                    }
            %>               
         <tr>
            <td align="center"><%=startRecord%></td>
            <td align="center"><a href = "place_recommend_show.jsp?id=<%=id %>&pid=<%=rs.getString("pl_id") %>">[<%=rs.getString("sh_name") %>] <%=rs.getString("pl_name") %></a></td>
            <td align="center"><% for(int i = 0; i < rs.getInt("pl_score"); i++) out.println("★"); for(int j = 0; j < 5 -  rs.getInt("pl_score"); j++) out.println("☆"); %></td>
         </tr>
         <%
               startRecord++;
            }
         %>
      </table>
      <br><br>
      
      <center>
         <%
            for(int i = 1; i <= totalPage; i++){
         %>
            [<a href="place_recommend.jsp?id=<%=id %>&curPage=<%=i%>"><%=i%></a>]&nbsp;
         <%
            }
         %>
         </center>


         <div align="right">
         <input type="hidden" name="id" value="<%=id %>">
         <input type="submit" value="새 글 작성"  formaction = "place_recommend_new.jsp?id=<%=id%>"/></div>
         
         <%
            stmt.close();
            conn.close();
         %>
      </fieldset>
   </form>

</body>
</html>