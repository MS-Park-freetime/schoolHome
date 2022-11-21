package board;

import java.sql.*;
import javax.sql.*;
import javax.naming.*;
import java.util.*;

public class BoardDBBean {
	private Connection conn; // �����ͺ��̽��� ����
	private ResultSet rs;
	private static BoardDBBean instance = new BoardDBBean();

	public static BoardDBBean getInstance() {
		return instance;
	}

	public BoardDBBean() {
		try {
			String dbURL = "jdbc:oracle:thin:@localhost:1521:XE";
			String dbID = "minse";
			String dbPassword = "marilyn21";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();// ������ ���� �������
		}
	}

	private Connection getConnection() throws Exception {
		Context initCtx = new InitialContext();
		Context envCtx = (Context) initCtx.lookup("java:comp/env");
		DataSource ds = (DataSource) envCtx.lookup("jdbc/jspTest");
		return ds.getConnection();
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

	public int insertArticle(BoardDataBean article, String userID) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int num = article.getNum();
		int ref = article.getRef();
		int re_step = article.getRe_step();
		int re_level = article.getRe_level();
		int number = 0;
		String sql = "";

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select max(num) from boardtest");
			rs = pstmt.executeQuery();

			if (rs.next())
				number = rs.getInt(1) + 1;
			else
				number = 1;

			if (num != 0) //
			{
				sql = "update boardtest set re_step=re_step+1 where ref= ? and re_step> ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, ref);
				pstmt.setInt(2, re_step);
				pstmt.executeUpdate();
				re_step = re_step + 1;
				re_level = re_level + 1;
			} else {
				ref = number;
				re_step = 0;
				re_level = 0;
			}
			// ������ �ۼ�
			sql = "insert into boardtest(num,userID,subject,reg_date,";
			sql += "ref,re_step,re_level,content) values(?,?,?,?,?,?,?,?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, getNext());
			pstmt.setString(2, userID);
			pstmt.setString(3, article.getSubject());
			pstmt.setTimestamp(4, article.getReg_date());
			pstmt.setInt(5, ref);
			pstmt.setInt(6, re_step);
			pstmt.setInt(7, re_level);
			pstmt.setString(8, article.getContent());

			return pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return -1;
	}

	public int getArticleCount() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select count(*) from boardtest");
			rs = pstmt.executeQuery();

			if (rs.next()) {
				x = rs.getInt(1);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return x;
	}

	public List getArticles(int start, int end) throws Exception {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		List articleList = null;
		PreparedStatement pstmt = null;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement(
					"select list2.* from(select rownum r, list1.*  from(select *  from boardtest order by ref desc, re_step asc)list1) list2 where r between ? and ?");
			pstmt.setInt(1, start);
			pstmt.setInt(2, start + end - 1);
			rs = pstmt.executeQuery();
			/*
			 * try { conn = getConnection( ); stmt = conn.createStatement(
			 * ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY ); String query
			 * ="select * from board order by ref desc, re_step asc"; rs =
			 * stmt.executeQuery( query );
			 * 
			 * int skip = start - 1;
			 * 
			 * if( skip > 0 ) rs.absolute( skip );
			 */
			if (rs.next()) {
				int i = 0;
				articleList = new ArrayList(end);
				do {
					BoardDataBean article = new BoardDataBean();
					article.setNum(rs.getInt("num"));
					article.setUserID(rs.getString("userID"));
					article.setSubject(rs.getString("subject"));
					article.setReg_date(rs.getTimestamp("reg_date"));
					article.setReadcount(rs.getInt("readcount"));
					article.setRef(rs.getInt("ref"));
					article.setRe_step(rs.getInt("re_step"));
					article.setRe_level(rs.getInt("re_level"));
					article.setContent(rs.getString("content"));

					articleList.add(article);
					i++;
				} while (rs.next() && i < end);
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (stmt != null)
				try {
					stmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return articleList;
	}

	public BoardDataBean getArticle(int num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardDataBean article = null;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("update boardtest set readcount=readcount+1 where num = ?");
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

			pstmt = conn.prepareStatement("select * from boardtest where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				article = new BoardDataBean();
				article.setNum(rs.getInt("num"));
				article.setUserID(rs.getString("userID"));
				article.setSubject(rs.getString("subject"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				article.setContent(rs.getString("content"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return article;
	}

	public BoardDataBean updateGetArticle(int num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		BoardDataBean article = null;
		try {
			conn = getConnection();

			pstmt = conn.prepareStatement("select * from boardtest where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				article = new BoardDataBean();
				article.setNum(rs.getInt("num"));
				article.setUserID(rs.getString("userID"));
				article.setSubject(rs.getString("subject"));
				article.setReg_date(rs.getTimestamp("reg_date"));
				article.setReadcount(rs.getInt("readcount"));
				article.setRef(rs.getInt("ref"));
				article.setRe_step(rs.getInt("re_step"));
				article.setRe_level(rs.getInt("re_level"));
				article.setContent(rs.getString("content"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return article;
	}

	/*
	 * public int updateArticle(BoardDataBean article) throws Exception { Connection
	 * conn = null; PreparedStatement pstmt = null; ResultSet rs = null;
	 * 
	 * String sql = ""; //int x = -1; try { conn = getConnection();
	 * 
	 * if (rs.next()) { sql =
	 * "UPDATE boardtest SET subject = ?, content = ? WHERE num = ?"; // �Խñ� ��ȣ
	 * pstmt = conn.prepareStatement(sql); pstmt.setString(1, article.getSubject());
	 * pstmt.setString(2, article.getContent()); pstmt.setInt(3, article.getNum());
	 * return pstmt.executeUpdate(); //x = 1; } /*else { x = 0; } } catch (Exception
	 * ex) { ex.printStackTrace(); } finally { if (rs != null) try { rs.close(); }
	 * catch (SQLException ex) { } if (pstmt != null) try { pstmt.close(); } catch
	 * (SQLException ex) { } if (conn != null) try { conn.close(); } catch
	 * (SQLException ex) { } } return -1; }
	 */
	public int update(int num, String subject, String content) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "UPDATE boardtest SET subject = ?, content = ? WHERE num = ?"; // �Խñ� ��ȣ
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, subject);
			pstmt.setString(2, content);
			pstmt.setInt(3, num);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return -1;// �����ͺ��̽� ����
	}

	public int deleteArticle(int num, String userID) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String user = "";
		int x = -1;
		try {
			conn = getConnection();
			pstmt = conn.prepareStatement("select userID from boardtest where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				user = rs.getString("userID");
				if (user.equals(userID)) {
					pstmt = conn.prepareStatement("delete from boardtest where num=?");
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
					x = 1; // �ۻ��� ����
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			if (rs != null)
				try {
					rs.close();
				} catch (SQLException ex) {
				}
			if (pstmt != null)
				try {
					pstmt.close();
				} catch (SQLException ex) {
				}
			if (conn != null)
				try {
					conn.close();
				} catch (SQLException ex) {
				}
		}
		return 0;
	}
}