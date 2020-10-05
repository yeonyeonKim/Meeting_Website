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
		String sql = "Select Clothes.cl_mf, Clothes.cl_png, Clothes.cl_weather, Clothes.cl_address, Clothes.cl_content From Clothes Order by Clothes.cl_mf, Clothes.cl_date";
		rs = stmt.executeQuery(sql);
	} catch (Exception e) {
		out.println("DB synchronization error : " + e.getMessage());
	}

	String id;
	id = request.getParameter("id");
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
				<th width="25%"><a href="main1.jsp?id=<%=id%>">미팅관리</a></th>
				<th width="25%"><a href="place.jsp?id=<%=id%>">장소추천</a></th>
				<th width="25%" bgcolor='FFD9EC'><a
					href="meetingTip.jsp?id=<%=id%>">미팅의 정석</a></th>
				<th width="25%"><a href="mypage.jsp?id=<%=id%>">마이페이지</a></th>
			</tr>
		</thead>
	</table>
	<br>

	<table border="1" align="left" width="21%" height="150px">
		<tr>
			<td align="center" bgcolor='FFD9EC'><a
				href="meetingTip.jsp?id=<%=id%>">의상 추천</a></td>
		</tr>
		<tr>
			<td align="center"><a href="successReview.jsp?id=<%=id%>">성공
					후기</a></td>
		</tr>
		<tr>
			<td align="center"><a href="myReview.jsp?id=<%=id%>">내가 쓴 후기</a></td>
		</tr>
	</table>

	<form>
		<fieldset align="right">
			<br>
			<br>
			<div align="center">
				<h3>
					<a href="#woman">Female</a>
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					<a href="#man">Male</a>
				</h3>
				<h4>
					<a href="#Swoman">Spring·Summer</a>&nbsp;&nbsp;<a href="#Wwoman">Fall·Winter</a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<a
						href="#Sman">Spring·Summer</a>&nbsp;&nbsp;<a href="#Wman">Fall·Winter</a>
				</h4>
			</div>
			<br>
			<br>

			<p>
				<a name="woman"><h1 align="left">Female</h1></a>
			<p>
				<a name="Swoman"><h2 align="left">[Spring·Summer]</h2></a>
				<%
					while (rs.next()) {
						if (rs.getString("Clothes.cl_mf").equals("f") && rs.getString("Clothes.cl_weather").equals("s")) {
				%>
				<img src="image/<%=rs.getString("Clothes.cl_png")%>.jpg" width="500"
					height="500" vspace="50" align="left">
			<div align="left">
				<br>
				<br>
				<br> &nbsp;[<a href=<%=rs.getString("Clothes.cl_address")%>>사이트로
					이동</a>]<br>&nbsp;<br>
				<br> &nbsp;[설명]<br>&nbsp;<%=rs.getString("Clothes.cl_content")%></div>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<%
				}
				}
			%>
			</p>
			<br>
			<br>
			<br>
			<br>
			<br>

			<p>
				<a name="Wwoman"><h2 align="left">[Fall·Winter]</h2></a>
				<%
					rs.beforeFirst();
					while (rs.next()) {
						if (rs.getString("Clothes.cl_mf").equals("f") && rs.getString("Clothes.cl_weather").equals("w")) {
				%>
				<img src="image/<%=rs.getString("Clothes.cl_png")%>.jpg" width="500"
					height="500" vspace="50" align="left">
			<div align="left">
				<br>
				<br>
				<br> &nbsp;[<a href=<%=rs.getString("Clothes.cl_address")%>>사이트로
					이동</a>]<br>&nbsp;<br>
				<br> &nbsp;[설명]<br>&nbsp;<%=rs.getString("Clothes.cl_content")%></div>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<%
				}
				}
			%>
			</p>
			</p>

			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>

			<p>
				<a name="man"><h1 align="left">Male</h1></a>
			<p>
				<a name="Sman"><h2 align="left">[Spring·Summer]</h2></a>
				<%
					rs.beforeFirst();
					while (rs.next()) {
						if (rs.getString("Clothes.cl_mf").equals("m") && rs.getString("Clothes.cl_weather").equals("s")) {
				%>
				<img src="image/<%=rs.getString("Clothes.cl_png")%>.jpg" width="500"
					height="500" vspace="50" align="left">
			<div align="left">
				<br>
				<br>
				<br> &nbsp;[<a href=<%=rs.getString("Clothes.cl_address")%>>사이트로
					이동</a>]<br>&nbsp;<br>
				<br> &nbsp;[설명]<br>&nbsp;<%=rs.getString("Clothes.cl_content")%></div>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<%
				}
				}
			%>
			</p>
			<br>
			<br>
			<br>
			<br>
			<br>

			<p>
				<a name="Wman"><h2 align="left">[Fall·Winter]</h2></a>
				<%
					rs.beforeFirst();
					while (rs.next()) {
						if (rs.getString("Clothes.cl_mf").equals("m") && rs.getString("Clothes.cl_weather").equals("w")) {
				%>
				<img src="image/<%=rs.getString("Clothes.cl_png")%>.jpg" width="500"
					height="500" vspace="50" align="left">
			<div align="left">
				<br>
				<br>
				<br> &nbsp;[<a href=<%=rs.getString("Clothes.cl_address")%>>사이트로
					이동</a>]<br>&nbsp;<br>
				<br> &nbsp;[설명]<br>&nbsp;<%=rs.getString("Clothes.cl_content")%></div>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<br>
			<%
            }
         }
      %>
			</p>
			</p>

		</fieldset>
	</form>

</body>
</html>