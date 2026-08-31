package com.pru.servelet;

import com.razorpay.RazorpayClient;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.json.JSONObject;
import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/createRazorpayOrder")
public class RazorpayOrderServlet extends HttpServlet {

    private static final String KEY_ID     = "rzp_test_TD6Engm1YHy8pB";
    private static final String KEY_SECRET = "MAYfUk1efWlcTCAZ6t52Qdki";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        try {
            String amountStr = request.getParameter("amount");
            double amount = Double.parseDouble(amountStr);
            int amountInPaise = (int)(amount * 100);

            RazorpayClient razorpay = new RazorpayClient(KEY_ID, KEY_SECRET);

            JSONObject options = new JSONObject();
            options.put("amount", amountInPaise);
            options.put("currency", "INR");
            options.put("receipt", "tomor_order_" + System.currentTimeMillis());
            options.put("payment_capture", 1);

            com.razorpay.Order order = razorpay.orders.create(options);

            JSONObject responseJson = new JSONObject();
            responseJson.put("orderId", order.get("id").toString());
            responseJson.put("amount", amountInPaise);
            responseJson.put("currency", "INR");

            out.print(responseJson.toString());

        } catch (Exception e) {
            e.printStackTrace();
            JSONObject error = new JSONObject();
            error.put("error", e.getMessage());
            out.print(error.toString());
        }
    }
}