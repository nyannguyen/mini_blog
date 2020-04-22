package Models;

import java.sql.Timestamp;

/**
 * Relation class represents the information 
 * of a post saved in database.
 * 
 * @author Nyan
 * @version 1.0
 * @since 2020
 */
public class Post {
	private int id;
	//Owner Id
	private int uid;
	private String description;
	private Timestamp created_at;
	private Timestamp updated_At;
	
	/**
	 * Constructor
	 * @param id
	 * @param uid
	 * @param description
	 * @param created_at
	 * @param updated_At
	 */
	public Post(int id, int uid, String description, Timestamp created_at, Timestamp updated_At) {
		super();
		this.id = id;
		this.uid = uid;
		this.description = description;
		this.created_at = created_at;
		this.updated_At = updated_At;
	}

	/**
	 * Constructor using when create new post
	 * @param uid
	 * @param description
	 * @param created_at
	 */
	public Post(int uid, String description) {
		super();
		this.uid = uid;
		this.description = description;
	}

	/**
	 * Constructor using when update a post
	 * @param id
	 * @param uid
	 * @param description
	 * @param created_at
	 * @param updated_At
	 */
	public Post(int id, int uid, String description) {
		super();
		this.id = id;
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

	public Timestamp getUpdated_At() {
		return updated_At;
	}

	public void setUpdated_At(Timestamp updated_At) {
		this.updated_At = updated_At;
	}
}
