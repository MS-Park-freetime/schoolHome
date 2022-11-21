package individualChat;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class IndividualDAO {
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
	
	public ArrayList<IndividualDTO> getChatListByID(String fromID, String toID, String individualID){
		ArrayList<IndividualDTO> individualList = null;
		String sql = "SELECT * FROM individualChatting WHERE ((fromID = ? AND toID = ?) OR (fromID = ? AND toID = ?)) AND individualID > ? ORDER BY individualTime";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fromID);
			pstmt.setString(2, toID);
			pstmt.setString(3, toID);
			pstmt.setString(4, fromID);
			pstmt.setInt(5, Integer.parseInt(individualID));
			rs = pstmt.executeQuery();
			individualList = new ArrayList<IndividualDTO>();
			while(rs.next()) {
				IndividualDTO individual = new IndividualDTO();
				individual.setIndividualID(rs.getInt("individualID"));
				individual.setFromID(rs.getString("fromID"));
				individual.setToID(rs.getString("toID"));
				individual.setIndividualContent(rs.getString("individualContent").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>").replaceAll(" ", "&nbsp;"));;
				int individualTime = Integer.parseInt(rs.getString("individualTime").substring(11, 13));
				String timeType = "오전";
				if(Integer.parseInt(rs.getString("individualTime").substring(11, 13)) >= 12){
					timeType = "오후";
					individualTime -= 12;
				}
				individual.setIndividualTIme(rs.getString("individualTime").substring(0, 11) + " " + timeType + " " + individualTime + ":" + rs.getString("individualTime").substring(14, 16) + "");
				individualList.add(individual);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			try {if(conn != null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return individualList;
	}
	
	public ArrayList<IndividualDTO> getChatListByRecent(String fromID, String toID, int number){
		ArrayList<IndividualDTO> individualList = null;
		String sql = "SELECT * FROM individualChatting WHERE ((fromID = ? AND toID = ?) OR (fromID = ? AND toID = ?)) AND individualID > (SELECT MAX(individualID) - ? FROM individualChatting WHERE (fromID = ? AND toID = ?) OR (fromID = ? AND toID = ?)) ORDER BY individualTime";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fromID);
			pstmt.setString(2, toID);
			pstmt.setString(3, toID);
			pstmt.setString(4, fromID);
			pstmt.setInt(5, number);
			pstmt.setString(6, fromID);
			pstmt.setString(7, toID);
			pstmt.setString(8, toID);
			pstmt.setString(9, fromID);
			rs = pstmt.executeQuery();
			individualList = new ArrayList<IndividualDTO>();
			while(rs.next()) {
				IndividualDTO individual = new IndividualDTO();
				individual.setIndividualID(rs.getInt("individualID"));
				individual.setFromID(rs.getString("fromID"));
				individual.setToID(rs.getString("toID"));
				individual.setIndividualContent(rs.getString("individualContent").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>").replaceAll(" ", "&nbsp;"));;
				int individualTime = Integer.parseInt(rs.getString("individualTime").substring(11, 13));
				String timeType = "오전";
				if(Integer.parseInt(rs.getString("individualTime").substring(11, 13)) >= 12){
					timeType = "오후";
					individualTime -= 12;
				}
				individual.setIndividualTIme(rs.getString("individualTime").substring(0, 11) + " " + timeType + " " + individualTime + ":" + rs.getString("individualTime").substring(14, 16) + "");
				individualList.add(individual);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			try {if(conn != null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return individualList;
	}

	public int submit(String fromID, String toID, String individualContent){
		String sql = "INSERT INTO individualChatting VALUES (individual_seq.nextval, ?, ?, ?, ?, 0)";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fromID);
			pstmt.setString(2, toID);
			pstmt.setString(3, individualContent);
			pstmt.setString(4, getDate());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			try {if(conn != null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return -1;
	}
	
	public int readChat(String fromID, String toID) {
		String sql = "UPDATE individualChatting SET individualRead = 1 WHERE (fromID = ? AND toID = ?)";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, toID);
			pstmt.setString(2, fromID);
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
	
	public int getUnreadChat(String userID) {
		String sql = "SELECT COUNT(individualID) FROM individualChatting WHERE toID = ? AND individualRead = 0";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt("COUNT(individualID)");
			}
			return 0;
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			try {if(conn != null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return -1;
	}
	
	public ArrayList<IndividualDTO> getIndividualChattingBox(String userID){
		ArrayList<IndividualDTO> individualList = null;
		String sql = "SELECT * FROM individualChatting WHERE individualID IN(SELECT MAX(individualID) FROM individualChatting WHERE toID = ? OR fromID = ? GROUP BY fromID, toID)";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			pstmt.setString(2, userID);
			rs = pstmt.executeQuery();
			individualList = new ArrayList<IndividualDTO>();
			while(rs.next()) {
				IndividualDTO individual = new IndividualDTO();
				individual.setIndividualID(rs.getInt("individualID"));
				individual.setFromID(rs.getString("fromID"));
				individual.setToID(rs.getString("toID"));
				individual.setIndividualContent(rs.getString("individualContent").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>").replaceAll(" ", "&nbsp;"));;
				int individualTime = Integer.parseInt(rs.getString("individualTime").substring(11, 13));
				String timeType = "오전";
				if(Integer.parseInt(rs.getString("individualTime").substring(11, 13)) >= 12){
					timeType = "오후";
					individualTime -= 12;
				}
				individual.setIndividualTIme(rs.getString("individualTime").substring(0, 11) + " " + timeType + " " + individualTime + ":" + rs.getString("individualTime").substring(14, 16) + "");
				individualList.add(individual);
			}
			for (int i = 0; i < individualList.size(); i++) {
				IndividualDTO x = individualList.get(i);
				for (int j = 0; j < individualList.size(); j++) {
					IndividualDTO y = individualList.get(j);
					if(x.getFromID().equals(y.getToID()) && x.getToID().equals(y.getFromID())) {
						if(x.getIndividualID() < y.getIndividualID()) {
							individualList.remove(x);
							i--;
							break;
						}else {
							individualList.remove(y);
							j--;
						}
					}
				}
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			try {if(conn != null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return individualList;
	}
	
	public int getUnreadChatCount(String fromID, String toID) {
		String sql = "SELECT COUNT(individualID) FROM individualChatting WHERE fromID = ? AND toID = ? AND individualRead = 0";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, fromID);
			pstmt.setString(2, toID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getInt("COUNT(individualID)");
			}
			return 0;
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

