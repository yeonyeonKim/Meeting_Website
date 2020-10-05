<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
Connection conn = null;
PreparedStatement stmt = null;
ResultSet rs = null;
int totalRecord = 0;

String id;
id=request.getParameter("id");
   try {
      Class.forName("com.mysql.jdbc.Driver");
      String jdbcurl = "jdbc:mysql://localhost:3306/webmeeting?serverTimezone=UTC&useSSL=false";
      conn = DriverManager.getConnection(jdbcurl, "root", "tmddus");
      String sql = "select count(*) cnt from Meeting where us_id='"+id+"'";
      stmt = conn.prepareStatement(sql);
     rs = stmt.executeQuery();
     rs.next();
     totalRecord = rs.getInt(1);

   } catch (Exception e) {
      out.println("DB synchronization error : " + e.getMessage());
   }
   
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
	<a href="main1.jsp?id=<%=id%>"> <img src="logo.jpg" width="250" height="125">
	</a>

	<table border="1" , align="center" , width="98%">
		<thead>
			<tr>
				<th width="25%" bgcolor='FFD9EC'><a href="main1.jsp?id=<%=id %>">미팅관리</a></th>
				<th width="25%"><a href="place.jsp?id=<%=id %>">장소추천</a></th>
				<th width="25%"><a href="meetingTip.jsp?id=<%=id %>">미팅의 정석</a></th>
				<th width="25%"><a href="mypage.jsp?id=<%=id %>">마이페이지</a></th>
			</tr>
		</thead>
	</table>
	<br>

	<table border="1" width="21%" height="150px" align="left">
		<tr>
			<td align="center"><a href="main1.jsp?id=<%=id%>">인기 학교 순위</a></td>
		</tr>
		<tr>
			<td align="center"><a href="meeting_search.jsp?id=<%=id%>">미팅
					검색</a></td>
		</tr>
		<tr>
			<td align="center" bgcolor='FFD9EC'><a href="meeting_my.jsp?id=<%=id%>">나의 미팅</a></td>
		</tr>
	</table>

	<form method="get" onsubmit="true">
		<fieldset align="right">
			<h1 align="left">내가 쓴 글</h1>
			<br>

			<table border="1" , align="center" , width="90%" , height="25%">
				<thead>
					<tr>
						<th>선택</th>
						<th>No</th>
						<th>제목</th>
						<th>작성날짜</th>
					</tr>
				</thead>
		 <%
            int rownum=0;
            String page_sql="Select me_id, sh_name, me_title, me_write_date from (Select @ROWNUM := @ROWNUM + 1 ROWNUM, A.* from (Select Meeting.me_id, School.sh_name, Meeting.me_title, Meeting.me_write_date From (Meeting left outer join User on Meeting.us_id= User.us_id)left outer join School on School.sh_code=Meeting.sh_code Where User.us_id='"+id+"' Order by Meeting.me_write_date DESC) A, (select @ROWNUM := 0) R) M where ROWNUM between " + startRecord + " and " + endRecord;
            String mID="";
            String mMyID;
            
            stmt = conn.prepareStatement(page_sql);
         rs = stmt.executeQuery(page_sql);
         
            rs.last();
            rownum=rs.getRow();
            rs.beforeFirst();
            
            while(rs.next()){
               mID=rs.getString("me_id");
               java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
				java.text.SimpleDateFormat formatter2 = new java.text.SimpleDateFormat("yyyy-MM-dd");
				java.util.Date writedate = formatter.parse(rs.getString("me_write_date"));
				String write_date = formatter2.format(writedate);
            %>
            <tr>
               <td align="center"><input type="radio" id="mMyID" name="mMyID" checked="checked" value="<%=mID%>"></td>
               <% mMyID=request.getParameter("mMyID");%>
               <td align="center"><%=endRecord %></td>
               <td align="center"><a href="meeting_my_show.jsp?id=<%=id %>&me_id=<%=rs.getString("me_id")%>">[<%=rs.getString("sh_name")%>] <%=rs.getString("me_title")%></a></td>
               <td align="center"><%=write_date%></td>
            </tr>
            <%
               endRecord--;
            }
            %>
         </table>
         <br><br>
         
         <center>
         <%
               for(int i = 1; i <= totalPage; i++){
            %>
               [<a href="meeting_my.jsp?id=<%=id %>&curPage=<%=i%>"><%=i%></a>]&nbsp;
            <%
               }
            %>
         </center>


			<div align="right">
			<input type="hidden" name="id" value=<%=id %>>
				<input type="submit" value="수정"
					formaction="meeting_my_edit.jsp?id=<%=id %>&mMyID=">&nbsp;
				<input type="submit" value="삭제"
					formaction="/Webproject/index/hidden.jsp?id=<%=id%>">
			</div>
		</fieldset>
	</form>

</body>
</html>