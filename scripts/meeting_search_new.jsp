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
	java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
    String today = formatter.format(new java.util.Date());
    String id;
    id=request.getParameter("id");
%>
<!DOCTYPE html>
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
         <td align="center" bgcolor='FFD9EC'><a href="meeting_search.jsp?id=<%=id%>">미팅 검색</a></td>
      </tr>
      <tr>
         <td align="center"><a href="meeting_my.jsp?id=<%=id%>">나의 미팅</a></td>
      </tr>
	</table>

	<form>
		<fieldset align="right">
			<br>
			<div align="left">
				<%
					String mtitle, mpeople, mgender, mage_to, mage_from, mdate, mschool, mcontent;
				%>
				제목&nbsp;<input type="text" id="mtitle" name="mtitle" size="90%"
					placeholder="제목을 입력해주세요" />
			</div>
			<br>
			<br>
			<%
				mtitle = request.getParameter("mtitle");
			%>
			<input type="hidden" name="mtitle" value="<%=mtitle%>">
			<fieldset align="left">
				<br>&nbsp;모집 성별 :&nbsp; <input type="radio" id="mgender"
					name="mgender" value="m">남성&nbsp; <input type="radio"
					id="mgender" name="mgender" value="f">여성&nbsp; <br>
				<br>
				<%
					mgender = request.getParameter("mgender");
				%>
				<input type="hidden" name="mgender" value="<%=mgender%>">
				&nbsp;모집 인원 :&nbsp; <select id="mpeople" name="mpeople">
					<option value="1">1</option>
					<option value="2">2</option>
					<option value="3">3</option>
					<option value="4">4</option>
					<option value="5">5</option>
				</select> <br>
				<br>
				<%
					mpeople = request.getParameter("mpeople");
				%>
				<input type="hidden" name="mpeople" value="<%=mpeople%>">
				&nbsp;모집 나이 :&nbsp; <select id="mage_from" name="mage_from">
					<option value="20">20</option>
					<option value="21">21</option>
					<option value="22">22</option>
					<option value="23">23</option>
					<option value="24">24</option>
					<option value="25">25</option>
					<option value="26">26</option>
					<option value="27">27</option>
					<option value="28">28</option>
					<option value="29">29</option>
					<option value="30">30</option>
				</select> &nbsp;이상&nbsp;
				<%
					mage_from = request.getParameter("mage_from");
				%>
				
				<select id="mage_to" name="mage_to">
					<option value="20">20</option>
					<option value="21">21</option>
					<option value="22">22</option>
					<option value="23">23</option>
					<option value="24">24</option>
					<option value="25">25</option>
					<option value="26">26</option>
					<option value="27">27</option>
					<option value="28">28</option>
					<option value="29">29</option>
					<option value="30">30</option>
				</select> &nbsp;이하 <br>
				<br>
				<%
					mage_to = request.getParameter("mage_to");
				%>
				<input type="hidden" name="mage_from" value="<%=mage_from%>">
				<input type="hidden" name="mage_to" value="<%=mage_to%>">
				&nbsp;마감일자 :&nbsp;<input type="date" name="mdate"><br>
				<br>
				<%
					mdate = request.getParameter("mdate");
				%>
				<input type="hidden" name="mdate" value="<%=mdate%>">
				&nbsp;모집학교 :&nbsp; <select id="mschool" name="mschool">
					<option value="가톨릭대학교">가톨릭대학교</option>
					<option value="건국대학교">건국대학교</option>
					<option value="경기대학교">경기대학교</option>
					<option value="경희대학교">경희대학교</option>
					<option value="고려대학교">고려대학교</option>
					<option value="광운대학교">광운대학교</option>
					<option value="국민대학교">국민대학교</option>
					<option value="덕성여자대학교">덕성여자대학교</option>
					<option value="동국대학교">동국대학교</option>
					<option value="동덕여자대학교">동덕여자대학교</option>
					<option value="명지대학교">명지대학교</option>
					<option value="상명대학교">상명대학교</option>
					<option value="서강대학교">서강대학교</option>
					<option value="서경대학교">서경대학교</option>
					<option value="서울대학교">서울대학교</option>
					<option value="서울과학기술대학교">서울과학기술대학교</option>
					<option value="서울교육대학교">서울교육대학교</option>
					<option value="서울여자대학교">서울여자대학교</option>
					<option value="성균관대학교">성균관대학교</option>
					<option value="성신여자대학교">성신여자대학교</option>
					<option value="세종대학교">세종대학교</option>
					<option value="숙명여자대학교">숙명여자대학교</option>
					<option value="숭실대학교">숭실대학교</option>
					<option value="연세대학교">연세대학교</option>
					<option value="육군사관학교">육군사관학교</option>
					<option value="이화여자대학교">이화여자대학교</option>
					<option value="중앙대학교">중앙대학교</option>
					<option value="한국외국어대학교">한국외국어대학교</option>
					<option value="한국체육대학교">한국체육대학교</option>
					<option value="한성대학교">한성대학교</option>
					<option value="한양대학교">한양대학교</option>
					<option value="홍익대학교">홍익대학교</option>
				</select><br>
				<br>
				<%
					mschool = request.getParameter("mschool");
				%>
				<input type="hidden" name="mschool" value="<%=mschool%>">
			</fieldset>
			<br>
			<div align="left">
				<textarea id="mcontent" name="mcontent" cols="150" rows="20"
					placeholder="소개글을 입력해주세요"></textarea>
			</div>
			<br>
			<br>
			<%
				mcontent = request.getParameter("mcontent");
			%>
			
			<input type="hidden" name="mcontent" value="<%=mcontent%>">
			<font size="2" color="red">※ 주의) 나이, 마감 일자를 제대로 입력하지 않으면 폼이 초기화됩니다.</font>
			<div align="right">
			<input type="hidden" name="id" value=<%=id %>>
				<input type="submit" value="목록으로"
					formaction= "meeting_search.jsp?id=<%=id %> " />&nbsp; <input
					type="submit" value="등록" formaction="/Webproject/index/hidden.jsp?id=<%=id %>"/>
			</div>
		</fieldset>
	</form>
</body>
</html>