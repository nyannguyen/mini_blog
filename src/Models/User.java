package Models;

import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;

import DAO.PostDAO;
import DAO.RelationDAO;
import DAO.UserDAO;

/**
 * Relation class represents the information 
 * of a user.
 * 
 * @author Nyan
 * @version 1.0
 * @since 2020
 */
public class User {
	private int id;
	private String username;
	private String email;
	private String password;
	private String firstname;
	private String lastname;
	private Timestamp created_at;
	private Timestamp updated_at;
	private Timestamp disabled_at;
	
	/**
	 * Constructor
	 * @param id
	 * @param username
	 * @param email
	 * @param password
	 * @param firstname
	 * @param lastname
	 * @param created_at
	 * @param updated_at
	 * @param disabled_at
	 */
	public User(int id, String username, String email, String password, String firstname, String lastname,
			Timestamp created_at, Timestamp updated_at, Timestamp disabled_at) {
		super();
		this.id = id;
		this.username = username;
		this.email = email;
		this.password = password;
		this.firstname = firstname;
		this.lastname = lastname;
		this.created_at = created_at;
		this.updated_at = updated_at;
		this.disabled_at = disabled_at;
	}

	/**
	 * Constructor for login
	 * @param username
	 * @param password
	 */
	public User(String username, String password) {
		super();
		this.username = username;
		this.password = password;
	}

	/** 
	 * Constructor using when create account
	 * @param username
	 * @param email
	 * @param password
	 * @param firstname
	 * @param lastname
	 */
	public User(String username, String email, String password, String firstname, String lastname) {
		this.username = username;
		this.email = email;
		this.password = password;
		this.firstname = firstname;
		this.lastname = lastname;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getFirstname() {
		return firstname;
	}

	public void setFirstname(String firstname) {
		this.firstname = firstname;
	}

	public String getLastname() {
		return lastname;
	}

	public void setLastname(String lastname) {
		this.lastname = lastname;
	}

	public Timestamp getCreated_at() {
		return created_at;
	}

	public void setCreated_at(Timestamp created_at) {
		this.created_at = created_at;
	}

	public Timestamp getUpdated_at() {
		return updated_at;
	}

	public void setUpdated_at(Timestamp updated_at) {
		this.updated_at = updated_at;
	}

	public Timestamp getDisabled_at() {
		return disabled_at;
	}

	public void setDisabled_at(Timestamp disabled_at) {
		this.disabled_at = disabled_at;
	}
	
	/**
	 * Encrypt current user's password
	 * with MD5 hashing.
	 */
	public void encryptPassword() {		
		try {
			MessageDigest md;
			md = MessageDigest.getInstance("MD5");
			byte[] hashInBytes = md.digest(this.getPassword().getBytes(StandardCharsets.UTF_8));
			
			StringBuilder sb = new StringBuilder();
			for(byte b : hashInBytes) {
				sb.append(String.format("%02x", b));
			}
			this.setPassword(sb.toString());
			
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
	public boolean create() throws SQLException {
		return UserDAO.create(this);
	}
	
	public boolean login() throws SQLException {
		return UserDAO.login(this);
	}
	
	public static User whereId(int uid) throws SQLException {
		return UserDAO.whereId(uid);
	}
	
	public static User whereUsername(String username) throws SQLException {
		return UserDAO.whereUsername(username);
	}
	
	public static User whereEmail(String email) throws SQLException {
		return UserDAO.whereEmail(email);
	}
	
	public boolean update() throws SQLException  {
		return UserDAO.update(this);
	}
	
	public int friendsCount() throws SQLException {
		return RelationDAO.friendsCount(this.id);
	}
	
	public int requestCount() throws SQLException {
		return RelationDAO.requestCount(this.id);
	}
	
	public ArrayList<User> getAllRequest() throws SQLException {
		return RelationDAO.getAllRequest(this.id);
	}
	
	public ArrayList<User> getAllFriends() throws SQLException {
		return RelationDAO.getAllFriends(this.id);
	}
	
	public int relationState(User user) throws SQLException {
		return RelationDAO.relationState(this.id, user.id);
	}
	
	public boolean acceptFriendRequest(int uid) throws SQLException {
		return RelationDAO.acceptInvite(this.id, uid);
	}
	
	public boolean removeFriend(int uid) throws SQLException {
		return RelationDAO.removeFriend(this.id, uid);
	}
	
	public static ArrayList<User> findUsername(String current_username, String username) throws SQLException {
		return UserDAO.findUsername(current_username,username);
	}
	
	public int postCount() throws SQLException {
		return PostDAO.postCount(this.id);
	}
	
	public ArrayList<Post> getPosts() throws SQLException {
		return PostDAO.getPostsWhereUid(this.id);
	}
	
	public String getFullName() {
		return this.lastname+" "+this.firstname;
	}

	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return this.getId()+" - "+this.getFirstname()+" "+this.getLastname();
	}

	@Override
	public boolean equals(Object obj) {
		// TODO Auto-generated method stub
		return this.username.equals(((User)obj).getUsername());
	}
}
