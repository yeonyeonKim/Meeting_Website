<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
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
				<th width="25%" bgcolor='FFD9EC'><a href="place.jsp?id=<%=id%>">장소추천</a></th>
				<th width="25%"><a href="meetingTip.jsp?id=<%=id%>">미팅의 정석</a></th>
				<th width="25%"><a href="mypage.jsp?id=<%=id%>">마이페이지</a></th>
			</tr>
		</thead>
	</table>
	<br>

	<table border="1" width="21%" height="150px" align="left">
		<tr>
			<td align="center"><a href="place.jsp?id=<%=id%>">TOP 10 장소</a></td>
		</tr>
		<tr>
			<td align="center" bgcolor='FFD9EC'><a href="place_recommend.jsp?id=<%=id%>">장소 추천</a></td>
		</tr>
		<tr>
			<td align="center"><a href="place_my.jsp?id=<%=id%>">나의 장소</a></td>
		</tr>
	</table>

	<form>
		<fieldset align="right">
			<br>
			<div align="left">
				<%
					String pScore, pName, pSchoolName, pAddr, pPng, pContent;
				%>

				장소 이름 :&nbsp;<input type="text" id="pName" name="pName" size="80%"
					placeholder="이름을 입력해주세요" /><br>
				<br>
				<%
					pName = request.getParameter("pName");
				%>
				<input type="hidden" name="pName" value="<%=pName%>">  학교 이름 :
				<select id="pSchoolName" name="pSchoolName">
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
            </select><br><br>

				<%
					pSchoolName = request.getParameter("pSchoolName");
				%>
				<input type="hidden" name="pSchoolName" value="<%=pSchoolName%>">

				장소 주소 :&nbsp;<input type="text" id="pAddr" name="pAddr" size="80%"
					placeholder="주소를 입력해주세요" /><br>
				<br>
				<%
					pAddr = request.getParameter("pAddr");
				%>
				<input type="hidden" name="pAddr" value="<%=pAddr%>">  장소
				사진&nbsp;&nbsp;<input type="file" id="pPng" name="pPng" value="사진 첨부">  <font size="1" color="red">※ 장소 사진은 .jpg만 가능합니다.</font>
				
				<br>
				<br>
				<%
					pPng = request.getParameter("pPng");
				%>
				<input type="hidden" name="pPng" value="<%=pPng%>">
				장소 별점
				:&nbsp; <input type="radio" id="pScore" name="pScore" value="5">5점
				<input type="radio" id="pScore" name="pScore" value="4">4점 <input
					type="radio" id="pScore" name="pScore" value="3">3점 <input
					type="radio" id="pScore" name="pScore" value="2">2점 <input
					type="radio" id="pScore" name="pScore" value="1">1점 <br>
				<br>
				<%
					pScore = request.getParameter("pScore");
				%>
			<input type="hidden" name="pScore" value="<%=pScore%>">  	장소
				설명<br>
				<br>
				<textarea name="pContent" id="pContent" cols="150" rows="20"
					placeholder="설명을 입력해주세요"></textarea>
				<br>
				<br>
				<%
					pContent = request.getParameter("pContent");
				%>
			<input type="hidden" name="pContent" value="<%=pContent%>">

			</div>
			<div align="right">
			<input type="hidden" name="id" value="<%=id %>">
				<input type="submit" value="목록으로"
					formaction="place_recommend.jsp?id=<%=id%>" />&nbsp; <input
					type="submit" value="등록"
					formaction="/Webproject/index/hidden.jsp?id=<%=id%>" enctype="multipart/form-data"/>
			</div>

		</fieldset>
	</form>
</body>
</html>
