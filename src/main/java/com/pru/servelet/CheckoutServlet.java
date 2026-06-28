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
import java.sql.Timestamp;

import jakarta.servlet.RequestDispatcher;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import jakarta.servlet.RequestDispatcher;
import java.util.List;


@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {
	
	@Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        User user = (User) session.getAttribute("user");


        Cart cart = (Cart) session.getAttribute("cart");

        if (user == null) {
            response.sendRedirect("login.html");
            return;
        }

        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("Cart.jsp");
            return;
        }


        Integer restaurantId = (Integer) session.getAttribute("restaurantId");
        String paymentMethod = request.getParameter("paymentMethod"); 

        double subtotal = 0;
        for (CartItem item : cart.getItems()) {
            subtotal += item.getPrice() * item.getQuantity();
        }
        double totalAmount = subtotal + 40 + 50; 

        Order order = new Order(
            0,                                         
            user.getUserId(),
            restaurantId,
            new Timestamp(System.currentTimeMillis()),
            totalAmount,
            "Pending",
            paymentMethod
        );

        OrderDAOImpl orderDAO = new OrderDAOImpl();
        int orderId = orderDAO.addOrder(order);

        OrderItemDAOImpl orderItemDAO = new OrderItemDAOImpl();
        for (CartItem item : cart.getItems()) {
            OrderItem orderItem = new OrderItem(
                0,                                      
                orderId,
                item.getMenuId(),                       
                item.getQuantity(),
                item.getPrice() * item.getQuantity()  
            );
            orderItemDAO.addOrderItem(orderItem);
        }

        
        session.removeAttribute("cart");
        session.removeAttribute("restaurantId");
        session.setAttribute("lastOrderId", orderId);
        session.setAttribute("lastPaymentMethod", paymentMethod);
        session.setAttribute("lastTotalAmount", totalAmount);


        response.sendRedirect("order-confirmation.jsp");
	}


}
