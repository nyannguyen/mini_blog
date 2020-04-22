package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;

import Models.User;

public class UserDAO {
	/**
	 * Authentication
	 * @param user
	 * @return true | false
	 * @throws SQLException
	 */
	public static boolean login(User user) throws SQLException
	{
		Connection conn = DatabaseConnection.getConnection();
		
		String query = "SELECT * FROM tbl_users WHERE username=? AND password=? LIMIT 1";
		
		PreparedStatement pstm = conn.prepareStatement(query);
				
		pstm.setString(1, user.getUsername());
		pstm.setString(2, user.getPassword());
		
		ResultSet rs = pstm.executeQuery();
		
		if(rs.next()) {
			user.setId(rs.getInt("id"));
			user.setEmail(rs.getString("email"));
			user.setFirstname(rs.getString("firstname"));
			user.setLastname(rs.getString("lastname"));
			user.setCreated_at(rs.getTimestamp("created_at"));
			user.setUpdated_at(rs.getTimestamp("updated_at"));
			user.setDisabled_at(rs.getTimestamp("disabled_at"));
			
			return true;
		} else {
			return false;
		}
	}
	
	/**
	 * Insert a new User record
	 * @param user
	 * @return true | false
	 * @throws SQLException
	 */
	public static boolean create(User user) throws SQLException
	{
		Connection conn = DatabaseConnection.getConnection();
		
		String query = "INSERT INTO tbl_users (username,firstname,lastname,email,password,created_at) VALUES (?,?,?,?,?,?)";
		
		PreparedStatement pstm = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
		
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		
		pstm.setString(1, user.getUsername());
		pstm.setString(2, user.getFirstname());
		pstm.setString(3, user.getLastname());
		pstm.setString(4, user.getEmail());
		pstm.setString(5, user.getPassword());
		pstm.setTimestamp(6, timestamp);
		
		int affectedRows = pstm.executeUpdate();
		if(affectedRows == 0) return false;
		
		ResultSet rs = pstm.getGeneratedKeys();
		if(rs.next()) {
			user.setId(rs.getInt(1));
			user.setCreated_at(timestamp);
		}		
		return true;
	}
	
	public static User loadResultSet(ResultSet rs) throws SQLException {
		User user = new User(
				rs.getInt("id"),
				rs.getString("username"),
				rs.getString("email"),
				rs.getString("password"),
				rs.getString("firstname"),
				rs.getString("lastname"),
				rs.getTimestamp("created_at"),
				rs.getTimestamp("updated_at"),
				rs.getTimestamp("disabled_at"));
		return user;
	}
	
	/**
	 * Search User by their id
	 * @param username
	 * @return User | null
	 * @throws SQLException
	 */
	public static User whereId(int uid) throws SQLException
	{
		Connection conn = DatabaseConnection.getConnection();
		
		String query = "SELECT * FROM tbl_users WHERE id=? LIMIT 1";
		
		PreparedStatement pstm = conn.prepareStatement(query);
				
		pstm.setInt(1, uid);
		
		ResultSet rs = pstm.executeQuery();
		
		if(rs.next()) {		
			return loadResultSet(rs);
		} else {
			return null;
		}
	}
	
	/**
	 * Search User by their username
	 * @param username
	 * @return User | null
	 * @throws SQLException
	 */
	public static User whereUsername(String username) throws SQLException
	{
		Connection conn = DatabaseConnection.getConnection();
		
		String query = "SELECT * FROM tbl_users WHERE username=? LIMIT 1";
		
		PreparedStatement pstm = conn.prepareStatement(query);
				
		pstm.setString(1, username);
		
		ResultSet rs = pstm.executeQuery();
		
		if(rs.next()) {
			return loadResultSet(rs);
		} else {
			return null;
		}
	}
	
	/**
	 * Search User by their email
	 * @param email
	 * @return User | null
	 * @throws SQLException
	 */
	public static User whereEmail(String email) throws SQLException
	{
		Connection conn = DatabaseConnection.getConnection();
		
		String query = "SELECT * FROM tbl_users WHERE email=? LIMIT 1";
		
		PreparedStatement pstm = conn.prepareStatement(query);
				
		pstm.setString(1, email);
		
		ResultSet rs = pstm.executeQuery();
		
		if(rs.next()) {
			return loadResultSet(rs);
		} else {
			return null;
		}
	}
	
	public static boolean update(User user) throws SQLException
	{
		Connection conn = DatabaseConnection.getConnection();
		
		String query = "UPDATE tbl_users SET email=? , firstname=? , lastname=? , password=? , updated_at=? WHERE id=?";
		
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		
		PreparedStatement pstm = conn.prepareStatement(query);
				
		pstm.setString(1, user.getEmail());
		pstm.setString(2, user.getFirstname());
		pstm.setString(3, user.getLastname());
		pstm.setString(4, user.getPassword());
		pstm.setTimestamp(5, timestamp);
		pstm.setInt(6, user.getId());
		
		int affectedRows = pstm.executeUpdate();
		if(affectedRows == 0) return false;
		
		return true;
	}
}
