package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;

import Models.Log;

public class LogDAO {
	public static boolean create(Log log) throws SQLException {
		Connection conn = DatabaseConnection.getConnection();
		
		String query = "INSERT INTO tbl_log (uid,description,created_at) VALUES (?,?,?)";
		
		PreparedStatement pstm = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
		
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		
		pstm.setInt(1, log.getUid());
		pstm.setString(2, log.getDescription());
		pstm.setTimestamp(3, timestamp);
		
		int affectedRows = pstm.executeUpdate();
		if(affectedRows == 0) return false;
		
		ResultSet rs = pstm.getGeneratedKeys();
		if(rs.next()) {
			log.setId(rs.getInt(1));
			log.setCreated_at(timestamp);
		}		
		return true;
	}
	
	public static Log loadResultSet(ResultSet rs) throws SQLException {
		Log log = new Log(
				rs.getInt("id"),
				rs.getInt("uid"),
				rs.getString("description"),
				rs.getTimestamp("created_at"));
		return log;
	}
	
	/**
	 * Get all activities log by user id
	 * @param uid
	 * @return ArrayList<Log>
	 * @throws SQLException
	 */
	public static ArrayList<Log> whereUid(int uid) throws SQLException {
		ArrayList<Log> result = new ArrayList<Log>();
		Connection conn = DatabaseConnection.getConnection();
		
		String query = "SELECT * FROM tbl_log WHERE uid=? orderBy id DESC";
		
		PreparedStatement pstm = conn.prepareStatement(query);
				
		pstm.setInt(1, uid);
		
		ResultSet rs = pstm.executeQuery();
		
		if(rs.next()) {		
			result.add(loadResultSet(rs));
		}
		
		return result;
	}
}
