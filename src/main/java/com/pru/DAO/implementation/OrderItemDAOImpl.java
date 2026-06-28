package com.pru.DAO.implementation;

import com.pru.model.OrderItem;
import com.pru.DAO.OrderItemDAO;
import com.pru.utility.DBConnection;

import java.sql.*;
import java.util.*;

public class OrderItemDAOImpl implements OrderItemDAO {

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
    public void deleteOrderItem(int orderItemId) {
        String sql = "DELETE FROM order_item WHERE order_item_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, orderItemId);
            int rows = pstmt.executeUpdate();
            System.out.println(rows > 0 ? "Order item deleted." : "Not found.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    @Override
    public OrderItem getOrderItem(int orderItemId) {
        String sql = "SELECT * FROM order_item WHERE order_item_id = ?";
        OrderItem item = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, orderItemId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) item = mapRow(rs);

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return item;
    }

    @Override
    public List<OrderItem> getItemsByOrder(int orderId) {
        String sql = "SELECT * FROM order_item WHERE order_id = ?";
        List<OrderItem> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, orderId);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) list.add(mapRow(rs));

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    private OrderItem mapRow(ResultSet rs) throws SQLException {
        return new OrderItem(
            rs.getInt("order_item_id"),
            rs.getInt("order_id"),
            rs.getInt("item_id"),        // ← DB column: item_id → maps to menuId in model
            rs.getInt("quantity"),
            rs.getDouble("item_total")   // ← DB column: item_total
        );
    }
}