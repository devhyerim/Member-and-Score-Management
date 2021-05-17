/*=================================================
    MemberDAO.java
    - 데이터베이스 액션 처리 전용 클래스
      (TBL_MEMBER 테이블 전용 DAO)
=================================================*/


package com.test;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.util.DBConn;

public class MemberDAO
{
	private Connection conn;
	
	// 데이터베이스 연결 담당 메소드
	public Connection connection() throws ClassNotFoundException, SQLException
	{
		conn = DBConn.getConnection();
		return conn;
	}

	// 데이터베이스 입력 담당 메소드
	public int add(MemberDTO dto)
	{
		int result = 0;
		
		try
		{
			String sql = "INSERT INTO TBL_MEMBER(SID, NAME, TEL) VALUES(MEMBERSEQ.NEXTVAL, ?, ?)";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getTel());
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	// 회원 리스트 출력 담당 메소드
	public ArrayList<MemberDTO> lists()
	{
		ArrayList<MemberDTO> result = new ArrayList<MemberDTO>();
		
		try
		{
			String sql = "SELECT SID, NAME, TEL FROM TBL_MEMBER ORDER BY SID";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				MemberDTO member = new MemberDTO();
				member.setSid(rs.getString("SID"));
				member.setName(rs.getString("NAME"));
				member.setTel(rs.getString("TEL"));
				
				result.add(member);
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	// 인원 수 확인 담당 메소드
	public int count()
	{
		int result = 0;
		
		try
		{
			String sql = "SELECT COUNT(*) AS COUNT FROM TBL_MEMBER";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			
			ResultSet rs = pstmt.executeQuery();
			while(rs.next())
			{
				result = rs.getInt("COUNT");
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	// 데이터베이스 연결 종료 담당 메소드
	public void close() throws SQLException
	{
		DBConn.close();
	}
	
	// 메소드 추가 ----------------------------------------------------------------------------------------
	
	// 수정 액션처리를 위해서 검색 기능이 추가되어야 한다. (MemberInsertForm에 정보를 불러오도록)
	// → 회원 데이터 검색 담당 메소드
	public MemberDTO searchMember(String sid)
	{
		// 검색 결과는 1명의 member만 데려오므로 ArrayList가 아닌 MemberDTO이다. (sid는 primary key)
		MemberDTO result = new MemberDTO();
		
		try
		{
			String sql = "SELECT SID, NAME, TEL FROM TBL_MEMBER WHERE SID=?";
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sid);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				result.setSid(rs.getString("SID"));
				result.setName(rs.getString("NAME"));
				result.setTel(rs.getString("TEL"));
			}
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	
	// 회원 데이터 수정 메소드
	public int modify(MemberDTO dto)
	{
		int result = 0;
		
		String sql = "UPDATE TBL_MEMBER SET NAME=?, TEL=? WHERE SID=?";
		
		try
		{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getName());
			pstmt.setString(2, dto.getTel());
			pstmt.setString(3, dto.getSid());
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return result;
	}
	
	// 회원 데이터 삭제 메소드
	public int remove(String sid)
	{
		int result = 0;
		
		String sql = "DELETE FROM TBL_MEMBER WHERE SID=?";
		try
		{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sid);
			result = pstmt.executeUpdate();
			
			pstmt.close();
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}

		return result;
	}
	
	// 자식 테이블의 참조 데이터 레코드 수 확인
	public int refCount(String sid)
	{
		int result = 0;
		
		String sql = "SELECT COUNT(*) AS COUNT FROM TBL_MEMBERSCORE WHERE SID=?";
		try
		{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sid);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next())
				result = rs.getInt("COUNT");
			
			rs.close();
			pstmt.close();
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		// 0인 경우, 점수가 입력되지 않음 → 삭제 가능
		// 1인 경우, 점수가 입력됨 → 참조되었으므로 삭제 불가능
		return result;
	}

}
