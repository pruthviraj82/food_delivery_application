package com.pru.servelet;
import com.pru.DAO.UserDAO;
import com.pru.DAO.implementation.UserDAOImpl;
import com.pru.model.User;
import org.mindrot.jbcrypt.BCrypt;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/login")

public class Loginserver extends HttpServlet{
	private UserDAO udao = new UserDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        
        String email    = request.getParameter("email");
        String password = request.getParameter("password");
        
        // ── Retrieve user from database ──
        User user = udao.getUserByEmail(email);
        
        
        
        
        // ── Check if user exists and password matches ──
        if (user != null && BCrypt.checkpw(password, user.getPassword())) {
        	HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userId", user.getUserId());
            session.setAttribute("userName", user.getUsername());
           
            session.setAttribute("userRole", user.getRole());

            if ("admin".equals(user.getRole())) {
                response.sendRedirect("adminDashboard");
            } else {
                response.sendRedirect("restaurants");
            }
            
            
        }else {
        	
        RequestDispatcher rmd = request.getRequestDispatcher("login.html");
        rmd.forward(request, response);
        }
        
        }
        

}
