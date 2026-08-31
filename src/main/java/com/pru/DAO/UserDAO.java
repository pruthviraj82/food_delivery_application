package com.pru.DAO;
import com.pru.model.User;
import java.util.*;

public interface UserDAO {
	
    void addUser(User user);

    
    void updateUser(User user);

    void deleteUser(int userId);

    User getUser(int userId);


    List<User> getAllUsers();
    User getUserByEmail(String email);

}
