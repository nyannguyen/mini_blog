package Models;

import java.sql.SQLException;
import java.sql.Timestamp;

import DAO.PostDAO;

/**
 * Relation class represents the information 
 * of a comment saved in database with the relationship
 * between a user and a post.
 * 
 * @author Nyan
 * @version 1.0
 * @since 2020
 */
public class Comment {
	private int id;
	//Comment's owner Id
	private int uid;
	//Post Id
	private int pid;
	private String comment;
	private Timestamp created_at;
	
	/**
	 * Constructor
	 * @param id
	 * @param uid
	 * @param pid
	 * @param comment
	 * @param created_at
	 */
	public Comment(int id, int uid, int pid, String comment, Timestamp created_at) {
		super();
		this.id = id;
		this.uid = uid;
		this.pid = pid;
		this.comment = comment;
		this.created_at = created_at;
	}

	/**
	 * Constructor using when create comment 
	 * @param uid
	 * @param pid
	 * @param comment
	 */
	public Comment(int uid, int pid, String comment) {
		super();
		this.uid = uid;
		this.pid = pid;
		this.comment = comment;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUid() {
		return uid;
	}

	public void setUid(int uid) {
		this.uid = uid;
	}

	public int getPid() {
		return pid;
	}

	public void setPid(int pid) {
		this.pid = pid;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Timestamp getCreated_at() {
		return created_at;
	}

	public void setCreated_at(Timestamp created_at) {
		this.created_at = created_at;
	}
	
	public boolean create() throws SQLException {
		return PostDAO.addComment(this);
	}	
}
