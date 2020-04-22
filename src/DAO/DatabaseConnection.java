package DAO;

import java.sql.*;

public class DatabaseConnection {
	private static String DB_URL = "jdbc:mysql://localhost:3306/miniblog?useSSL=false";
	private static String USER_NAME = "root";
	private static String PASSWORD = "root";
	
	public static void main(String[] args) {
		testConnection();
	}
	
	public static Connection testConnection() {
        Connection conn = null;
        try {
        	Class.forName("com.mysql.jdbc.Driver"); 

            conn = DriverManager.getConnection(DB_URL, USER_NAME, PASSWORD);
            System.out.println("Connect to Database successfully!");
        } catch (Exception ex) {
            System.out.println("Database connection failure!");
            ex.printStackTrace();
        }
        return conn;
	}
	
	public static Connection getConnection() {
        Connection conn = null;
        try {
        	Class.forName("com.mysql.jdbc.Driver"); 

            conn = DriverManager.getConnection(DB_URL, USER_NAME, PASSWORD);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return conn;
	}
	
	public static Connection getConnection(String dbURL, String userName, 
            String password) {
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(dbURL, userName, password);
            System.out.println("Connect to Database successfully!");
        } catch (Exception ex) {
            System.out.println("Database connection failure!");
            ex.printStackTrace();
        }
        return conn;
	}
}
