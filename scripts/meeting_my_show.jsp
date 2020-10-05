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
	id = request.getParameter("id");
	 
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
	java.text.SimpleDateFormat formatter1 = new java.text.SimpleDateFormat("yyyy-MM-dd");
%>
<html>
<head>
<title>두근두근 연결고리</title>
</head>
<body>
	<a href="main1.jsp?id=<%=id%>"> <img src="logo.jpg" width="250"
		height="125">
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
			<td align="center"><a href="meeting_search.jsp?id=<%=id%>">미팅
					검색</a></td>
		</tr>
		<tr>
			<td align="center" bgcolor='FFD9EC'><a
				href="meeting_my.jsp?id=<%=id%>">나의 미팅</a></td>
		</tr>
	</table>

	<form action="/Webproject/index/hidden.jsp?id=<%=id%>">
		<fieldset align="right">
			<%
				int me_id;
				String mMyTitle = "", mMyContent = "", mOppGender = "", mMyAvailable = "", mMyAge_from = "", mMyAge_to = "",
						mMyDeadline = "";
				String deadline = "";
				me_id = Integer.parseInt(request.getParameter("me_id"));

				String sql = "Select School.sh_name, Meeting.me_title, Meeting.me_content, Meeting.me_available_cnt,Meeting.me_available_mf,Meeting.me_age_from,Meeting.me_age_to,Meeting.me_deadline, User.us_name From (Meeting left outer join School on School.sh_code=Meeting.sh_code) left outer join User on Meeting.us_id=User.us_id Where Meeting.me_id='"
						+ me_id + "'";
				rs = stmt.executeQuery(sql);

				while (rs.next()) {
					mMyTitle = "[" + rs.getString("School.sh_name") + "]" + rs.getString("Meeting.me_title");
					mMyContent = rs.getString("Meeting.me_content");
					mOppGender = rs.getString("Meeting.me_available_mf");
					if (mOppGender.equals("f")) {
						mOppGender = "여자";
					} else {
						mOppGender = "남자";
					}
					mMyAvailable = rs.getString("Meeting.me_available_cnt");
					mMyAge_from = rs.getString("Meeting.me_age_from");
					mMyAge_to = rs.getString("Meeting.me_age_to");
					mMyDeadline = rs.getString("Meeting.me_deadline");
					java.util.Date tempdeadline = formatter.parse(mMyDeadline);
					deadline = formatter1.format(tempdeadline);
				}
			%>

			<br>
			<div align="left">
				&nbsp;
				<fieldset>
					<h3><%=mMyTitle%></h3>
				</fieldset>
			</div>
			<br>
			<fieldset align="left">
				<br>&nbsp;모집 성별 :&nbsp;<%=mOppGender%><br> <br>&nbsp;모집
				인원 :&nbsp;<%=mMyAvailable%>명<br> <br>&nbsp;모집 나이 :&nbsp;<%=mMyAge_from%>
				이상
				<%=mMyAge_to%>이하<br> <br>&nbsp;마감일자 :&nbsp;<%=deadline%><br>
				<br>
			</fieldset>
			<br>
			<div align="left">

				<fieldset>
					<%=mMyContent%>
				</fieldset>
			</div>
			<br>
			<div align="right">
				<input type="button" value="목록으로"
					onclick="location.href = 'meeting_my.jsp?id=<%=id%>' " />
			</div>
			<%
         String mComName = "", mComCon = "", mComDate = "", mcomment;
         try {
            String comment_sql = " Select User.us_name, Comment.ct_content, Comment.ct_write_date from (Comment left outer join User on User.us_id=Comment.us_id) left outer join Meeting on Meeting.me_id=Comment.me_id where Meeting.me_id='" + me_id + "' Order by Comment.ct_write_date DESC";
            rs = stmt.executeQuery(comment_sql);
         } catch (Exception e) {
            out.println("DB synchronization error : " + e.getMessage());
         }
         
         %>
         
         <br>
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
               java.util.Date commenttemp = formatter.parse(mComDate);
               comment_write = formatter1.format(commenttemp);
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
         <br>
			<h1 align="left">내가 받은 신청</h1>
			<br>

			<table border="1" align="center" width="100%" height="25%">
				<thead>
					<tr>
						<th>No</th>
						<th>이름</th>
						<th>나이</th>
						<th>수락</th>
						<th>거절</th>
					</tr>
				</thead>
				<%
					String appName = "", appAge = "", appId = "", acceptance_yesno = "";
					String checkYN;
					String[] checkarr = new String[100];
					String buttonable = "";
					int num = 0;
					int accnt = 0;
					try {
						String acceptancesql = "Select User.us_name, User.us_age, Acceptance.ac_id,Acceptance.ac_yesno ,count(Acceptance.ac_id) From User, Acceptance,Meeting Where User.us_id = Acceptance.us_id and Acceptance.me_id=Meeting.me_id and Meeting.me_id='"
								+ me_id + "'";
						rs = stmt.executeQuery(acceptancesql);
					} catch (Exception e) {
						out.println("DB synchronization error : " + e.getMessage());
					}
					while (rs.next()) {
						appName = rs.getString("User.us_name");
						appAge = rs.getString("User.us_age");
						appId = rs.getString("Acceptance.ac_id");
						acceptance_yesno = rs.getString("Acceptance.ac_yesno");
						num++;
						if (Integer.parseInt(rs.getString("count(Acceptance.ac_id)")) > 0) {
							if (acceptance_yesno.equals("y") || acceptance_yesno.equals("n")) {
								buttonable = "disabled";
							} else
								buttonable = "abled";
						
				%><input type="hidden" name="acceptanceMeId" value="<%=me_id%>">
				<input type="hidden" name="<%=num%>accID" value="<%=appId%>">
				<tr>
					<td align="center"><%=num%></td>
					<td align="center"><%=appName%></td>
					<td align="center"><%=appAge%></td>
					<td align="center"><input type="radio" id="accYN"
						name="<%=num%>accYN" value="y" <%=buttonable%>></td>
					<td align="center"><input type="radio" id="accYN"
						name="<%=num%>accYN" value="n" <%=buttonable%>></td>
					<%
						checkYN = request.getParameter(num + "accYN");
					%>
				</tr>
				<%
						}
						else buttonable = "disabled";
					}
					
				%>
			</table>
			<input type="hidden" name="accNo" value="<%=num%>">
			<div align="right">
				<input type="hidden" name="id" value=<%=id%>> <input
					type="submit" value="저장하기" <%=buttonable%>>
			</div>
		
         
		</fieldset>
	</form>

</body>
</html>