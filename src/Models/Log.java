package Models;

import java.sql.SQLException;
import java.sql.Timestamp;

import DAO.LogDAO;

public class Log {
	private int id;
	private int uid;
	private String description;
	private Timestamp created_at;
	
	/**
	 * Constructor
	 * @param id
	 * @param uid
	 * @param description
	 * @param created_at
	 */
	public Log(int id, int uid, String description, Timestamp created_at) {
		super();
		this.id = id;
		this.uid = uid;
		this.description = description;
		this.created_at = created_at;
	}

	/**
	 * Constructor using when create a new log
	 * @param uid
	 * @param description
	 */
	public Log(int uid, String description) {
		super();
		this.uid = uid;
		this.description = description;
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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Timestamp getCreated_at() {
		return created_at;
	}

	public void setCreated_at(Timestamp created_at) {
		this.created_at = created_at;
	}
	
	public boolean create() throws SQLException {
		return LogDAO.create(this);
	}
}
