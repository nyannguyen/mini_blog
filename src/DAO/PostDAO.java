package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;

import Models.Comment;
import Models.Like;
import Models.Post;

public class PostDAO {
	public static boolean create(Post post) throws SQLException
	{
		Connection conn = DatabaseConnection.getConnection();
		
		String query = "INSERT INTO tbl_posts (uid,description,created_at) VALUES (?,?,?)";
		
		PreparedStatement pstm = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
		
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		
		pstm.setInt(1, post.getUid());
		pstm.setString(2, post.getDescription());
		pstm.setTimestamp(3, timestamp);
		
		int affectedRows = pstm.executeUpdate();
		if(affectedRows == 0) return false;
		
		ResultSet rs = pstm.getGeneratedKeys();
		if(rs.next()) {
			post.setId(rs.getInt(1));
			post.setCreated_at(timestamp);
		}		
		return true;
	}
	
	public static int postCount(int uid) throws SQLException
	{
		Connection conn = DatabaseConnection.getConnection();
		
		String query = "SELECT count(*) FROM tbl_posts WHERE uid=?";
		
		PreparedStatement pstm = conn.prepareStatement(query);
				
		pstm.setInt(1, uid);
		
		ResultSet rs = pstm.executeQuery();
		
		if(rs.next()) {
			return rs.getInt(1);
		} else {
			return 0;
		}
	}
	
	public static Post loadResultSet(ResultSet rs) throws SQLException {
		Post post = new Post(
				rs.getInt("id"),
				rs.getInt("uid"),
				rs.getString("description"),
				rs.getTimestamp("created_at"),
				rs.getTimestamp("updated_at"));
		return post;
	}
	
	public static Like loadLikeResultSet(ResultSet rs) throws SQLException {
		Like like = new Like(
				rs.getInt("id"),
				rs.getInt("uid"),
				rs.getInt("pid"),
				rs.getTimestamp("created_at"));
		return like;
	}
	
	public static Comment loadCommentResultSet(ResultSet rs) throws SQLException {
		Comment comment = new Comment(
				rs.getInt("id"),
				rs.getInt("uid"),
				rs.getInt("pid"),
				rs.getString("comment"),
				rs.getTimestamp("created_at"));
		return comment;
	}
	
	public static ArrayList<Post> getFeeds(int uid) throws SQLException
	{
		ArrayList<Post> result = new ArrayList<Post>();
		
		Connection conn = DatabaseConnection.getConnection();
		
		String query = "SELECT * FROM tbl_posts WHERE (uid=?) OR (uid IN (SELECT uid_1 FROM tbl_relations WHERE uid_2=?)) OR (uid IN (SELECT uid_2 FROM tbl_relations WHERE uid_1=?)) ORDER BY id DESC";
		
		PreparedStatement pstm = conn.prepareStatement(query);
				
		pstm.setInt(1, uid);
		pstm.setInt(2, uid);
		pstm.setInt(3, uid);
		
		ResultSet rs = pstm.executeQuery();
		
		while(rs.next()) {
			result.add(loadResultSet(rs));
		}
		
		return result;
	}
	
	public static ArrayList<Post> getPostsWhereUid(int uid) throws SQLException
	{
		ArrayList<Post> result = new ArrayList<Post>();
		
		Connection conn = DatabaseConnection.getConnection();
		
		String query = "SELECT * FROM tbl_posts WHERE uid=? ORDER BY id DESC";
		
		PreparedStatement pstm = conn.prepareStatement(query);
				
		pstm.setInt(1, uid);
		
		ResultSet rs = pstm.executeQuery();
		
		while(rs.next()) {
			result.add(loadResultSet(rs));
		}
		
		return result;
	}
	
	public static HashMap<Integer,Like> getLikes(int pid) throws SQLException
	{
		HashMap<Integer,Like> result = new HashMap<Integer,Like>();
		Connection conn = DatabaseConnection.getConnection();
		
		String query = "SELECT * FROM tbl_likes WHERE pid=?";
		
		PreparedStatement pstm = conn.prepareStatement(query);
				
		pstm.setInt(1, pid);
		
		ResultSet rs = pstm.executeQuery();
		
		while(rs.next()) {
			result.put(rs.getInt("uid"),loadLikeResultSet(rs));
		}
		return result;
	}
	
	public static ArrayList<Comment> getComments(int pid) throws SQLException
	{
		ArrayList<Comment> result = new ArrayList<Comment>();
		
		Connection conn = DatabaseConnection.getConnection();
		
		String query = "SELECT * FROM tbl_comments WHERE pid=?";
		
		PreparedStatement pstm = conn.prepareStatement(query);
				
		pstm.setInt(1, pid);
		
		ResultSet rs = pstm.executeQuery();
		
		while(rs.next()) {
			result.add(loadCommentResultSet(rs));
		}
		
		return result;
	}
	
	public static boolean addComment(Comment comment) throws SQLException
	{
		Connection conn = DatabaseConnection.getConnection();
		
		String query = "INSERT INTO tbl_comments (uid,pid,comment,created_at) VALUES (?,?,?,?)";
		
		PreparedStatement pstm = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
		
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		
		pstm.setInt(1, comment.getUid());
		pstm.setInt(2, comment.getPid());
		pstm.setString(3, comment.getComment());
		pstm.setTimestamp(4, timestamp);
		
		int affectedRows = pstm.executeUpdate();
		if(affectedRows == 0) return false;
		
		ResultSet rs = pstm.getGeneratedKeys();
		if(rs.next()) {
			comment.setId(rs.getInt(1));
			comment.setCreated_at(timestamp);
		}		
		return true;
	}
	
	public static boolean addLike(Like like) throws SQLException
	{
		Connection conn = DatabaseConnection.getConnection();
		
		String query = "INSERT INTO tbl_likes (uid,pid,created_at) VALUES (?,?,?)";
		
		PreparedStatement pstm = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
		
		Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		
		pstm.setInt(1, like.getUid());
		pstm.setInt(2, like.getPid());
		pstm.setTimestamp(3, timestamp);
		
		int affectedRows = pstm.executeUpdate();
		if(affectedRows == 0) return false;
		
		ResultSet rs = pstm.getGeneratedKeys();
		if(rs.next()) {
			like.setId(rs.getInt(1));
			like.setCreated_at(timestamp);
		}		
		return true;
	}
	
	public static boolean unLike(Like like) throws SQLException
	{
		Connection conn = DatabaseConnection.getConnection();
		
		String query = "DELETE FROM tbl_likes WHERE uid=? AND pid=?";
		
		PreparedStatement pstm = conn.prepareStatement(query, Statement.RETURN_GENERATED_KEYS);
				
		pstm.setInt(1, like.getUid());
		pstm.setInt(2, like.getPid());
		
		int affectedRows = pstm.executeUpdate();
		if(affectedRows == 0) return false;
				
		return true;
	}
}
