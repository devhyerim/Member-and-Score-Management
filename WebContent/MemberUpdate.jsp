<%@page import="com.test.MemberDTO"%>
<%@page import="com.test.MemberDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	// 전 페이지로부터 sid 넘겨받아 해당 sid를 가지고 멤버 정보 수정하기
	String sid = request.getParameter("sid");	
	String name = request.getParameter("uName");
	String tel = request.getParameter("uTel");

	MemberDAO dao = new MemberDAO();
	
	try
	{
		//DB 연결
		dao.connection();
		
		// update 함수 호출 시 넘겨 줄 매개변수 생성
		MemberDTO dto = new MemberDTO();
		dto.setSid(sid);
		dto.setName(name);
		dto.setTel(tel);
		
		dao.modify(dto);
		
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
	
	response.sendRedirect("MemberSelect.jsp");
%>