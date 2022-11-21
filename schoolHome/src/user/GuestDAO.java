package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import notice.NoticeCommentDAO;
import user.Guest;
import util.DatabaseUtil;

public class GuestDAO {
	private static GuestDAO instance = new GuestDAO();

	public static GuestDAO getInstance() {
		return instance;
	}
	
	public int registerCheck(String userID) {
		String sql = "SELECT * FROM login WHERE userID = ?";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next() || userID.equals("")) {
				return 0;
			}else {
				return 1; //가입가능한 아이디
			}
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			try {if(conn != null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return -1;
	}
	
	public int find(String userName) {
		String sql = "select * from login WHERE userName = ?";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userName);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				Guest guest = new Guest();
				guest.setUserID(rs.getString(1));
				guest.setUserName(rs.getString(3));
				guest.setUserAge(rs.getInt(4));
				guest.setUserGender(rs.getString(5));
				guest.setUserEmail(rs.getString(6));
				return 0;
			}
		} catch (Exception e) {
			// TODO: handle exception
			e.printStackTrace();
		}
		return -1;
	}
	public int register(String userID, String userPassword, String userName, String userAge, String userGender, String userEmail, String userEmailHash, String userEmailChecked, String userProfile) {
		String sql = "INSERT INTO login VALUES (?, ?, ?, ?, ?, ?, ?, 'FALSE', ?)";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			pstmt.setString(2, userPassword);
			pstmt.setString(3, userName);
			pstmt.setInt(4, Integer.parseInt(userAge));
			pstmt.setString(5, userGender);
			pstmt.setString(6, userEmail);
			pstmt.setString(7, userEmailHash);
			pstmt.setString(8, userProfile);
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
	/*public int register(Guest guest) {
		String sql = "INSERT INTO login VALUES (?, ?, ?, ?, ?, ?, ?, 'FALSE', ?)";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, guest.getUserID());
			pstmt.setString(2, guest.getUserPassword());
			pstmt.setString(3, guest.getUserName());
			pstmt.setInt(4, guest.getUserAge());
			pstmt.setString(5, guest.getUserGender());
			pstmt.setString(6, guest.getUserEmail());
			pstmt.setString(7, guest.getUserEmailHash());
			pstmt.setString(8, guest.getUserProfile());
			return pstmt.executeUpdate();
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			try {if(conn != null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return -1;
	}*/
	
	public int login(String userID, String userPassword) {
		String sql = "SELECT userPassword FROM login WHERE userID = ?";
		Connection conn = null; //�����ͺ��̽��� ����
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);//prepareStatement�� ��� ������ sql������ �����ͺ��̽��� �����ϴ� ����
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery(); //������ ��� �ֱ
			if(rs.next()) {
				if(rs.getString(1).equals(userPassword)) {
					return 1; //�α��� ����
				}
				else {
					return 0; //��й�ȣ ����ġ
				}
			}
			return -1; //���̵� ����
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
		return -2; //�����ͺ��̽� ����
	}
	
	
	public String getUserEmail(String userID) {
		String sql = "SELECT userEmail FROM login WHERE userID = ?";
		Connection conn = null; //�����ͺ��̽��� ����
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn= DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
			return "TRUE";
		
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
	
	public String getUserEmailChecked(String userID) {
		String sql = "SELECT userEmailChecked FROM login WHERE userID = ?";
		Connection conn = null; //�����ͺ��̽��� ����
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				return rs.getString(1);
			}
			return "TRUE";
		
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
		return "FALSE"; //�����ͺ��̽� ����
	}

	public String setUserEmailChecked(String userID) {
		String sql = "UPDATE login SET userEmailChecked = 'TRUE' WHERE userID = ?";
		Connection conn = null; //�����ͺ��̽��� ����
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			return "TRUE";			
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
		return "FALSE"; //�����ͺ��̽� ����
	}
	
	public Guest getUserInfo(String userID) {
		String sql = "SELECT * FROM login WHERE userID = ?";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		Guest guest = new Guest();
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				guest.setUserID(userID);
				guest.setUserPassword(rs.getString("userPassword"));
				guest.setUserName(rs.getString("userName"));
				guest.setUserAge(rs.getInt("userAge"));
				guest.setUserGender(rs.getString("userGender"));
				guest.setUserEmail(rs.getString("userEmail"));
				guest.setUserEmailHash(rs.getString("userEmailHash"));
				guest.setUserEmailChecked(rs.getString("userEmailChecked"));
				guest.setUserProfile(rs.getString("userProfile"));
			}
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			try {if(conn != null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return guest;
	}
	
	public int infoUpdate(String userID, String userPassword, String userName, int userAge, String userGender, String userEmail) {
		String sql = "UPDATE login SET userPassword = ?, userName = ?, userAge = ?, userGender = ?, userEmail = ? WHERE userID = ?";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userPassword);
			pstmt.setString(2, userName);
			pstmt.setInt(3, userAge);
			pstmt.setString(4, userGender);
			pstmt.setString(5, userEmail);
			pstmt.setString(6, userID);
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
	
	public int profile(String userID, String userProfile) {
		String sql = "UPDATE login SET userProfile = ? WHERE userID = ?";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);			
			pstmt.setString(1, userProfile);
			pstmt.setString(2, userID);
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
	
	public String getProfile(String userID) {
		String sql = "SELECT userProfile FROM login WHERE userID = ?";
		Connection conn = null; //데이터베이스에 접근
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getString("userProfile").equals("") || rs.getString("userProfile") == null) {
					return "http://localhost:8090/DesignWebProject/images/profile.png";
				}
				return "http://localhost:8090/DesignWebProject/upload/" + rs.getString("userProfile");
			}
		} catch (Exception e) {
			// TODO: handle exception
		}finally {
			try {if(conn != null) {conn.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(pstmt != null) {pstmt.close();}} catch (Exception e) {e.printStackTrace();}
			try {if(rs != null) {rs.close();}} catch (Exception e) {e.printStackTrace();}
		}
		return "http://localhost:8090/DesignWebProject/images/profile.png";
	}
}





