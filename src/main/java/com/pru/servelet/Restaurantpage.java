package com.pru.servelet;

import jakarta.servlet.RequestDispatcher;


import java.io.IOException;
import java.util.List;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.pru.DAO.RestaurantDAO;
import com.pru.DAO.implementation.RestaurantDAOImpl;
import com.pru.model.Restaurant;
@WebServlet("/restaurants")    

public class Restaurantpage extends HttpServlet {

    private RestaurantDAO rd = new RestaurantDAOImpl();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        List<Restaurant> mk = rd.getAllRestaurants();

        for (Restaurant kl : mk) {
            System.out.println(kl.getRestaurantId());
            System.out.println(kl.getName());
            System.out.println(kl.getAddress());
            System.out.println(kl.getRating());
            System.out.println(kl.isActive());
            System.out.println(kl.getImage());
            System.out.println(kl.getDeliveryTime());
            
            
            
            
            
        }
        request.setAttribute("restaurants", mk);
        RequestDispatcher lo = request.getRequestDispatcher("restaurant.jsp");
        lo.forward(request,response);
    }
}