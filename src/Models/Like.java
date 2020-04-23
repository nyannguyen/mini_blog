package Models;

import java.sql.SQLException;
import java.sql.Timestamp;

import DAO.PostDAO;

/**
 * Relation class represents the relationship 
 * of a like between a user and a post.
 * 
 * @author Nyan
 * @version 1.0
 * @since 2020
 */
public class Like {
	private int id;
	//Like's Owner Id
	private int uid;
	//Post Id
	private int pid;
	private Timestamp created_at;
	
	public Like(int id, int uid, int pid, Timestamp created_at) {
		super();
		this.id = id;
		this.uid = uid;
		this.pid = pid;
		this.created_at = created_at;
	}

	/**
	 * Constructor using when create a new like
	 * @param uid
	 * @param pid
	 * @param created_at
	 */
	public Like(int uid, int pid) {
		super();
		this.uid = uid;
		this.pid = pid;
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

	public Timestamp getCreated_at() {
		return created_at;
	}

	public void setCreated_at(Timestamp created_at) {
		this.created_at = created_at;
	}
	
	public boolean create() throws SQLException{
		return PostDAO.addLike(this);
	}
	
	public boolean remove() throws SQLException{
		return PostDAO.unLike(this);
	}
}
