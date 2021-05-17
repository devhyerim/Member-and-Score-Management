<%@page import="com.test.MemberDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%
	String sid = request.getParameter("sid");
	MemberDAO dao = new MemberDAO();
	
	// 어디로 보낼 지 구분하기 위한 변수
	String strAddr="";
	
	try
	{
		// DB 연결
		dao.connection();
		
		// 삭제 기능 처리
		//dao.remove(sid);
		
		// 제거하려는 해당 학생의 데이터를 참조하는 데이터 개수 반환
		// → 지울 수 있는지 없는지 확인
		int checkCount = dao.refCount(sid);
		
		if(checkCount==0)
		{
			dao.remove(sid);
			strAddr = "MemberSelect.jsp";
		}
		else
		{
			strAddr = "Notice.jsp";
			//-- 제거하지 못하는 사유를 안내하는 페이지로 연결
			//-- + 리스트로 돌아가기
			//-- TBL_MEMBERSCORE 테이블의 데이터가 TBL_MEMBER 테이블의 SID를 참조하고 있는 경우 삭제X
		}
		
		
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
	
	response.sendRedirect(strAddr);


%>