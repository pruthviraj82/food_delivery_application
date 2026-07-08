package com.pru.servelet;

import java.io.IOException;
import java.util.List;
import com.pru.DAO.implementation.RestaurantDAOImpl;
import com.pru.model.Restaurant;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/adminDashboard")
public class AdminDashboard extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        
        HttpSession session = req.getSession();
        String userRole = (String) session.getAttribute("userRole");

        if (userRole == null || !"admin".equals(userRole)) {
            res.sendRedirect("login.html");
            return;
        }

        RestaurantDAOImpl rd = new RestaurantDAOImpl();
        List<Restaurant> list = rd.getAllRestaurants();
        req.setAttribute("restaurants", list);

        req.getRequestDispatcher("adminDashboard.jsp").forward(req, res);
    }
}