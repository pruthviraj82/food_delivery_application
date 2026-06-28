package com.pru.DAO.implementation;

import com.pru.model.Order;
import com.pru.model.OrderItem;
import com.pru.DAO.OrderDAO;
import com.pru.utility.DBConnection;

import java.sql.*;
import java.util.*;

public class OrderDAOImpl implements OrderDAO {

    @Override
    public int addOrder(Order order) {
        String sql = "INSERT INTO `order` (user_id, restaurant_id, total_amount, status, payment_method) " +
                     "VALUES (?, ?, ?, ?, ?)";
        int generatedId = -1;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            pstmt.setInt(1, order.getUserId());
            pstmt.setInt(2, order.getRestaurantId());
            pstmt.setDouble(3, order.getTotalAmount());     // ← model: getTotalAmount()
            pstmt.setString(4, order.getStatus());
            pstmt.setString(5, order.getPaymentMethod());   // ← model: getPaymentMethod()

            int rows = pstmt.executeUpdate();
            if (rows > 0) {
                ResultSet keys = pstmt.getGeneratedKeys();
                if (keys.next()) {
                    generatedId = keys.getInt(1);
                    System.out.println("Order placed. Order ID: " + generatedId);
                }
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return generatedId;
    }

    @Override
    public void addOrderItem(OrderItem item) {
        String sql = "INSERT INTO order_item (order_id, item_id, quantity, item_total) " +
                     "VALUES (?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, item.getOrderId());
            pstmt.setInt(2, item.getMenuId());       // ← model: getMenuId()
            pstmt.setInt(3, item.getQuantity());
            pstmt.setDouble(4, item.getItemTotal()); // ← model: getItemTotal()

            int rows = pstmt.executeUpdate();
            System.out.println(rows > 0 ? "Order item added." : "Failed.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public List<Order> getOrdersByUserId(int userId) {
        String sql = "SELECT * FROM `order` WHERE user_id = ?";
        List<Order> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, userId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                list.add(mapRow(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private Order mapRow(ResultSet rs) throws SQLException {
        Order order = new Order(
            rs.getInt("order_id"),
            rs.getInt("user_id"),
            rs.getInt("restaurant_id"),
            rs.getTimestamp("order_date"),    // ← DB column: order_date
            rs.getDouble("total_amount"),     // ← DB column: total_amount
            rs.getString("status"),
            rs.getString("payment_method")    // ← DB column: payment_method
        );
        return order;
    }
}