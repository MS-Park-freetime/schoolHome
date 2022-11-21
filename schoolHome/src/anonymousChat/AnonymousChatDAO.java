package anonymousChat;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class AnonymousChatDAO {
	
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
	
	public ArrayList<AnonymousChatDTO> getChatList(String nowTime){
		ArrayList<AnonymousChatDTO> chatList = null;
		String sql = "SELECT * FROM anonymouschatting WHERE chatTime > ? ORDER BY chatTime";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, nowTime);
			rs = pstmt.executeQuery();
			chatList = new ArrayList<AnonymousChatDTO>();
			while (rs.next()) {
				AnonymousChatDTO chatDTO = new AnonymousChatDTO();
				chatDTO.setChatID(rs.getInt("chatID"));
				chatDTO.setChatName(rs.getString("chatName"));
				chatDTO.setChatContent(rs.getString("chatContent").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>").replaceAll(" ", "&nbsp;"));
				int chatTime = Integer.parseInt(rs.getString("chatTime").substring(11, 13));
				String timeType = "오전";
				if(Integer.parseInt(rs.getString("chatTime").substring(11, 13)) >= 12){
					timeType = "오후";
					chatTime -= 12;
				}
				chatDTO.setChatTime(rs.getString("chatTime").substring(0, 11) + " " + timeType + " " + chatTime + ":" + rs.getString("chatTime").substring(14, 16) + "");
				chatList.add(chatDTO);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			try {if(conn != null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return chatList;
		
	}
	
	public ArrayList<AnonymousChatDTO> getChatListByRecent(int number){
		ArrayList<AnonymousChatDTO> chatList = null;
		String sql = "SELECT * FROM anonymouschatting WHERE chatID > (SELECT MAX(chatID) - ?  FROM anonymouschatting) ORDER BY chatTime";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, number);
			rs = pstmt.executeQuery();
			chatList = new ArrayList<AnonymousChatDTO>();
			while (rs.next()) {
				AnonymousChatDTO chatDTO = new AnonymousChatDTO();
				chatDTO.setChatID(rs.getInt("chatID"));
				chatDTO.setChatName(rs.getString("chatName"));
				chatDTO.setChatContent(rs.getString("chatContent").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>").replaceAll(" ", "&nbsp;"));
				int chatTime = Integer.parseInt(rs.getString("chatTime").substring(11, 13));
				String timeType = "오전";
				if(Integer.parseInt(rs.getString("chatTime").substring(11, 13)) >= 12){
					timeType = "오후";
					chatTime -= 12;
				}
				chatDTO.setChatTime(rs.getString("chatTime").substring(0, 11) + " " + timeType + " " + chatTime + ":" + rs.getString("chatTime").substring(14, 16) + "");
				chatList.add(chatDTO);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			try {if(conn != null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return chatList;
		
	}
	
	public ArrayList<AnonymousChatDTO> getChatListByRecent(String chatID){
		ArrayList<AnonymousChatDTO> chatList = null;
		String sql = "SELECT * FROM anonymouschatting WHERE chatID > ? ORDER BY chatTime";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, Integer.parseInt(chatID));
			rs = pstmt.executeQuery();
			chatList = new ArrayList<AnonymousChatDTO>();
			while (rs.next()) {
				AnonymousChatDTO chatDTO = new AnonymousChatDTO();
				chatDTO.setChatID(rs.getInt("chatID"));
				chatDTO.setChatName(rs.getString("chatName"));
				chatDTO.setChatContent(rs.getString("chatContent").replaceAll("<", "&lt;").replaceAll(">", "&gt;").replaceAll("\r\n", "<br>").replaceAll(" ", "&nbsp;"));
				int chatTime = Integer.parseInt(rs.getString("chatTime").substring(11, 13));
				String timeType = "오전";
				if(Integer.parseInt(rs.getString("chatTime").substring(11, 13)) >= 12){
					timeType = "오후";
					chatTime -= 12;
				}
				chatDTO.setChatTime(rs.getString("chatTime").substring(0, 11) + " " + timeType + " " + chatTime + ":" + rs.getString("chatTime").substring(14, 16) + "");
				chatList.add(chatDTO);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}finally {
			try {if(conn != null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return chatList;
		
	}
	
	public int submit(String chatName, String chatContent) {
		String sql = "INSERT INTO anonymouschatting VALUES(anonymous_seq.nextval, ?, ?, ?)";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, chatName);
			pstmt.setString(2, chatContent);
			pstmt.setString(3, getDate());
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
}
