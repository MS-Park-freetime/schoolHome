package search;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;

import user.Guest;
import util.DatabaseUtil;



public class UserSearchDAO {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private static UserSearchDAO instance = new UserSearchDAO();

	public static UserSearchDAO getInstance() {
		return instance;
	}
	public UserSearchDAO() {
		try {
			String dbURL = "jdbc:oracle:thin:@localhost:1521:XE";
			String dbID = "minse";
			String dbPassword = "marilyn21";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(dbURL, dbID, dbPassword);
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	public ArrayList<Guest> search(String userID) {
		String sql = "select * from login WHERE userID LIKE ?";
		ArrayList<Guest> searchList = new ArrayList<Guest>();
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + userID + "%");
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Guest guest = new Guest();
				guest.setUserID(rs.getString(1));
				guest.setUserName(rs.getString(3));
				guest.setUserAge(rs.getInt(4));
				guest.setUserGender(rs.getString(5));
				guest.setUserEmail(rs.getString(6));
				searchList.add(guest);
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return searchList;
	}
	
	
}
