package com.pru.model;
import java.sql.Timestamp;

public class User {
    private int userId;          // was 'id' → match DB column user_id
    private String username;     // was 'name' → match DB column username
    private String password;
    private String email;
    private String address;      // ✅ MISSING
    private String role;         // ✅ MISSING (customer/admin)
    private Timestamp createdDate; // ✅ MISSING
    private Timestamp lastLogin;   // ✅ MISSING

    public User() {}
 // Constructor WITHOUT userId (for INSERT — DB auto-generates it)
    public User(String username, String password, String email, String address, String role) {
        this.username = username;
        this.password = password;
        this.email    = email;
        this.address  = address;
        this.role     = role;
    }

    public User(int userId, String username, String email,
                String password, String address, String role) {
        this.userId   = userId;
        this.username = username;
        this.email    = email;
        this.password = password;
        this.address  = address;
        this.role     = role;
    }

    // Getters & Setters
    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public Timestamp getCreatedDate() { return createdDate; }
    public void setCreatedDate(Timestamp createdDate) { this.createdDate = createdDate; }

    public Timestamp getLastLogin() { return lastLogin; }
    public void setLastLogin(Timestamp lastLogin) { this.lastLogin = lastLogin; }

    @Override
    public String toString() {
        return "User [userId=" + userId + ", username=" + username +
               ", email=" + email + ", role=" + role + "]";
    }
}