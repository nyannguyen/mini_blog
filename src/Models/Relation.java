package Models;

import java.sql.Timestamp;

/**
 * Relation class represents the information 
 * of a relationship between two users saved in database.
 * 
 * @author Nyan
 * @version 1.0
 * @since 2020
 */
public class Relation {
	private int id;
	//First user id
	private int uid_1;
	//Second user id
	private int uid_2;
	//True if there is a relationship between them and false if not
	private boolean status;
	private Timestamp created_at;
	
	/**
	 * Constructor using when create relationship
	 * @param uid_1
	 * @param uid_2
	 * @param status
	 */
	public Relation(int uid_1, int uid_2, boolean status) {
		super();
		this.uid_1 = uid_1;
		this.uid_2 = uid_2;
		this.status = status;
	}

	/**
	 * Constructor using when load/update model from/to database
	 * @param id
	 * @param uid_1
	 * @param uid_2
	 * @param status
	 */
	public Relation(int id, int uid_1, int uid_2, boolean status) {
		super();
		this.id = id;
		this.uid_1 = uid_1;
		this.uid_2 = uid_2;
		this.status = status;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUid_1() {
		return uid_1;
	}

	public void setUid_1(int uid_1) {
		this.uid_1 = uid_1;
	}

	public int getUid_2() {
		return uid_2;
	}

	public void setUid_2(int uid_2) {
		this.uid_2 = uid_2;
	}

	public boolean isStatus() {
		return status;
	}

	public void setStatus(boolean status) {
		this.status = status;
	}

	public Timestamp getCreated_at() {
		return created_at;
	}

	public void setCreated_at(Timestamp created_at) {
		this.created_at = created_at;
	}
}
