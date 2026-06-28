package com.pru.DAO.implementation;

import com.pru.model.User;
import com.pru.DAO.UserDAO;
import com.pru.utility.DBConnection;

import java.sql.*;
import java.util.*;

import org.mindrot.jbcrypt.BCrypt;

public class UserDAOImpl implements UserDAO {

    

    // ─── ADD ────────────────────────────────────────────────
    @Override
    public void addUser(User user) {
        String sql = "INSERT INTO user (username, email, password, address, role) " +
                     "VALUES (?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {
        	 String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());

            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, hashedPassword);
            pstmt.setString(4, user.getAddress());
            pstmt.setString(5, user.getRole());

            int rows = pstmt.executeUpdate();
            System.out.println(rows > 0 ? "User added." : "Failed to add user.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    @Override
    public User getUserByEmail(String email) {
        String sql = "SELECT * FROM user WHERE email=?";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {
            
            pst.setString(1, email);
            ResultSet rs = pst.executeQuery();
            
            if (rs.next()) {
                return mapRow(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }


    // ─── UPDATE ─────────────────────────────────────────────
    @Override
    public void updateUser(User user) {
        String sql = "UPDATE user SET username=?, email=?, password=?, " +
                     "address=?, role=?, last_login=? WHERE user_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setString(1, user.getUsername());
            pstmt.setString(2, user.getEmail());
            pstmt.setString(3, user.getPassword());
            pstmt.setString(4, user.getAddress());
            pstmt.setString(5, user.getRole());
            pstmt.setTimestamp(6, user.getLastLogin());  // set from Java
            pstmt.setInt(7, user.getUserId());

            int rows = pstmt.executeUpdate();
            System.out.println(rows > 0 ? "User updated." : "User not found.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ─── DELETE ─────────────────────────────────────────────
    @Override
    public void deleteUser(int userId) {
        String sql = "DELETE FROM user WHERE user_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, userId);

            int rows = pstmt.executeUpdate();
            System.out.println(rows > 0 ? "User deleted." : "User not found.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ─── GET ONE ────────────────────────────────────────────
    @Override
    public User getUser(int userId) {
        String sql = "SELECT * FROM user WHERE user_id = ?";
        User user  = null;

        try (Connection con =DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                user = mapRow(rs);   // reusable helper below
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return user;
    }

    // ─── GET ALL ────────────────────────────────────────────
    @Override
    public List<User> getAllUsers() {
        String sql      = "SELECT * FROM user";
        List<User> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ─── HELPER: ResultSet → User object ────────────────────
    private User mapRow(ResultSet rs) throws SQLException {
        User user = new User();
        user.setUserId(rs.getInt("user_id"));
        user.setUsername(rs.getString("username"));
        user.setEmail(rs.getString("email"));
        user.setPassword(rs.getString("password"));
        user.setAddress(rs.getString("address"));
        user.setRole(rs.getString("role"));
        user.setCreatedDate(rs.getTimestamp("created_date"));
        user.setLastLogin(rs.getTimestamp("last_login"));
        return user;
    }
}