/*===================================================
    MemberScoreDAO.java
    - 데이터베이스 액션 처리 전용 객체 활용
      (TBL_MEMBERSCORE 테이블 전용 DAO)
====================================================*/

package com.test;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import com.util.DBConn;

public class MemberScoreDAO
{
	private Connection conn;
	
	// 데이터베이스 연결 담당 메소드
	public Connection connection() throws ClassNotFoundException, SQLException
	{
		conn = DBConn.getConnection();
		return conn;
	}
	
	// 데이터 입력 담당 메소드 (성적 데이터 입력)
	public int add(MemberScoreDTO score)
	{
		int result=0;
		
		String sql = "INSERT INTO TBL_MEMBERSCORE(SID, KOR, ENG, MAT) VALUES(?, ?, ?, ?)";
		
		try
		{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, score.getSid());
			pstmt.setInt(2, score.getKor());
			pstmt.setInt(3, score.getEng());
			pstmt.setInt(4, score.getMat());
			
			result = pstmt.executeUpdate();
			
			pstmt.close();
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return result;
		
	}
	
	
	// 성적 리스트 출력 담당 메소드
	public ArrayList<MemberScoreDTO> lists()
	{
		ArrayList<MemberScoreDTO> result = new ArrayList<MemberScoreDTO>();
		
		String sql = "SELECT SID, NAME, KOR, ENG, MAT, (KOR+ENG+MAT) AS TOT,"
				+ " ((KOR+ENG+MAT)/3) AS AVG,"
				+ " RANK() OVER(ORDER BY (KOR+ENG+MAT) DESC) AS RANK"
				+ " FROM VIEW_MEMBERSCORE"
				+ " ORDER BY SID";
		
		try
		{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			MemberScoreDTO dto = null;
			while(rs.next())
			{
				dto = new MemberScoreDTO();
				dto.setSid(rs.getString("SID"));
				dto.setName(rs.getString("NAME"));
				dto.setKor(rs.getInt("KOR"));
				dto.setEng(rs.getInt("ENG"));
				dto.setMat(rs.getInt("MAT"));
				dto.setTot(rs.getInt("TOT"));
				dto.setAvg(rs.getDouble("AVG"));
				dto.setRank(rs.getInt("RANK"));
				
				result.add(dto);
			}
			
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
	
	// 메소드 추가----------------------------------------------------------------
	
	// 번호 검색 담당 메소드 → 이름 얻어내기(조회: 조인한 view)
	// 입력 + 수정 할 때 기존 정보 불러오기 위해 같이 쓸 메소드
	public MemberScoreDTO search(String sid)
	{
		MemberScoreDTO result = new MemberScoreDTO();
		
		String sql = "SELECT SID, NAME, KOR, ENG, MAT FROM VIEW_MEMBERSCORE WHERE SID=?";
		
		try
		{
			PreparedStatement pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, sid);
			ResultSet rs = pstmt.executeQuery();
			
			while(rs.next())
			{
				result.setSid(rs.getString("SID"));
				result.setName(rs.getString("NAME"));
				result.setKor(rs.getInt("KOR"));
				result.setEng(rs.getInt("ENG"));
				result.setMat(rs.getInt("MAT"));
			}
			rs.close();
			pstmt.close();
			
		} catch (Exception e)
		{
			System.out.println(e.toString());
		}
		
		return result;
	}

}
