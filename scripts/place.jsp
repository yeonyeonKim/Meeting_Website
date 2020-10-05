<%@ page language ="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%
Connection conn=null;
Statement stmt =null;
ResultSet rs=null;
int num = 0;
int j=0;
int score =0;
try{
	Class.forName("com.mysql.jdbc.Driver");
	//String jdbc ="jdbc:mysql://localhost:3306/webmeeting";
	conn =DriverManager.getConnection("jdbc:mysql://localhost:3306/webmeeting?serverTimezone=UTC&useSSL=false","root","tmddus");
	stmt =conn.createStatement();
}
catch(Exception e){
	out.println(" 연동 오류입니다:"+e.getMessage());
}
String id;
id=request.getParameter("id");
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
			<td align="center" bgcolor='FFD9EC'><a href="place.jsp?id=<%=id%>">TOP 10 장소</a></td>
		</tr>
		<tr>
			<td align="center"><a href="place_recommend.jsp?id=<%=id%>">장소 추천</a></td>
		</tr>
		<tr>
			<td align="center"><a href="place_my.jsp?id=<%=id%>">나의 장소</a></td>
		</tr>
	</table>

	<form>
		<fieldset align="right">
			<div align="left">
			<%
					
						String sql ="Select Place.pl_name, Place.pl_score,Place.pl_address,Place.pl_content, Place.pl_png From Place Order by Place.pl_score DESC";
						rs=stmt.executeQuery(sql);
					
					while(rs.next()){
						num++;
						score = rs.getInt("pl_score");

	%>
			<h1>[<%out.print(num); %>위] <%=rs.getString("Place.pl_name")%>
			<%for(j=0;j<score;j++)out.print("★"); %> </h1><br>
			<img src="image/<%=rs.getString("Place.pl_png")%>.jpg" align="left" width="660px" height="440px">
			&nbsp;[주소]<br>&nbsp;<%=rs.getString("Place.pl_address")%><br><br>
			&nbsp;[설명]<br>&nbsp;<%=rs.getString("Place.pl_content")%>
			<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
		
		
			<%
					}
				%>
			</div>
		</fieldset>
	</form>

</body>
</html>