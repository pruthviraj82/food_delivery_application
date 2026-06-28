package com.pru.utility;
import java.sql.*;


public class DBConnection {
	 private static final String URL      = "jdbc:mysql://localhost:3306/paynest";
	    private static final String USERNAME = "root";
	    private static final String PASSWORD = "root#19";

	    private static Connection con = null;

	    // Static method — call without creating object
	    public static Connection getConnection() {
	        try {
	            Class.forName("com.mysql.cj.jdbc.Driver");
	            con = DriverManager.getConnection(URL, USERNAME, PASSWORD);
	        } catch (ClassNotFoundException | SQLException e) {
	            e.printStackTrace();
	        }
	        return con;
	    }

}
