package util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DatabaseUtil {

	public static Connection getConnection() {
			try {
				String dbURL = "jdbc:oracle:thin:@localhost:1521:XE";
				String dbID = "minse";
				String dbPassword = "marilyn21";
				Class.forName("oracle.jdbc.driver.OracleDriver");
				return DriverManager.getConnection(dbURL, dbID, dbPassword);
			} catch (Exception e) {
				// TODO: handle exception
				e.printStackTrace();//������ ���� �������
			}
			return null;
	}
}
