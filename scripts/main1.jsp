<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
               Connection conn = null;
  PreparedStatement stmt = null;

               ResultSet rs = null;
               int totalRecord = 0;
               int numPerPage = 5; //한 페이지당 보일 레코드 수
               int totalPage = 0; //전체 페이지 수
               try {
                  Class.forName("com.mysql.jdbc.Driver");
                  String jdbcurl = "jdbc:mysql://localhost:3306/webmeeting?serverTimezone=UTC&useSSL=false";
                  conn = DriverManager.getConnection(jdbcurl, "root", "tmddus");
                  String sql = "Select count(distinct sh_code) from Meeting";
                  stmt = conn.prepareStatement(sql);
                  rs = stmt.executeQuery(sql);
                  rs.next();
                  totalRecord = rs.getInt(1);

               }
               catch(Exception e){
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
				<th width="25%"  bgcolor='FFD9EC'><a href="main1.jsp?id=<%=id%>">미팅관리</a></th>
				<th width="25%"><a href="place.jsp?id=<%=id%>">장소추천</a></th>
				<th width="25%" ><a href="meetingTip.jsp?id=<%=id%>">미팅의 정석</a></th>
				<th width="25%" ><a href="mypage.jsp?id=<%=id%>">마이페이지</a></th>
			</tr>
		</thead>
	</table>
	<br>

	<table border="1" width="21%" height="150px" align="left">
		<tr>
			<td align="center"  bgcolor='FFD9EC'><a href="main1.jsp?id=<%=id%>">인기 학교 순위</a></td>
		</tr>
		<tr>
			<td align="center" ><a href="meeting_search.jsp?id=<%=id%>">미팅
					검색</a></td>
		</tr>
		<tr>
			<td align="center"><a href="meeting_my.jsp?id=<%=id%>">나의 미팅</a></td>
		</tr>
	</table>

	<form action="/Webproject/index/hidden.jsp" method="post">
		<fieldset align="right">
			<h1 align="left">인기있는 학교</h1>
			<br>

			<table border="1" align="center" width="100%" height="50%">
				<thead>
					<tr>
						<th>순위</th>
						<th>학교 이름</th>
						<th>미팅 수</th>
					</tr>
				</thead>

				<%
               
               int num = 0;
             
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
           
           String page_sql = "Select sh_name, MEID from (Select @ROWNUM := @ROWNUM + 1 ROWNUM, A.* from (Select School.sh_name, count(Meeting.me_id) as MEID From School,Meeting Where School.sh_code=Meeting.sh_code Group by Meeting.sh_code Order by count(Meeting.me_id) DESC) A, (select @ROWNUM := 0) R) M where ROWNUM between " + startRecord + " and " + endRecord;
           stmt = conn.prepareStatement(page_sql);
           rs = stmt.executeQuery(page_sql);
           
           while(rs.next()) {
        %>

				<tr>
					<td align="center"><%= startRecord %></td>
					<td align="center"><%= rs.getString("sh_name") %></td>
					<td align="center"><%= rs.getString("MEID") %></td>
				</tr>

				<%
              startRecord++;
           }
        %>
			</table>
			<br>
			<br>

			<center>
				<%
           for(int i = 1; i <= totalPage; i++){
        %>
				[<a href="main1.jsp?id=<%=id %>&curPage=<%=i%>"><%=i%></a>]&nbsp;
				<%
           }
        %>
			</center>
		</fieldset>
	</form>

</body>
</html>