<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs = null;
	int currnum = 0;
	int endnum = 0;
	int acceptancenum = 0;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		//String jdbc ="jdbc:mysql://localhost:3306/webmeeting";
		conn = DriverManager.getConnection(
				"jdbc:mysql://localhost:3306/webmeeting?serverTimezone=UTC&useSSL=false", "root", "tmddus");
		stmt = conn.createStatement();
	} catch (Exception e) {
		out.println(" 연동 오류입니다:" + e.getMessage());
	}
	String id;
	id = request.getParameter("id");
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
				<th width="25%"><a href="meetingTip.jsp?id=<%=id%>">미팅의 정석</a></th>
				<th width="25%" bgcolor='FFD9EC'><a href="mypage.jsp?id=<%=id%>">마이페이지</a></th>
			</tr>
		</thead>
	</table>
	<br>

	<table border="1" align="left" width="21%" height="150px">
		<tr>
			<td align="center" bgcolor='FFD9EC'><a href="mypage.jsp?id=<%=id%>">마이 페이지</a></td>
		</tr>
	</table>

	<form>
		<fieldset align="right">
			<h3 align="left">현재 진행중인 나의 미팅</h3>
			<fieldset align="left">
				<%
					String sql = "Select School.sh_name, Meeting.me_title From ((Meeting left outer join User on User.us_id=Meeting.us_id) left outer join Acceptance on Acceptance.me_id = Meeting.me_id and  Acceptance.ac_yesno='y' ) left outer join School on School.sh_code = Meeting.sh_code Where (User.us_id='"
							+ id + "' or Acceptance.us_id='" + id
							+ "') and Meeting.me_deadline >=  cast(curdate()as unsigned) Order by Meeting.me_deadline DESC";
					rs = stmt.executeQuery(sql);

					while (rs.next()) {
						currnum++;
						out.println(
								currnum + ". " + "[" + rs.getString("School.sh_name") + "]" + rs.getString("Meeting.me_title"));
				%>
				<br>
				<%
					}
				%>
			</fieldset>
			<h3 align="left">마감된 나의 미팅</h3>
			<fieldset align="left">
				<%
					sql = "Select School.sh_name, Meeting.me_title From ((Meeting left outer join User on User.us_id=Meeting.us_id) left outer join Acceptance on Acceptance.me_id = Meeting.me_id and  Acceptance.ac_yesno='y' ) left outer join School on School.sh_code = Meeting.sh_code Where (User.us_id='"
							+ id + "' or Acceptance.us_id='" + id
							+ "') and Meeting.me_deadline <  cast(curdate()as unsigned) Order by Meeting.me_deadline DESC";

					rs = stmt.executeQuery(sql);
					while (rs.next()) {
						endnum++;
						out.println(
								endnum + ". " + "[" + rs.getString("School.sh_name") + "]" + rs.getString("Meeting.me_title"));
				%>
				<br>
				<%
					}
				%>
			</fieldset>

			<h3 align="left">신청한 미팅</h3>
			<%
				String accYesNo = "";
			%>
			<fieldset align="left">
				<table border="1" align="center" width="100%" height="20%">
					<thread>
					<tr>
						<th>No</th>
						<th>미팅명</th>
						<th>수락여부</th>
					</tr>
					</thread>
					<%
						sql = "select School.sh_name,Meeting.me_title,Acceptance.ac_yesno from ((Meeting left outer join Acceptance on Meeting.me_id=Acceptance.me_id)left outer join School on Meeting.sh_code=School.sh_code)left outer join User on User.us_id=Acceptance.us_id where User.us_id='"
								+ id + "' ";
						rs = stmt.executeQuery(sql);
						while (rs.next()) {
							  if (rs.getString("Acceptance.ac_yesno").equals("y")) {
				                     accYesNo = "수락됨";
				                  } else if (rs.getString("Acceptance.ac_yesno").equals("n")) {
				                     accYesNo = "거절됨";
				                  } else
				                     accYesNo = "대기중";

							acceptancenum++;
					%>
					<tr>
						<td align="center"><%=acceptancenum%></td>
						<td align="center">[<%=rs.getString("School.sh_name")%>] <%=rs.getString("Meeting.me_title")%></td>
						<td align="center"><font
							color="<%if (accYesNo.equals("수락됨")) {%>blue<%} else if (accYesNo.equals("거절됨")) {%>red<%} else {%>black<%}%>"><%=accYesNo%></font></td>

						<%
							}
						%>
					
				</table>
			</fieldset>
		</fieldset>
	</form>

</body>
</html>