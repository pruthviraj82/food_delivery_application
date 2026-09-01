package com.pru.utility;
import java.sql.*;


public class DBConnection {

    private static final String URL = "jdbc:mysql://mysql-10638491-prithvirajnarrow-99b5.f.aivencloud.com:20963/defaultdb?ssl-mode=REQUIRED";
    private static final String USERNAME = "avnadmin";
    private static final String PASSWORD = "AVNS_apNhklXBR3Zd6z2n1z2";
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
