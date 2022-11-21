package notice;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import anonymousChat.AnonymousChatDTO;
import util.DatabaseUtil;

public class NoticeDAO {
	private static NoticeDAO instance = new NoticeDAO();
	public static NoticeDAO getInstance() {
		return instance;
	}
	public int getNext() { // ���� �ð��� �������� �Լ� �Խ����� ���� �ۼ��ҋ� ���� ������ �ð��� �־��ִ� ����
		String sql = "SELECT num FROM notice ORDER BY num DESC"; // �Խñ� ��ȣ
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
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
	
	public String getDate() { // ���� �ð��� �������� �Լ� �Խ����� ���� �ۼ��ҋ� ���� ������ �ð��� �־��ִ� ����
		String sql = "SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD hh24:mi:ss') FROM DUAL";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				return rs.getString(1); // ������ ��¥�� �״�� ��ȯ�ϵ��� ��.
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return "";
	}
	
	public int insertArticle(NoticeDTO notice, String userID) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int num = notice.getNum();
		String sql = "";

		try {
			conn = DatabaseUtil.getConnection();

			pstmt = conn.prepareStatement("select max(num) from notice");
			rs = pstmt.executeQuery();

			sql = "insert into notice(num,userID,subject,content,reg_date) values(notice_seq.nextval,?,?,?,?)";

			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			pstmt.setString(2, notice.getSubject());
			pstmt.setString(3, notice.getContent());
			pstmt.setString(4, getDate());

			return pstmt.executeUpdate();
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {if(conn != null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return -1;
	}

	public int getArticleCount() throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		int x = 0;

		try {
			conn = DatabaseUtil.getConnection();

			pstmt = conn.prepareStatement("select count(*) from notice");
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

	public List getArticles(int start, int end) throws Exception {
		Connection conn = null;
		Statement stmt = null;
		ResultSet rs = null;
		List noticeList = null;
		PreparedStatement pstmt = null;
		try {
			conn = DatabaseUtil.getConnection();

			pstmt = conn.prepareStatement(
					"select A.* from(select rownum r, B.*  from(select *  from notice order by num desc)B) A where r between ? and ?");
			pstmt.setInt(1, start);
			pstmt.setInt(2, start + end - 1);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				int i = 0;
				noticeList = new ArrayList(end);
				do {
					NoticeDTO notice = new NoticeDTO();
					notice.setNum(rs.getInt("num"));
					notice.setUserID(rs.getString("userID"));
					notice.setSubject(rs.getString("subject"));
					notice.setContent(rs.getString("content"));
					notice.setReg_date(rs.getString("reg_date"));
					notice.setReadcount(rs.getInt("readcount"));

					noticeList.add(notice);
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
		return noticeList;
	}

	public NoticeDTO getArticle(int num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		NoticeDTO notice = null;
		try {
			conn = DatabaseUtil.getConnection();

			pstmt = conn.prepareStatement("update notice set readcount=readcount+1 where num = ?");
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

			pstmt = conn.prepareStatement("select * from notice where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				notice = new NoticeDTO();
				notice.setNum(rs.getInt("num"));
				notice.setUserID(rs.getString("userID"));
				notice.setSubject(rs.getString("subject"));
				notice.setContent(rs.getString("content"));
				notice.setReg_date(rs.getString("reg_date"));
				notice.setReadcount(rs.getInt("readcount"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {if(conn != null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return notice;
	}

	public NoticeDTO updateGetArticle(int num) throws Exception {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		NoticeDTO notice = null;
		try {
			conn = DatabaseUtil.getConnection();

			pstmt = conn.prepareStatement("select * from notice where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				notice = new NoticeDTO();
				notice.setNum(rs.getInt("num"));
				notice.setUserID(rs.getString("userID"));
				notice.setSubject(rs.getString("subject"));
				notice.setContent(rs.getString("content"));
				notice.setReg_date(rs.getString("reg_date"));
				notice.setReadcount(rs.getInt("readcount"));
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {if(conn != null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return notice;
	}
	public int update(int num, String subject, String content) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		String sql = "UPDATE notice SET subject = ?, content = ? WHERE num = ?"; // �Խñ� ��ȣ
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, subject);
			pstmt.setString(2, content);
			pstmt.setInt(3, num);
			return pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		} finally {
			try {if(conn != null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
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
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement("select userID from notice where num = ?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				user = rs.getString("userID");
				if (user.equals(userID)) {
					pstmt = conn.prepareStatement("delete from notice where num=?");
					pstmt.setInt(1, num);
					pstmt.executeUpdate();
					x = 1; // �ۻ��� ����
				}
			}
		} catch (Exception ex) {
			ex.printStackTrace();
		} finally {
			try {if(conn != null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return 0;
	}
	
}
