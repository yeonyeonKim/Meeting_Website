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
	java.text.SimpleDateFormat formatter2 = new java.text.SimpleDateFormat("yyyyMMdd");
	   java.text.SimpleDateFormat formatter3 = new java.text.SimpleDateFormat("yyyy-MM-dd");
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
				<th width="25%"><a href="main1.jsp?id=<%=id%>">미팅관리 </a></th>
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

	<form>
	<fieldset align="right">
	<%
		int rv_id;
		String rTitle="",rContent="",rWriter="";
		rv_id= Integer.parseInt(request.getParameter("rv_id"));
		
			String sql ="Select School.sh_name,Review.rv_title,Review.rv_content,User.us_name From ((Review left outer join Meeting on Meeting.me_id=Review.me_id) left outer join School on School.sh_code= Meeting.sh_code)left outer join User on Review.us_id=User.us_id Where Review.rv_id='"+rv_id+"'";
			rs = stmt.executeQuery(sql);
		
		
		while(rs.next()){
			rTitle="["+rs.getString("School.sh_name")+"]"+rs.getString("Review.rv_title");
			rContent=rs.getString("Review.rv_content");
			rWriter=rs.getString("User.us_name");
		}
		%>
		<br><div align="left"><fieldset><h3><%=rTitle%></h3></fieldset></div><br>
		<fieldset align="left">작성자 : <%=rWriter%></fieldset><br>
		<fieldset align="left">
		<%=rContent %>
		</fieldset>
		<br>
		<div  align="right">
		<input type="hidden" name="id" value=<%=id %>>
			<input type="submit" value="목록으로" formaction="myReview.jsp?id=<%=id%>">
		</div>
		  <%
  String rComName = "", rComCon = "", rComDate = "", rcomment;
         try {
            String comment_sql = " Select User.us_name, Comment.ct_content, Comment.ct_write_date from (Comment left outer join User on User.us_id=Comment.us_id) left outer join Review on Review.rv_id=Comment.rv_id where Review.rv_id='" + rv_id + "' Order by Comment.ct_write_date DESC";
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
               rComName = rs.getString("User.us_name");
               rComCon = rs.getString("Comment.ct_content");
               rComDate = rs.getString("Comment.ct_write_date");
               java.util.Date commenttemp = formatter2.parse(rComDate);
               comment_write = formatter3.format(commenttemp);
            %>
            
            <tr>
                     <td align="center"><%=rownum%></td>
                     <td align="center"><%=rComName%></td>
                     <td align="center"><%=rComCon%></td>
                     <td align="center"><%=comment_write%></td>
               </tr>
               
            <%
           rownum--;
               }
            %>
            </table>
         </div>
	</fieldset>
	</form>

</body>
</html>