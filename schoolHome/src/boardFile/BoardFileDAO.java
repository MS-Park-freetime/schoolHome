package boardFile;

import java.sql.*;
import javax.sql.*;

import board.BoardDataBean;
import user.Guest;
import util.DatabaseUtil;

import javax.naming.*;
import java.util.*;

public class BoardFileDAO {
	private Connection conn; // �����ͺ��̽��� ����
	private ResultSet rs;
	private static BoardFileDAO instance = new BoardFileDAO();

	public static BoardFileDAO getInstance() {
		return instance;
	}

	public BoardFileDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:comp/env");
			DataSource ds = (DataSource) envContext.lookup("jdbc/jspTest");
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();// ������ ���� �������
		}
	}
	public String getDate() { //���� �ð��� �������� �Լ� �Խ����� ���� �ۼ��ҋ� ���� ������ �ð��� �־��ִ� ����
		String sql = "SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD hh24:mi:ss') FROM DUAL";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1); // ������ ��¥�� �״�� ��ȯ�ϵ��� ��.
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "";
	}
	public int getNext() { // ���� �ð��� �������� �Լ� �Խ����� ���� �ۼ��ҋ� ���� ������ �ð��� �־��ִ� ����
		String sql = "SELECT num FROM boardtest ORDER BY num DESC"; // �Խñ� ��ȣ
		try {
			PreparedStatement pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getInt(1) + 1; // ������ ��¥�� �״�� ��ȯ�ϵ��� ��.
			}
			return 1;// ù��° �Խù��� ���
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return -1;// �����ͺ��̽� ����
	}

	public int write(String userID, String boardTitle, String boardContent, String boardFile, String boardRealFile) {
		//String sql = "INSERT INTO boardFile SELECT ?, NVL((SELECT MAX(num) + 1 FROM boardFile), 1), ?, ?, ?, 0, ?, ?, NVL((SELECT MAX(ref) + 1 FROM boardFile), 0), 0, 0";
		String sql = "INSERT INTO boardFile VALUES (NVL((SELECT MAX(num) + 1 FROM boardFile), 1), ?, ?, ?, ?, 0, ?, ?, NVL((SELECT MAX(ref) + 1 FROM boardFile), 0), 0, 0)";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			pstmt.setString(2, boardTitle);
			pstmt.setString(3, boardContent);
			pstmt.setString(4, getDate());
			pstmt.setString(5, boardFile);
			pstmt.setString(6, boardRealFile);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			try {if(conn != null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return -1;
	}
	
	public BoardFileDTO getBoard(int num) {
		String sql = "SELECT * FROM boardFile WHERE num = ?";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardFileDTO boardFile = new BoardFileDTO();
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				boardFile.setNum(rs.getInt("num"));
				boardFile.setUserID(rs.getString("userID"));
				boardFile.setBoardTitle(rs.getString("boardTitle"));
				boardFile.setBoardContent(rs.getString("boardContent"));
				boardFile.setBoardDate(rs.getString("boardDate"));
				boardFile.setReadcount(rs.getInt("readcount"));
				boardFile.setBoardFile(rs.getString("boardFile"));
				boardFile.setBoardRealFile(rs.getString("boardRealFile"));
				boardFile.setRef(rs.getInt("ref"));
				boardFile.setRe_step(rs.getInt("re_step"));
				boardFile.setRe_level(rs.getInt("re_level"));
			}
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			try {if(conn != null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return boardFile;
	}
	/*
	public ArrayList<BoardFileDTO> getList() {
		String sql = "SELECT * FROM boardFile WHERE ORDER BY ref DESC, re_step ASC";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		ArrayList<BoardFileDTO> boardFileList = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			boardFileList = new ArrayList<BoardFileDTO>();
			if(rs.next()) {
				BoardFileDTO boardFile = new BoardFileDTO();
				boardFile.setNum(rs.getInt("num"));
				boardFile.setUserID(rs.getString("userID"));
				boardFile.setBoardTitle(rs.getString("boardTitle"));
				boardFile.setBoardContent(rs.getString("boardContent"));
				boardFile.setBoardDate(rs.getString("boardDate"));
				boardFile.setReadcount(rs.getInt("readcount"));
				boardFile.setBoardFile(rs.getString("boardFile"));
				boardFile.setBoardRealFile(rs.getString("boardRealFile"));
				boardFile.setRef(rs.getInt("ref"));
				boardFile.setRe_step(rs.getInt("re_step"));
				boardFile.setRe_level(rs.getInt("rs_level"));
				boardFileList.add(boardFile);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			try {if(conn != null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return boardFileList;
	}*/
	public ArrayList<BoardFileDTO> getArticles(int start, int end) throws Exception {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		ArrayList<BoardFileDTO> boardFileList = null;
		PreparedStatement pstmt = null;
		try {
			conn = DatabaseUtil.getConnection();

			pstmt = conn.prepareStatement(
					"select list2.* from(select rownum r, list1.* from(select * from boardFile order by ref desc, re_step asc)list1) list2 where r between ? and ?");
			pstmt.setInt(1, start);
			pstmt.setInt(2, start + end - 1);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				int i = 0;
				boardFileList = new ArrayList(end);
				do {
					BoardFileDTO boardFile = new BoardFileDTO();
					boardFile.setNum(rs.getInt("num"));
					boardFile.setUserID(rs.getString("userID"));
					boardFile.setBoardTitle(rs.getString("boardTitle"));
					boardFile.setBoardContent(rs.getString("boardContent"));
					boardFile.setBoardDate(rs.getString("boardDate"));
					boardFile.setReadcount(rs.getInt("readcount"));
					boardFile.setBoardFile(rs.getString("boardFile"));
					boardFile.setBoardRealFile(rs.getString("boardRealFile"));
					boardFile.setRef(rs.getInt("ref"));
					boardFile.setRe_step(rs.getInt("re_step"));
					boardFile.setRe_level(rs.getInt("re_level"));
					boardFileList.add(boardFile);
					i++;
				} while (rs.next() && i < end);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {if(conn != null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return boardFileList;
	}

	
	public int getArticleCount() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		try {
			conn = DatabaseUtil.getConnection();

			pstmt = conn.prepareStatement("select count(*) from boardFile");
			rs = pstmt.executeQuery();

			if (rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {if(conn != null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return x;
	}
	
	public BoardFileDTO boardFileReadCount(int num) {
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardFileDTO boardFile = new BoardFileDTO();
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement("UPDATE boardFile SET readcount = readcount + 1 WHERE num = ?");
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
			
			pstmt = conn.prepareStatement("SELECT * FROM boardFile WHERE num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				boardFile.setNum(rs.getInt("num"));
				boardFile.setUserID(rs.getString("userID"));
				boardFile.setBoardTitle(rs.getString("boardTitle"));
				boardFile.setBoardContent(rs.getString("boardContent"));
				boardFile.setBoardDate(rs.getString("boardDate"));
				boardFile.setReadcount(rs.getInt("readcount"));
				boardFile.setBoardFile(rs.getString("boardFile"));
				boardFile.setBoardRealFile(rs.getString("boardRealFile"));
				boardFile.setRef(rs.getInt("ref"));
				boardFile.setRe_step(rs.getInt("re_step"));
				boardFile.setRe_level(rs.getInt("re_level"));
			}
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			try {if(conn != null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return boardFile;
		
	}
	
	public String getFile(int num) {
		String sql = "SELECT boardFile FROM boardFile WHERE num = ?";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardFileDTO boardFile = new BoardFileDTO();
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString("boardFile");
			}
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			try {if(conn != null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return "";
	}
	
	public String getRealFile(int num) {
		String sql = "SELECT boardRealFile FROM boardFile WHERE num = ?";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardFileDTO boardFile = new BoardFileDTO();
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString("boardRealFile");
			}
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			try {if(conn != null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return "";
	}
	
	public int update(int num, String userID, String boardTitle, String boardContent, String boardFile, String boardRealFile) {
		String sql = "UPDATE boardFile SET boardTitle = ?, boardContent = ?, boardFile = ?, boardRealFile = ? WHERE num = ?";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, boardTitle);
			pstmt.setString(2, boardContent);
			pstmt.setString(3, boardFile);
			pstmt.setString(4, boardRealFile);
			pstmt.setInt(5, num);

			return pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			try {if(conn != null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return -1;
	}
	
	public int delete(int num) {
		String sql = "DELETE FROM boardFile WHERE num = ?";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			
			return pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			try {if(conn != null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return -1;
	}
	
	public int reply(String userID, String boardTitle, String boardContent, String boardFile, String boardRealFile, BoardFileDTO parent) {
		//String sql = "INSERT INTO boardFile SELECT ?, NVL((SELECT MAX(num) + 1 FROM boardFile), 1), ?, ?, ?, 0, ?, ?, NVL((SELECT MAX(ref) + 1 FROM boardFile), 0), 0, 0";
		String sql = "INSERT INTO boardFile VALUES (NVL((SELECT MAX(num) + 1 FROM boardFile), 1), ?, ?, ?, ?, 0, ?, ?, ?, ?, ?)";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			pstmt.setString(2, boardTitle);
			pstmt.setString(3, boardContent);
			pstmt.setString(4, getDate());
			pstmt.setString(5, boardFile);
			pstmt.setString(6, boardRealFile);
			pstmt.setInt(7, parent.getRef());
			pstmt.setInt(8, parent.getRe_step() + 1);
			pstmt.setInt(9, parent.getRe_level() + 1);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			try {if(conn != null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return -1;
	}
	
	public int replyUpdate(BoardFileDTO parent) {
		String sql = "UPDATE boardFile SET re_step = re_step + 1 WHERE ref = ? AND re_step > ?";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, parent.getRef());
			pstmt.setInt(2, parent.getRe_step());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			try {if(conn != null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return -1;
	}
}