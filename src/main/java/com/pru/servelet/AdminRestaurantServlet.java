package com.pru.servelet;
import java.io.IOException;
import com.pru.model.*;

import com.pru.DAO.implementation.RestaurantDAOImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/adminRestaurant")
public class AdminRestaurantServlet extends HttpServlet{
	 protected void doGet(HttpServletRequest req, HttpServletResponse res)
	            throws ServletException, IOException {
		 
		 RestaurantDAOImpl rd = new RestaurantDAOImpl();
		 String action = req.getParameter("action"); 
		 if (action == null) {
	            res.sendRedirect("adminDashboard");
	            return;
	        }

	        if (action.equals("add")) {
	            addRestaurant(req, rd);
	        } else if (action.equals("delete")) {
	            deleteRestaurant(req, rd);
	        } else if (action.equals("update")) {
	            updateRestaurant(req, rd);
	        }

	      
	        res.sendRedirect("adminDashboard");
	 }

	 private void updateRestaurant(HttpServletRequest req, RestaurantDAOImpl rd) {
		 int restaurantId   = Integer.parseInt(req.getParameter("restaurantId"));
		    String name        = req.getParameter("name");
		    String address     = req.getParameter("address");
		    double rating      = Double.parseDouble(req.getParameter("rating"));
		    int deliveryTime   = Integer.parseInt(req.getParameter("deliveryTime"));
		    String image       = req.getParameter("image");
		    boolean isActive   = Boolean.parseBoolean(req.getParameter("isActive"));

		    Restaurant r = new Restaurant();
		    r.setRestaurantId(restaurantId);
		    r.setName(name);
		    r.setAddress(address);
		    r.setRating(rating);
		    r.setDeliveryTime(deliveryTime);
		    r.setImage(image);
		    r.setActive(isActive);

		    rd.updateRestaurant(r);
		// TODO Auto-generated method stub
		
	}

	 void deleteRestaurant(HttpServletRequest req, RestaurantDAOImpl rd) {
		 int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));
	        rd.deleteRestaurant(restaurantId);

		
	}

	 void addRestaurant(HttpServletRequest req, RestaurantDAOImpl rd) {
		 String name        = req.getParameter("name");
	        String address     = req.getParameter("address");
	        double rating      = Double.parseDouble(req.getParameter("rating"));
	        int deliveryTime   = Integer.parseInt(req.getParameter("deliveryTime"));
	        String image       = req.getParameter("image");
	        boolean isActive   = Boolean.parseBoolean(req.getParameter("isActive"));

	        Restaurant r = new Restaurant();
	        r.setName(name);
	        r.setAddress(address);
	        r.setRating(rating);
	        r.setDeliveryTime(deliveryTime);
	        r.setImage(image);
	        r.setActive(isActive);

	        rd.addRestaurant(r);

		
	 }

}
