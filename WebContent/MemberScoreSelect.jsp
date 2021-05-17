<%@page import="com.test.MemberScoreDAO"%>
<%@page import="com.test.MemberScoreDTO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	StringBuffer str = new StringBuffer();
	MemberScoreDAO dao = new MemberScoreDAO();
	
	str.append("<table class='table'><tr>");
	str.append("<th class='numTh'>번호</th>");
	str.append("<th class='nameTh'>이름</th>");
	str.append("<th class='txtScore'>국어점수</th>");
	str.append("<th class='txtScore'>영어점수</th>");
	str.append("<th class='txtScore'>수학점수</th>");
	str.append("<th class='txtScore'>총점</th>");
	str.append("<th class='txtScore'>평균</th>");
	str.append("<th class='txtScore'>석차</th>");
	str.append("<th class='manageTh'>성적관리</th><tr>");
	
	try
	{
		// DB 연결
		dao.connection();
		
		// 성적 리스트 출력
		for(MemberScoreDTO dto:dao.lists())
		{
			str.append("<tr>");
			str.append("<td>" + dto.getSid() + "</td>");
			str.append("<td>" + dto.getName() + "</td>");
			str.append("<td>" + dto.getKor() + "</td>");
			str.append("<td>" + dto.getEng() + "</td>");
			str.append("<td>" + dto.getMat() + "</td>");
			str.append("<td>" + dto.getTot() + "</td>");
			str.append("<td>" + String.format("%.2f", dto.getAvg()) + "</td>");
			str.append("<td>" + dto.getRank() + "</td>");
			
			// 성적 처리 항목(입력, 수정, 삭제)
			/*
			str.append("<td>");
			str.append("<button type='button' class='btn02'>");
			str.append("입력");
			str.append("</button>");
			str.append("<button type='button' class='btn01'>");
			str.append("수정");
			str.append("</button>");
			str.append("<button type='button' class='btn01'>");
			str.append("삭제");
			str.append("</button>");
			str.append("</td>");
			*/
			
			if(dto.getKor()==-1 && dto.getEng()==-1 && dto.getMat()==-1) 
			{
				// 성적이 입력되어 있지 않은 경우: 입력만 활성화(btn01)
				str.append("<td>");
				str.append("<a href='MemberScoreInsertForm.jsp?sid=" + dto.getSid() + "'>");
				str.append("<button type='button' class='btn01'>");
				str.append("입력");
				str.append("</button>");
				str.append("</a>");
				str.append("<button type='button' class='btn02'>");
				str.append("수정");
				str.append("</button>");
				str.append("<button type='button' class='btn02'>");
				str.append("삭제");
				str.append("</button>");
				str.append("</td>");
			}else
			{	// 성적이 입력되어 있는 경우: 수정, 삭제만 활성화(btn01)
				str.append("<td>");
				str.append("<button type='button' class='btn02'>");
				str.append("입력");
				str.append("</button>");
				str.append("<button type='button' class='btn01'>");
				str.append("수정");
				str.append("</button>");
				str.append("<button type='button' class='btn01'>");
				str.append("삭제");
				str.append("</button>");
				str.append("</td>");
			}	
				
			str.append("</tr>");
		}
		
		str.append("</table>");
		
	}catch(Exception e)
	{
		System.out.println(e.toString());
	}
	finally
	{
		try
		{
			dao.close();
		}
		catch(Exception e)
		{
			System.out.println(e.toString());
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MemberScoreSelect.jsp</title>
<link rel="stylesheet" type="text/css" href="css/MemberScore.css">
<style type="text/css">
	.center{ text-align: center; }
</style>
</head>
<body>

<!-- http://localhost:8090/WebApp12/MemberSocreSelect.jsp -->
<div>
	<h1>회원 성적 관리 및 출력 페이지</h1>
	<hr>
</div>
<br>
<div>
	<a href="MemberSelect.jsp"><button type="button">회원 명단 관리</button></a>
</div>
<br>
<div>
	<!-- 리스트 출력 -->
	<%=str.toString() %>
</div>

</body>
</html>