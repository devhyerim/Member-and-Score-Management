<%@page import="com.test.MemberDTO"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="com.test.MemberDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	// MemberInsert.jsp
	//-- 데이터베이스의 테이블TBL_MEMBER에
	//   회원 데이터 추가 액션 처리 수행
	//   이후, 다시 리스트 페이지를 요청할 수 있도록 안내

	// 한글 깨짐 방지 처리
	request.setCharacterEncoding("UTF-8");

	// 전 페이지에서 입력 정보 받아오기 → MemberDTO 구성
	String uName = request.getParameter("uName");
	String uTel = request.getParameter("uTel");
	
	MemberDAO dao = new MemberDAO();

	try
	{
		// DB 연결
		dao.connection();
		
		// add 함수 호출하기 위해 매개변수로 넘겨 줄 MemberDTO 구성
		MemberDTO dto = new MemberDTO();
		dto.setName(uName);
		dto.setTel(uTel);
		
		// add 함수 호출
		dao.add(dto);
		
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