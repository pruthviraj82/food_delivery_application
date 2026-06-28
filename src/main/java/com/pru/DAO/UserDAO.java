package com.pru.DAO;
import com.pru.model.User;
import java.util.*;

public interface UserDAO {
	// Add a new user to database
    void addUser(User user);

    // Update existing user (pass full user object with updated fields)
    void updateUser(User user);

    // Delete user by ID only (ID is enough to identify a row)
    void deleteUser(int userId);

    // Get one specific user by ID
    User getUser(int userId);

    // Get all users from the table
    List<User> getAllUsers();
    User getUserByEmail(String email);

}
