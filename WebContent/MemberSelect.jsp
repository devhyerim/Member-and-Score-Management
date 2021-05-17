<%@page import="java.sql.Connection"%>
<%@page import="com.test.MemberDTO"%>
<%@page import="com.test.MemberDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	StringBuffer result = new StringBuffer();
	MemberDAO dao = new MemberDAO();

	try
	{
		// 테이블 head 부분
		result.append("<table class='table'><tr><th class='numTh'>번호</th><th class='nameTh'>이름</th>");
		result.append("<th class='telTh'>전화번호</th>");
		result.append("<th class='manageTh'>회원관리</th></tr>");

		// DB 연결
		Connection conn = dao.connection();
		
		for(MemberDTO dto:dao.lists())
		{
			result.append("<tr>");
			result.append("<td class='center'>" + dto.getSid() + "</td>");
			result.append("<td class='center'>" + dto.getName() + "</td>");
			result.append("<td class='center'>" + dto.getTel() + "</td>");
			result.append("<td>");
			result.append("<a href='MemberUpdateForm.jsp?sid=" + dto.getSid() + "'>");
			result.append("<button type='button' class='btn01'>" + "수정" + "</button>");
			result.append("</a>");
			// result.append("<a href='javascript:memberDelete(1, '박나현')'>");
			result.append("<a href='javascript:memberDelete(" + dto.getSid() + ", \"" + dto.getName() + "\")'>");
			result.append("<button type='button' class='btn01'>" + "삭제" + "</button>");
			result.append("</a>");
			result.append("</td>");
			result.append("</tr>");
		}
		
		result.append("</table>");
	}catch(Exception e)
	{
		System.out.println(e.toString());
	}
	

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MemberSelect.jsp</title>
<link rel="stylesheet" type="text/css" href="css/MemberScore.css">
<style type="text/css">
	.center{ text-align: center; }
</style>

<script type="text/javascript">

	function memberDelete(sid, name)
	{
		// confirm 창은 true(확인) 또는 false(취소) 를 반환한다.
		var res = confirm("번호:" + sid + ", 이름:" + name + "\n이 회원의 정보를 삭제하시겠습니까?");
		
		//테스트
		//alert(res);
		
		if(res)		// 사용자가 확인을 눌렀다면
			window.location.href="MemberDelete.jsp?sid=" + sid;
		
	}

</script>

</head>
<body>

<!-- http://localhost:8090/WebApp12/MemberSelect.jsp -->
<div>
	<h1>회원 명단 관리 및 출력 페이지</h1>
	<hr>
</div>

<div>
	<a href="MemberScoreSelect.jsp"><button type="button">회원 성적 관리</button></a>
	<a href="MemberInsertForm.jsp"><button type="button">신규 회원 등록</button></a>
</div>
<br>
<div>
	<!-- 리스트 출력 -->
	<%=result %>
</div>

</body>
</html>