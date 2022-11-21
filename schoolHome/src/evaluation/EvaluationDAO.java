package evaluation;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import util.DatabaseUtil;

public class EvaluationDAO {
	public int write(EvaluationDTO evaluationDTO) {
		String sql = "INSERT INTO EVALUATION VALUES (eval_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, 0)";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);//prepareStatement에 어떠한 정해진 sql문장을 데이터베이스에 삽입하는 형식
			pstmt.setString(1, evaluationDTO.getUserID().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(2, evaluationDTO.getLectureName().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(3, evaluationDTO.getProfessorName().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setInt(4, evaluationDTO.getLectureYear());
			pstmt.setString(5, evaluationDTO.getSemesterDivide().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(6, evaluationDTO.getLectureDivide().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(7, evaluationDTO.getEvaluationTitle().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(8, evaluationDTO.getEvaluationContent().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(9, evaluationDTO.getTotalScore().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(10, evaluationDTO.getCreditScore().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			pstmt.setString(11, evaluationDTO.getLectureScore().replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>"));
			return pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			try {
				if(conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			try {
				if(pstmt != null) {
					pstmt.close();
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			try {
				if(rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		return -1; //데이터베이스 오류
	}
		
	public ArrayList<EvaluationDTO> getList (String lectureDivide, String searchType, String search, int pageNumber){
		if(lectureDivide.equals("전체")) {
			lectureDivide = "";
		}
		ArrayList<EvaluationDTO> evaluationList = null;
		String sql = "";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			if(searchType.equals("최신순")) {
				sql = "SELECT A.* FROM (SELECT ROWNUM r, B.* FROM (SELECT * FROM EVALUATION WHERE lectureDivide LIKE ? AND lectureName || professorName || evaluationTitle || evaluationContent LIKE ? ORDER BY evaluationID DESC)B) A WHERE r BETWEEN ? AND ?";
			}else if(searchType.equals("추천순")) {
				sql = "SELECT A.* FROM (SELECT ROWNUM r, B.* FROM (SELECT * FROM EVALUATION WHERE lectureDivide LIKE ? AND lectureName || professorName || evaluationTitle || evaluationContent LIKE ? ORDER BY likeCount DESC)B) A WHERE r BETWEEN ? AND ?";
			}
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + lectureDivide + "%");
			pstmt.setString(2, "%" + search + "%");
			pstmt.setInt(3, (pageNumber * 5));
			pstmt.setInt(4, (pageNumber * 5) + 6);
			rs = pstmt.executeQuery();
			evaluationList = new ArrayList<EvaluationDTO>();
			while(rs.next()) {
				EvaluationDTO evaluationDTO = new EvaluationDTO();
				evaluationDTO.setEvaluationID(rs.getInt("evaluationID"));
				evaluationDTO.setUserID(rs.getString("userID"));
				evaluationDTO.setLectureName(rs.getString("lectureName"));
				evaluationDTO.setProfessorName(rs.getString("professorName"));
				evaluationDTO.setLectureYear(rs.getInt("lectureYear"));
				evaluationDTO.setSemesterDivide(rs.getString("semesterDivide"));
				evaluationDTO.setLectureDivide(rs.getString("lectureDivide"));
				evaluationDTO.setEvaluationTitle(rs.getString("evaluationTitle"));
				evaluationDTO.setEvaluationContent(rs.getString("evaluationContent"));
				evaluationDTO.setTotalScore(rs.getString("totalScore"));
				evaluationDTO.setCreditScore(rs.getString("creditScore"));
				evaluationDTO.setLectureScore(rs.getString("lectureScore"));
				evaluationDTO.setLikeCount(rs.getInt("likeCount"));

				evaluationList.add(evaluationDTO);
			}
			
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			try {if(conn != null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return evaluationList; //데이터베이스 오류
	
	}
	
	public int like(String evaluationID) {
		String sql = "UPDATE EVALUATION SET likeCount = likeCount + 1 WHERE evaluationID = ?";
		Connection conn = null; 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, evaluationID);
			return pstmt.executeUpdate();	
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			try {
				if(conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			try {
				if(pstmt != null) {
					pstmt.close();
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			try {
				if(rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		return -1; 
	}	
	
	public int delete(String evaluationID) {
		String sql = "DELETE FROM EVALUATION WHERE evaluationID = ?";
		Connection conn = null; 
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(evaluationID));
			return pstmt.executeUpdate();	
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			try {
				if(conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			try {
				if(pstmt != null) {
					pstmt.close();
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			try {
				if(rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		return -1; 
	}	
	
	public String getUserID(String evaluationID) {
		String sql = "SELECT userID FROM EVALUATION WHERE evaluationID = ?";
		Connection conn = null; //�����ͺ��̽��� ����
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(evaluationID));
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			try {
				if(conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			try {
				if(pstmt != null) {
					pstmt.close();
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
			try {
				if(rs != null) {
					rs.close();
				}
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();
			}
		}
		return null; //�����ͺ��̽� ����
	}
	
}











