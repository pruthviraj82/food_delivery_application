package com.pru.servelet;

import com.razorpay.Utils;
import com.pru.DAO.implementation.OrderDAOImpl;
import com.pru.DAO.implementation.OrderItemDAOImpl;
import com.pru.model.Cart;
import com.pru.model.CartItem;
import com.pru.model.OrderItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.json.JSONObject;
import java.io.IOException;

@WebServlet("/verifyPayment")
public class RazorpayVerifyServlet extends HttpServlet {

    private static final String KEY_SECRET = "MAYfUk1efWlcTCAZ6t52Qdki";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String razorpayPaymentId = request.getParameter("razorpay_payment_id");
        String razorpayOrderId   = request.getParameter("razorpay_order_id");
        String razorpaySignature = request.getParameter("razorpay_signature");

        try {
            // ── Verify Signature ──
            JSONObject attributes = new JSONObject();
            attributes.put("razorpay_order_id",   razorpayOrderId);
            attributes.put("razorpay_payment_id",  razorpayPaymentId);
            attributes.put("razorpay_signature",   razorpaySignature);

            boolean isValid = Utils.verifyPaymentSignature(attributes, KEY_SECRET);

            if (isValid) {

                HttpSession session  = request.getSession();
                Cart cart            = (Cart)    session.getAttribute("cart");
                Integer userId       = (Integer) session.getAttribute("userId");
                Integer restaurantId = (Integer) session.getAttribute("restaurantId");
                String phone         = request.getParameter("phone");
                String address       = request.getParameter("address");

                // ── Calculate total ──
                double subtotal = 0;
                for (CartItem item : cart.getItems()) {
                    subtotal += item.getPrice() * item.getQuantity();
                }
                double totalAmount = subtotal + 40 + 50;

                // ── Create Order ✅ matching your constructor ──
                com.pru.model.Order order = new com.pru.model.Order(
                        0,              // orderId — DB auto generates
                        userId,
                        restaurantId,
                        null,           // orderDate — DB sets CURRENT_TIMESTAMP
                        totalAmount,
                        "confirmed",
                        "Razorpay"
                );

                OrderDAOImpl orderDAO = new OrderDAOImpl();
                int orderId = orderDAO.addOrder(order);

                if (orderId > 0) {

                    // ── Save Order Items ✅ matching your constructor ──
                    OrderItemDAOImpl orderItemDAO = new OrderItemDAOImpl();
                    for (CartItem cartItem : cart.getItems()) {
                        double itemTotal = cartItem.getPrice() * cartItem.getQuantity();
                        OrderItem orderItem = new OrderItem(
                                0,                      // orderItemId — DB auto generates
                                orderId,
                                cartItem.getMenuId(),
                                cartItem.getQuantity(),
                                itemTotal
                        );
                        orderItemDAO.addOrderItem(orderItem);
                    }

                    // ── Store in session ──
                    session.setAttribute("lastOrderId",       orderId);
                    session.setAttribute("lastPaymentMethod", "Razorpay — " + razorpayPaymentId);
                    session.setAttribute("lastTotalAmount",   totalAmount);

                    // ── Clear cart ──
                    session.removeAttribute("cart");
                    session.removeAttribute("restaurantId");

                    response.sendRedirect("order-confirmation.jsp");

                } else {
                    response.sendRedirect("checkout.jsp?error=Order+creation+failed");
                }

            } else {
                response.sendRedirect("checkout.jsp?error=Payment+verification+failed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("checkout.jsp?error=Payment+failed");
        }
    }
}