<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>

<%
	Connection conn = null;
	PreparedStatement stmt = null;
	ResultSet rs = null;
	int totalRecord = 0; //전체 레코드 수
	String sql = "";
	try {
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcurl = "jdbc:mysql://localhost:3306/webmeeting?serverTimezone=UTC&useSSL=false";
		conn = DriverManager.getConnection(jdbcurl, "root", "tmddus");
		sql = "select count(*) cnt from Meeting";
		stmt = conn.prepareStatement(sql);
		rs = stmt.executeQuery();
		rs.next();
		totalRecord = rs.getInt(1);

	} catch (Exception e) {
		out.println("DB synchronization error : " + e.getMessage());
	}
	String id;
	id = request.getParameter("id");
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

	int curPage = (request.getParameter("curPage") == null) ? 1
			: Integer.parseInt(request.getParameter("curPage")); //현재 페이지 넘버
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
			<td align="center" bgcolor='FFD9EC'><a
				href="meeting_search.jsp?id=<%=id%>">미팅 검색</a></td>
		</tr>
		<tr>
			<td align="center"><a href="meeting_my.jsp?id=<%=id%>">나의 미팅</a></td>
		</tr>
	</table>

	<form>
		<fieldset align="right">
			<br>
			<center>
				<%
					String schoolName = request.getParameter("schoolName");
					if (schoolName == null)
						schoolName = "";
					String chk = request.getParameter("check");
					chk = chk == null ? "OFF" : "ON";
				%>

				<form name="search" align="right" method="post"
					action="meeting_search.jsp?id=<%=id%>" onsubmit="true">
					<h3>
						검색 할 학교&nbsp;<input type="text" name="schoolName"
							value="<%=schoolName%>" size="70" /><input type="hidden"
							name="id" value=<%=id%>>
						<button type='submit'>검색</button>
					</h3>
				</form>
			</center>
			<br>
			<form name="randommeeting" align="right" method="post"
				action="meeting_search.jsp?id=<%=id%>" onsubmit="true">
				<input type="checkbox" name="check"> <input type="hidden"
					name="id" value=<%=id%>>
				<button type='submit'>랜덤소개팅</button>
			</form>
			<br> <br>
			<form>
				<table border="1" align="center" width="90%" height="45%">
					<thead>
						<tr>
							<th>No</th>
							<th>제목</th>
							<th>작성날짜</th>
							<th>마감일자</th>
							<th>작성자</th>
							<th>모집인원</th>
							<th>신청인원</th>
						</tr>
					</thead>
					<%
						int me_id, rownum = 0;
						String page_sql = "";
						if (schoolName == "" && chk == "OFF") {
							page_sql = "Select me_id, sh_name, me_title, me_write_date, me_deadline, us_name, me_available_cnt, ACID from (Select @ROWNUM := @ROWNUM + 1 ROWNUM, A.* from (Select distinct Meeting.me_id, School.sh_name, Meeting.me_title, Meeting.me_write_date, Meeting.me_deadline, User.us_name, Meeting.me_available_cnt, Count(Acceptance.ac_id) as ACID From Meeting Left Outer join School on School.sh_code=Meeting.sh_code Right outer join User on User.us_id=Meeting.us_id Left outer join Acceptance on Meeting.me_id=Acceptance.me_id Group by Meeting.me_id Order by Meeting.me_deadline DESC) A, (select @ROWNUM := 0) R) M where ROWNUM between "
									+ startRecord + " and " + endRecord;
						} else if (schoolName != "") {
							page_sql = "Select me_id, sh_name, me_title, me_write_date, me_deadline, us_name, me_available_cnt, ACID from (Select @ROWNUM := @ROWNUM + 1 ROWNUM, A.* from (Select distinct Meeting.me_id, School.sh_name, Meeting.me_title, Meeting.me_write_date, Meeting.me_deadline, User.us_name, Meeting.me_available_cnt, Count(Acceptance.ac_id) as ACID From Meeting Left Outer join School on School.sh_code=Meeting.sh_code Right outer join User on User.us_id=Meeting.us_id Left outer join Acceptance on Meeting.me_id=Acceptance.me_id Where School.sh_name like '%"
									+ schoolName
									+ "%' Group by Meeting.me_id Order by Meeting.me_deadline DESC) A, (select @ROWNUM := 0) R) M where ROWNUM between "
									+ startRecord + " and " + endRecord;
						} else if (chk == "ON") {
							page_sql = "Select me_id, sh_name, me_title, me_write_date, me_deadline, us_name, me_available_cnt, ACID From (Select @ROWNUM := @ROWNUM + 1 ROWNUM, A.* from (Select distinct Meeting.me_id, School.sh_name, Meeting.me_title, Meeting.me_write_date, Meeting.me_deadline, User.us_name, Meeting.me_available_cnt, Count(Acceptance.ac_id) as ACID From (((User as user1 left outer join User as user on user1.us_id !=user.us_id) join University on user1.uv_seq = user.uv_seq) join Department on user1.dp_seq!=user.dp_seq) join Meeting on Meeting.me_available_cnt='1' and Meeting.us_id=user.us_id and Meeting.me_age_from<=user1.us_age and Meeting.me_age_to>=user1.us_age and Meeting.me_deadline>=cast(curdate()as unsigned) Left Outer join School on School.sh_code=Meeting.sh_code Left outer join Acceptance on Meeting.me_id=Acceptance.me_id Where user1.us_sex!=user.us_sex and user1.us_id='001' Group by Meeting.me_id Order by Meeting.me_deadline DESC) A, (select @ROWNUM := 0) R) M where ROWNUM between "
									+ startRecord + " and " + endRecord;
						}

						//paging
						stmt = conn.prepareStatement(page_sql);
						rs = stmt.executeQuery();

						rs.last();
						rownum = rs.getRow();
						rs.beforeFirst();

						while (rs.next()) {
							me_id = Integer.parseInt(rs.getString("me_id"));
							if (schoolName != "" || chk == "ON")
								totalRecord = rownum;

							totalPage = 0; //전체 페이지 수
							if (totalRecord != 0) {
								if ((totalRecord % numPerPage) == 0) {
									totalPage = (totalRecord / numPerPage);
								} else {
									totalPage = (totalRecord / numPerPage + 1);
								}
							}
							java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
							java.text.SimpleDateFormat formatter2 = new java.text.SimpleDateFormat("yyyy-MM-dd");
							java.util.Date writedate = formatter.parse(rs.getString("me_write_date"));
							String write_date = formatter2.format(writedate);
							java.util.Date tempdeadline = formatter.parse(rs.getString("me_deadline"));
							String deadline = formatter2.format(tempdeadline);

					%>
					<tr>
						<td align="center"><%=endRecord%></td>

						<td align="center"><a
							href="meeting_search_show.jsp?id=<%=id%>&me_id=<%=rs.getString("me_id")%>&curPage">[<%=rs.getString("sh_name")%>]
								<%=rs.getString("me_title")%></a></td>
						<td align="center"><%=write_date%></td>
						<td align="center"><font color="red"><%=deadline%></font></td>
						<td align="center"><%=rs.getString("us_name")%></td>
						<td align="center"><%=rs.getInt("me_available_cnt")%></td>
						<td align="center"><%=rs.getInt("ACID")%></td>
					</tr>
					<%
						endRecord--;
						}
					%>

				</table>
				<br> <br>

				<center>
					<%
						for (int i = 1; i <= totalPage; i++) {
					%>
					[<a href="meeting_search.jsp?id=<%=id%>&curPage=<%=i%>"><%=i%></a>]&nbsp;
					<%
						}
					%>
				</center>

				<div align="right">
					<input type="hidden" name="id" value="<%=id%>"> <input
						type="submit" value="새 글 작성"
						formaction="meeting_search_new.jsp?id=<%=id%>" />
				</div>
		</fieldset>
	</form>
	<%
		stmt.close();
		conn.close();
	%>
</body>
</html>