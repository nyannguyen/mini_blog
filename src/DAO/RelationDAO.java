package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class RelationDAO {
	public static int friendsCount(int uid) throws SQLException
	{
		Connection conn = DatabaseConnection.getConnection();
		
		String query = "SELECT count(*) FROM tbl_relations WHERE (uid_1=? OR uid_2=?) AND (status=?)";
		
		PreparedStatement pstm = conn.prepareStatement(query);
				
		pstm.setInt(1, uid);
		pstm.setInt(2, uid);
		pstm.setBoolean(3, true);
		
		ResultSet rs = pstm.executeQuery();
		
		if(rs.next()) {
			return rs.getInt(1);
		} else {
			return 0;
		}
	}
	
	/**
	 * Get the relationship between 2 user
	 * @param uid1
	 * @param uid2
	 * @return Friend -1 || Pending 0 || Stranger -1
	 * @throws SQLException
	 */
	public static int relationState(int uid1, int uid2) throws SQLException
	{
		Connection conn = DatabaseConnection.getConnection();
		
		String query = "SELECT status FROM tbl_relations WHERE (uid_1=? AND uid_2=?) OR (uid_1=? AND uid_2=?)";
		
		PreparedStatement pstm = conn.prepareStatement(query);
				
		pstm.setInt(1, uid1);
		pstm.setInt(2, uid2);
		pstm.setInt(3, uid2);
		pstm.setInt(4, uid1);
		
		ResultSet rs = pstm.executeQuery();
		
		if(rs.next()) {
			return rs.getInt(1);
		} else {
			return -1;
		}
	}
}
