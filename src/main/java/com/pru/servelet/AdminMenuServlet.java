package com.pru.servelet;

import java.io.IOException;
import java.util.List;
import com.pru.DAO.implementation.MenuItemDAOImpl;
import com.pru.DAO.implementation.RestaurantDAOImpl;
import com.pru.model.MenuItem;
import com.pru.model.Restaurant;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/adminMenu")
public class AdminMenuServlet extends HttpServlet {

  
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession();
        String userRole = (String) session.getAttribute("userRole");
        if (userRole == null || !"admin".equals(userRole)) {
            res.sendRedirect("login.html");
            return;
        }


        int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));

        MenuItemDAOImpl mid = new MenuItemDAOImpl();
        List<MenuItem> menuItems = mid.getItemsByRestaurant(restaurantId);


        RestaurantDAOImpl rd = new RestaurantDAOImpl();
        Restaurant restaurant = rd.getRestaurant(restaurantId);

       
        req.setAttribute("menuItems", menuItems);
        req.setAttribute("restaurant", restaurant);


        req.getRequestDispatcher("adminMenu.jsp").forward(req, res);
    }

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        MenuItemDAOImpl mid = new MenuItemDAOImpl();
        String action = req.getParameter("action");
        int restaurantId = Integer.parseInt(req.getParameter("restaurantId"));

        if (action == null) {
            res.sendRedirect("adminDashboard");
            return;
        }

        if (action.equals("add")) {
            addMenuItem(req, mid, restaurantId);
        } else if (action.equals("delete")) {
            deleteMenuItem(req, mid);
        } else if (action.equals("update")) {
            updateMenuItem(req, mid);
        }

        // Redirect back to same restaurant's menu
        res.sendRedirect("adminMenu?restaurantId=" + restaurantId);
    }

    private void updateMenuItem(HttpServletRequest req, MenuItemDAOImpl mid) {
    	int itemId         = Integer.parseInt(req.getParameter("itemId"));
        int restaurantId   = Integer.parseInt(req.getParameter("restaurantId"));
        String name        = req.getParameter("name");
        double price       = Double.parseDouble(req.getParameter("price"));
        String description = req.getParameter("description");
        String image       = req.getParameter("image");

        MenuItem item = new MenuItem();
        item.setItemId(itemId);
        item.setRestaurantId(restaurantId);
        item.setName(name);
        item.setPrice(price);
        item.setDescription(description);
        item.setImage(image);

        mid.updateItem(item);

		
	}

	private void addMenuItem(HttpServletRequest req, MenuItemDAOImpl mid, int restaurantId) {
        String name        = req.getParameter("name");
        double price       = Double.parseDouble(req.getParameter("price"));
        String description = req.getParameter("description");
        String image       = req.getParameter("image");

        MenuItem item = new MenuItem();
        item.setRestaurantId(restaurantId);
        item.setName(name);
        item.setPrice(price);
        item.setDescription(description);
        item.setImage(image);

        mid.addItem(item);
    }

    private void deleteMenuItem(HttpServletRequest req, MenuItemDAOImpl mid) {
        int itemId = Integer.parseInt(req.getParameter("itemId"));
        mid.deleteItem(itemId);
    }
}