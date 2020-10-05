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
			<td align="center"><a href="successReview.jsp?id=<%=id%>">성공 후기</a></td>
		</tr>
		<tr>
			<td align="center" bgcolor='FFD9EC'><a href="myReview.jsp?id=<%=id%>">내가 쓴 후기</a></td>
		</tr>
	</table>

	<form >
		<fieldset align="right">
			<%
		int rMyID;//체크한 글
      	
		String rMyTitle="",rMyContent="", rMyName="", rOppShoolName="";
		rMyID= Integer.parseInt(request.getParameter("rMyID"));
		%>
			<input type="hidden" name="rMyID" value="<%=rMyID %>">
			<%
      	try{
        	String sql1="Select School.sh_name,Review.rv_title,Review.rv_content,User.us_name From (((Review left outer join Meeting on Meeting.me_id=Review.me_id) left outer join School on School.sh_code= Meeting.sh_code)left outer join User on Review.us_id=User.us_id)left outer join Acceptance on Acceptance.us_id = User.us_id AND Acceptance.ac_yesno = 'y' AND Acceptance.me_id=Meeting.me_id Where Review.rv_id='"+rMyID+"'";
       		rs=stmt.executeQuery(sql1);
        }
catch(Exception e){
   out.println("DB synchronization error : " + e.getMessage());
}
while(rs.next()){
	rMyTitle=rs.getString("Review.rv_title");
	rMyContent=rs.getString("Review.rv_content");
	rMyName =rs.getString("User.us_name");
	rOppShoolName=rs.getString("School.sh_name");
}
      	%>
			<div align="left">
				<br> 상대 학교 <input type="text" name="OppschoolName"
					value="<%=rOppShoolName%>" disabled> 작성자 <input type="text"
					name="rMyName" value="<%=rMyName%>" disabled> <br> <br>
				제목 <input type="text" id="rMyTilte" name="rMyTitle" size="100%"
					value="<%=rMyTitle%>"><br> <br>
				<%rMyTitle=request.getParameter("rMyTitle"); %>
				<input type="hidden" name="rMyTitle" value="<%=rMyTitle%>">
				<textarea name="rMyContent" id="rMyContent" rows="20" cols="150"><%=rMyContent%>
         </textarea>
				<%rMyContent=request.getParameter("rMyConten"); %>
				<input type="hidden" name="rMyContent" value="<%=rMyContent%>">
			</div>
			<br> <br>
			<div align="right">
			<input type="hidden" name="id" value="<%=id %>">
				<input type="submit" value="목록으로"
					formaction="myReview.jsp?id=<%=id%>"> <input
					type="submit" value="수정" formaction="/Webproject/index/hidden.jsp?id=<%=id%>" >
			</div>
		</fieldset>
	</form>

</body>
</html>