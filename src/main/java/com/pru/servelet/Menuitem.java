package com.pru.servelet;

import java.io.IOException;
import jakarta.servlet.RequestDispatcher;
import java.util.List;

import com.pru.model.*;
import com.pru.DAO.implementation.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
@WebServlet("/MenuItem") 

public class Menuitem extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException{
	String ridParam = request.getParameter("restaurantId");
    int restaurantId = Integer.parseInt(ridParam);
	MenuItemDAOImpl	ura=new MenuItemDAOImpl();
	List<MenuItem> kol = ura.getItemsByRestaurant(restaurantId);
	
	
	request.setAttribute("menuitem",kol);
	RequestDispatcher rdp =  request.getRequestDispatcher("menuitem2.jsp");
	rdp.forward(request,response);
}

}
