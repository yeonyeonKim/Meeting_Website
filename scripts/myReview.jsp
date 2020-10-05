<%@ page language ="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*"%>
<%
Connection conn = null;
PreparedStatement stmt = null;
ResultSet rs = null;
int totalRecord = 0;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcurl = "jdbc:mysql://localhost:3306/webmeeting?serverTimezone=UTC&useSSL=false";
		conn = DriverManager.getConnection(jdbcurl, "root", "tmddus");
		 String sql = "select count(*) cnt from Review where us_id='001'";
	      stmt = conn.prepareStatement(sql);
	      rs = stmt.executeQuery();
	      rs.next();
	      totalRecord = rs.getInt(1);
		
	} catch (Exception e) {
		out.println("DB synchronization error : " + e.getMessage());
	}
	String id;
	id=request.getParameter("id");
	  //paging
	   int numPerPage = 5; //한 페이지당 보일 레코드 수
	   int totalPage = 0; //전체 페이지 수
	   if (totalRecord != 0) {
	      if ((totalRecord % numPerPage) == 0) {
	         totalPage = (totalRecord / numPerPage);
	      } else {
	         totalPage = (totalRecord / numPerPage + 1);
	      }
	   }

	   int curPage = (request.getParameter("curPage") == null) ? 1 : Integer.parseInt(request.getParameter("curPage")); //현재 페이지 넘버
	   int startRecord = (curPage - 1) * numPerPage + 1; //시작 레코드
	   int endRecord = startRecord + numPerPage - 1; //마지막 레코드
	   if (endRecord > totalRecord)
	      endRecord = totalRecord;
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
				<th width="25%"><a href="place.jsp?id=<%=id%>">장소추천</a></th>
				<th width="25%" bgcolor='FFD9EC'><a href="meetingTip.jsp?id=<%=id%>">미팅의 정석</a></th>
				<th width="25%"><a href="mypage.jsp?id=<%=id%>">마이페이지</a></th>
			</tr>
		</thead>
	</table>
	<br>

	<table border="1" align="left" width="21%" height="150px">
		<tr>
			<td align="center"><a href ="meetingTip.jsp?id=<%=id%>">의상 추천</a></td>
		</tr>
		<tr>
			<td align="center"><a href ="successReview.jsp?id=<%=id%>">성공 후기</a></td>
		</tr>
		<tr>
			<td align="center" bgcolor='FFD9EC'><a href ="myReview.jsp?id=<%=id%>">내가 쓴 후기</a></td>
		</tr>
	</table>
	<form >
	<fieldset align="right">
		<h3 align="left">내가 쓴 후기 </h3>
			<br><br>
			<table border="1" align="center" width="100%" height="45%">
				<thead>
					<tr>
						<th width="10%">선택</th>
						<th width="10%">No</th>
						<th width="60%">제목</th>
						<th width="20%">작성 날짜</th>
					</tr>
				 </thead>
            <%
            String writedate="";
            int rownum=0;
            String page_sql="Select rv_id, sh_name, rv_title, rv_write_date from (Select @ROWNUM := @ROWNUM + 1 ROWNUM, A.* from (Select Review.rv_id, School.sh_name, Review.rv_title, Review.rv_write_date From ((Review left outer join Meeting on Meeting.me_id=Review.me_id) left outer join User on User.us_id=Review.us_id) left outer join School on School.sh_code= Meeting.sh_code Where User.us_id='"+id+"' Order by Review.rv_write_date DESC) A, (select @ROWNUM := 0) R) M where ROWNUM between " + startRecord + " and " + endRecord;
            String rMyID, rMyDeleteID;
            String rID="";
            stmt = conn.prepareStatement(page_sql);
         rs = stmt.executeQuery(page_sql);
         
            rs.last();
            rownum=rs.getRow();
            rs.beforeFirst();
            
            while(rs.next()){
               rID=rs.getString("rv_id");
               java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
				java.text.SimpleDateFormat formatter2 = new java.text.SimpleDateFormat("yyyy-MM-dd");
				java.util.Date tempwrite= formatter.parse(rs.getString("rv_write_date"));
				writedate = formatter2.format(tempwrite);
            %>
            <tr>
               <td><center> <input type="radio" id="rMyID" checked="checked" name="rMyID" value="<%=rID%>"></center></td>
               <% rMyID=request.getParameter("rMyID");%>
               <td><center><%=endRecord %></center></td>
               <td><a href="myReview1.jsp?id=<%=id %>&rv_id=<%=rs.getString("rv_id")%>">[<%=rs.getString("sh_name")%>] <%=rs.getString("rv_title")%></a></td>
               <td><center><%=writedate %></center></td>
               
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
               [<a href="myReview.jsp?id=<%=id%>&curPage=<%=i%>"><%=i%></a>]&nbsp;
            <%
               }
            %>
       </center>

			<br>
			<div  align="right">
			<input type="hidden" name="id" value="<%=id %>">
				<input type="submit" value="수정" formaction="myReviewChange.jsp?id=<%=id%>&rv_id=">
				<input type="submit" value="삭제" formaction="/Webproject/index/hidden.jsp?id=<%=id%>">
			</div>
			
	</fieldset>
	</form>

</body>
</html>