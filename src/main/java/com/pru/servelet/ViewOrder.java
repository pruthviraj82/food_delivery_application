package com.pru.servelet;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import com.pru.DAO.implementation.OrderDAOImpl;
import com.pru.DAO.implementation.OrderItemDAOImpl;
import com.pru.model.Order;
import com.pru.model.OrderItem;
import com.pru.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/view")

public class ViewOrder extends HttpServlet{
	protected void doGet(HttpServletRequest req,HttpServletResponse res) throws ServletException, IOException {
		 HttpSession session = req.getSession();

	   
	        User user = (User) session.getAttribute("user");


	        if (user == null) {
	            res.sendRedirect("login.jsp");
	            return;
	        }
		
		OrderDAOImpl order = new OrderDAOImpl();
		
		List<Order> orders = order.getOrdersByUserId(user.getUserId());
		
		
		
		
		OrderItemDAOImpl orderItem = new OrderItemDAOImpl();
		HashMap<Integer, List<OrderItem>> ordermap = new HashMap<Integer, List<OrderItem>>();
		for (Order orderm : orders) {
            List<OrderItem> items = orderItem.getItemsByOrder(orderm.getOrderId());
            ordermap.put(orderm.getOrderId(), items);
        }
		req.setAttribute("orders", orders);
        req.setAttribute("orderItemsMap", ordermap);
        req.getRequestDispatcher("orderHistory.jsp").forward(req, res);
	}

}
