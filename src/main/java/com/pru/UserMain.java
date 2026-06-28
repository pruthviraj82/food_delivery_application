package com.pru;
import com.pru.DAO.implementation.UserDAOImpl;

import com.pru.model.User;
import com.pru.DAO.UserDAO;
import java.util.*;


public class UserMain {

	
	
	public static void main(String[] args) {
		UserDAO udao = new UserDAOImpl();
        Scanner scan = new Scanner(System.in);

        // ── ADD USER ──────────────────────────────────
//        System.out.print("Username: "); 
//        String uname = scan.next();
//        System.out.print("Password: ");  String pass  = scan.next();
//        System.out.print("Email: ");     String email = scan.next();
//        System.out.print("Address: ");   String addr  = scan.nextLine();
//        System.out.print("Role (customer/admin): "); String role = scan.next();
//
//        User newUser = new User(uname, pass, email, addr, role);
//        udao.addUser(newUser);
//        
//        
        // ── GET ALL USERS ─────────────────────────────
        System.out.println("\n── All Users ──");
        List<User> all = udao.getAllUsers();
        for (User u : all) {
            System.out.println(u);
        }
//
//        // ── GET ONE USER ──────────────────────────────
//        System.out.print("\nEnter user ID to fetch: ");
//        int id = scan.nextInt();
//        User found = udao.getUser(id);
//        System.out.println("Fetched: " + found);
//
//        // ── UPDATE USER ───────────────────────────────
//        // First get the user, then change a field, then update
//        System.out.print("\nEnter user ID to update: ");
//        int updateId = scan.nextInt();
//        User toUpdate = udao.getUser(updateId);
//        System.out.println("Current: " + toUpdate);
//
//        System.out.print("New address: ");
//        String newAddr = scan.next();
//        toUpdate.setAddress(newAddr);       // Change only address
//        udao.updateUser(toUpdate);          // Update sends full object
//
//        System.out.println("After update: " + udao.getUser(updateId));

        // ── DELETE USER ───────────────────────────────
        System.out.print("\nEnter user ID to delete: ");
        int deleteId = scan.nextInt();
        udao.deleteUser(deleteId);

        scan.close();
	}
	
	
	
	
}
