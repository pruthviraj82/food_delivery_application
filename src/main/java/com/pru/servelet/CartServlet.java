package com.pru.servelet;
import com.pru.model.*;
import com.pru.DAO.implementation.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import jakarta.servlet.RequestDispatcher;
import java.util.List;


@WebServlet("/cart")

public class CartServlet extends HttpServlet {
	@Override
    protected void service(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        
        HttpSession session = request.getSession();
        

        
        Cart cart = (Cart) session.getAttribute("cart");

        
        int newRestaurantId = Integer.parseInt(request.getParameter("restaurantId"));

        
        Integer oldRestaurantId = (Integer) session.getAttribute("restaurantId");

        if (cart == null || (oldRestaurantId != null && oldRestaurantId != newRestaurantId)) {
            cart = new Cart();
        }
        
        
        
        
        
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            addItemToCart(request, cart,session);
        } else if ("update".equals(action)) {
            updateCart(request, cart);
        } else if ("delete".equals(action)) {
            removeItemFromCart(request, cart);
        }
        response.sendRedirect("Cart.jsp");
        
        
        
        
        
        

        
	}
	
	
	
	
	
	


	private void removeItemFromCart(HttpServletRequest request, Cart cart) {
		int menuId = Integer.parseInt(request.getParameter("menuId"));
	    cart.removeItem(menuId);
		// TODO Auto-generated method stub
		
	}

	private void updateCart(HttpServletRequest request, Cart cart) {
		int menuId = Integer.parseInt(request.getParameter("menuId"));
	    int newQuantity = Integer.parseInt(request.getParameter("quantity"));
	    cart.updateItem(menuId, newQuantity);
		
		
		// TODO Auto-generated method stub
		
	}

	private void addItemToCart(HttpServletRequest request, Cart cart,HttpSession session) {
		int menuId       = Integer.parseInt(request.getParameter("itemId"));
        int quantity     = Integer.parseInt(request.getParameter("quantity"));
        int restaurantId = Integer.parseInt(request.getParameter("restaurantId"));
        MenuItemDAOImpl menuI = new MenuItemDAOImpl();
        MenuItem menu = menuI.getItem(menuId);
        if (menu != null) {
        	CartItem cartItem = new CartItem(
                menuId,
                restaurantId,
                menu.getName(),
                menu.getPrice(),
                quantity
            );
        	
        	
        	
        	
        	 cart.addItem(cartItem);

             // IMPORTANT: update restaurantId in session after every add
             session.setAttribute("restaurantId", restaurantId);
             session.setAttribute("cart", cart);
        }
	
		
	}

}
