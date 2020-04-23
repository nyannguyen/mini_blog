package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;

import Models.Relation;
import Models.User;

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
	
	public static boolean create(Relation r) throws SQLException
	{
		Connection conn = DatabaseConnection.getConnection();
		
		String query = "INSERT INTO tbl_relations (uid_1,uid_2,status,created_at) VALUES (?,?,?,?)";
		
		PreparedStatement pstm = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
		
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		
		pstm.setInt(1, r.getUid_1());
		pstm.setInt(2, r.getUid_2());
		pstm.setBoolean(3, r.isStatus());
		pstm.setTimestamp(4, timestamp);
		
		int affectedRows = pstm.executeUpdate();
		if(affectedRows == 0) return false;
		
		ResultSet rs = pstm.getGeneratedKeys();
		if(rs.next()) {
			r.setId(rs.getInt(1));
			r.setCreated_at(timestamp);
		}		
		return true;
	}

	
	/**
	 * Get the relationship between 2 user
	 * @param uid1
	 * @param uid2
	 * @return Friend 2 || Waiting friend's answer 0 || Waiting to accept 1 || Stranger -1
	 * @throws SQLException
	 */
	public static int relationState(int uid1, int uid2) throws SQLException
	{
		Connection conn = DatabaseConnection.getConnection();
		
		String query = "SELECT * FROM tbl_relations WHERE (uid_1=? AND uid_2=?) OR (uid_1=? AND uid_2=?)";
		
		PreparedStatement pstm = conn.prepareStatement(query);
				
		pstm.setInt(1, uid1);
		pstm.setInt(2, uid2);
		pstm.setInt(3, uid2);
		pstm.setInt(4, uid1);
		
		ResultSet rs = pstm.executeQuery();
		
		if(rs.next()) {
			int status = rs.getInt("status");
			if(status == 1) return 2;
			if(uid1 == rs.getInt("uid_1")) return 0;
			return 1;
		} else {
			return -1;
		}
	}
	
	public static boolean acceptInvite(int uid1, int uid2) throws SQLException
	{
		Connection conn = DatabaseConnection.getConnection();
		
		String query = "UPDATE tbl_relations SET status = 1 WHERE uid_1=? AND uid_2=?";
		
		PreparedStatement pstm = conn.prepareStatement(query);
				
		pstm.setInt(1, uid2);
		pstm.setInt(2, uid1);
		
		int affectedRows = pstm.executeUpdate();
		if(affectedRows == 0) return false;
		
		return true;
	}
	
	public static boolean removeFriend(int uid1, int uid2) throws SQLException
	{
		Connection conn = DatabaseConnection.getConnection();
		
		String query = "DELETE FROM tbl_relations WHERE (uid_1=? AND uid_2=?) OR (uid_1=? AND uid_2=?)";
		
		PreparedStatement pstm = conn.prepareStatement(query);
				
		pstm.setInt(1, uid1);
		pstm.setInt(2, uid2);
		pstm.setInt(3, uid2);
		pstm.setInt(4, uid1);
		
		int affectedRows = pstm.executeUpdate();
		if(affectedRows == 0) return false;
		
		return true;
	}
	
	public static int requestCount(int uid) throws SQLException
	{
		Connection conn = DatabaseConnection.getConnection();
		
		String query = "SELECT count(*) FROM tbl_relations WHERE uid_2=? AND status=0";
		
		PreparedStatement pstm = conn.prepareStatement(query);
				
		pstm.setInt(1, uid);
		
		ResultSet rs = pstm.executeQuery();
		
		if(rs.next()) {
			return rs.getInt(1);
		} else {
			return 0;
		}
	}
	
	public static ArrayList<User> getAllRequest(int uid) throws SQLException 
	{
		ArrayList<User> result = new ArrayList<User>();
		
		Connection conn = DatabaseConnection.getConnection();
		
		String query = "SELECT uid_1 FROM tbl_relations WHERE uid_2=? AND status=0";
		
		PreparedStatement pstm = conn.prepareStatement(query);
				
		pstm.setInt(1, uid);
		
		ResultSet rs = pstm.executeQuery();
		
		while(rs.next()) {
			result.add(User.whereId(rs.getInt(1)));
		}
		
		return result;
	}
	
	public static ArrayList<User> getAllFriends(int uid) throws SQLException
	{
		ArrayList<User> result = new ArrayList<User>();
		
		Connection conn = DatabaseConnection.getConnection();
		
		String query = "SELECT uid_1,uid_2 FROM tbl_relations WHERE (status=1) AND (uid_1=? OR uid_2=?)";
		
		PreparedStatement pstm = conn.prepareStatement(query);
				
		pstm.setInt(1, uid);
		pstm.setInt(2, uid);
		
		ResultSet rs = pstm.executeQuery();
		
		while(rs.next()) {
			if(rs.getInt(1)==uid) {
				result.add(User.whereId(rs.getInt(2)));
			}
			if(rs.getInt(2)==uid) {
				result.add(User.whereId(rs.getInt(1)));
			}
		}
		
		return result;
	}
}
