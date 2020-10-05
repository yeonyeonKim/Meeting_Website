<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
int totalRecord = 0; //전체 레코드 수
Connection conn = null;
PreparedStatement stmt = null;
ResultSet rs = null;
String sql = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");
		String jdbcurl = "jdbc:mysql://localhost:3306/webmeeting?serverTimezone=UTC&useSSL=false";
		conn = DriverManager.getConnection(jdbcurl, "root", "tmddus");
		  sql = "select count(*) cnt from Review";
	      stmt = conn.prepareStatement(sql);
	      rs = stmt.executeQuery();
	      rs.next();
	      totalRecord = rs.getInt(1);

	} catch (Exception e) {
		out.println("DB synchronization error : " + e.getMessage());
	}
	String id;
	id= request.getParameter("id");
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
			<td align="center" bgcolor='FFD9EC'><a href="successReview.jsp?id=<%=id%>">성공 후기</a></td>
		</tr>
		<tr>
			<td align="center"><a href="myReview.jsp?id=<%=id%>">내가 쓴 후기</a></td>
		</tr>
	</table>

	<form>
		<fieldset align="right">
			<%
				String schoolName = request.getParameter("schoolName");
				if (schoolName == null)
					schoolName = "";
				String chk = request.getParameter("check");
				chk = chk == null ? "OFF" : "ON";
			%>

			<form name="search" align="right" method="get"
				action="successReview.jsp?id=<%=id %>" onsubmit="true">
				<center>
					<h3>
						검색 할 학교&nbsp;<input type="text" name="schoolName"
							value="<%=schoolName%>" size="70" /><input type="hidden"
							name="id" value=<%=id%>>
						<button type='submit'>검색</button>
					</h3>
			</form>
			<form name="attendmeeting" align="right" method="post"
				action="successReview.jsp?id=<%=id%>" onsubmit="true">
				<input type="checkbox" name="check"> <input type="hidden"
					name="id" value=<%=id%>>
				<button type='submit'>참여미팅후기</button>
			</form>
			</center>
			<br>
			<br>
			<table border="1" align="center" width="90%" height="45%">
				<thead>
					<tr>
						<th width="10%">No</th>
						<th width="54%">제목</th>
						<th width="20%">작성 날짜</th>
						<th width="16%">작성자</th>
					</tr>
				</thead>
				<%
				   int rownum=0;
	            String rv_id;
	               String page_sql = "";
	               String writedate="";
	                if(schoolName == ""&&chk.equals("OFF")){
	                     page_sql = "Select rv_id, sh_name, rv_title, rv_write_date, us_name from (Select @ROWNUM := @ROWNUM + 1 ROWNUM, A.* from (Select Review.rv_id, School.sh_name, Review.rv_title, Review.rv_write_date, User.us_name From ((Review left outer join Meeting on Meeting.me_id=Review.me_id) left outer join School on School.sh_code=Meeting.sh_code) left outer join User on User.us_id = Review.us_id Order by Review.rv_write_date DESC) A, (select @ROWNUM := 0) R) M where ROWNUM between " + startRecord + " and " + endRecord;

	                }
	                else if(schoolName != ""){
	                     page_sql = "Select rv_id, sh_name, rv_title, rv_write_date, us_name from (Select @ROWNUM := @ROWNUM + 1 ROWNUM, A.* from (Select Review.rv_id, School.sh_name, Review.rv_title, Review.rv_write_date, User.us_name From ((Review left outer join Meeting on Meeting.me_id=Review.me_id) left outer join School on School.sh_code=Meeting.sh_code) left outer join User on User.us_id = Review.us_id Where School.sh_name like '%" +schoolName+ "%'Order by Review.rv_write_date DESC) A, (select @ROWNUM := 0) R) M where ROWNUM between " + startRecord + " and " + endRecord;
	                }else if (chk.equals( "ON")){
	                	page_sql="Select distinct rv_id, sh_name, rv_title, rv_write_date, us_name from (Select @ROWNUM := @ROWNUM + 1 ROWNUM, A.* from ( select distinct Review.rv_id,School.sh_name,Review.rv_title,Review.rv_write_date,user1.us_name from ((((Review left outer join Meeting on Meeting.me_id=Review.me_id)left outer join User as user1 on user1.us_id=Review.us_id)left outer join School on School.sh_code=Meeting.sh_code)join User as user2)left outer join Acceptance on Acceptance.me_id=Review.me_id where (Meeting.us_id=user2.us_id or (Acceptance.us_id=user2.us_id and Acceptance.ac_yesno='y')) and user2.us_id='"+id+"'Order by Review.rv_write_date DESC) A, (select @ROWNUM := 0) R) M where ROWNUM between " + startRecord + " and " + endRecord;

	                }
	                
	                //paging
	                stmt = conn.prepareStatement(page_sql);
	                rs = stmt.executeQuery();
	               
	                rs.last();
	                rownum = rs.getRow();
	                rs.beforeFirst();

	                int num = 0;
	               
	                while(rs.next()) {
	                   rv_id=(rs.getString("rv_id"));
	                   if(schoolName != "" || chk=="ON") totalRecord = rownum;
	                    
	                   totalPage = 0; //전체 페이지 수
	                    if(totalRecord != 0){
	                        if((totalRecord % numPerPage) == 0){
	                            totalPage = (totalRecord / numPerPage);
	                        }
	                        else{
	                            totalPage = (totalRecord / numPerPage + 1);
	                        }
	                        java.text.SimpleDateFormat formatter = new java.text.SimpleDateFormat("yyyyMMdd");
	    					java.text.SimpleDateFormat formatter2 = new java.text.SimpleDateFormat("yyyy-MM-dd");
	    					java.util.Date tempwrite= formatter.parse(rs.getString("rv_write_date"));
	    					writedate = formatter2.format(tempwrite);
	                    }
	                %>
	            <tr>
	               <td><center><%=startRecord %></center></td>
	               <td><a href="review1.jsp?id=<%=id %>&rv_id=<%=rs.getString("rv_id") %>">[<%=rs.getString("sh_name")%>] <%=rs.getString("rv_title") %></a></td>
	               <td><center><%=writedate%></center></td>
	               <td><center><%=rs.getString("us_name") %></center></td>
	            </tr>
	            <%
	               startRecord++;
	                }
	                %>
	         </table> <br><br>
	         <center>
	            <%
	               for(int i = 1; i <= totalPage; i++){
	            %>
	               [<a href="successReview.jsp?id=<%=id %>&curPage=<%=i%>"><%=i%></a>]&nbsp;
	            <%
	               }
	            %>
	            </center>

			<br>
			<div align="right">
			<input type="hidden" name="id" value="<%=id %>">
				<input type="submit" value="후기 작성"
					formaction="reviewForm.jsp?id=<%=id%>">
			</div>
		</fieldset>
	</form>
<%stmt.close();
	conn.close();
%>
</body>
</html>