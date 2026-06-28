package com.pru.DAO.implementation;

import com.pru.model.MenuItem;
import com.pru.DAO.MenuItemDAO;
import com.pru.utility.DBConnection;

import java.sql.*;
import java.util.*;

public class MenuItemDAOImpl implements MenuItemDAO {

    // ── ADD ───────────────────────────────────────────────────
    @Override
    public void addItem(MenuItem item) {
        String sql = "INSERT INTO menu_item (restaurant_id, name, price, description, image) " +
                     "VALUES (?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, item.getRestaurantId());
            pstmt.setString(2, item.getName());
            pstmt.setDouble(3, item.getPrice());
            pstmt.setString(4, item.getDescription());
            pstmt.setString(5, item.getImage());

            int rows = pstmt.executeUpdate();
            System.out.println(rows > 0 ? "Item added." : "Failed to add item.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ── UPDATE ────────────────────────────────────────────────
    @Override
    public void updateItem(MenuItem item) {
        String sql = "UPDATE menu_item SET restaurant_id=?, name=?, price=?, " +
                     "description=?, image=? WHERE item_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, item.getRestaurantId());
            pstmt.setString(2, item.getName());
            pstmt.setDouble(3, item.getPrice());
            pstmt.setString(4, item.getDescription());
            pstmt.setString(5, item.getImage());
            pstmt.setInt(6, item.getItemId());

            int rows = pstmt.executeUpdate();
            System.out.println(rows > 0 ? "Item updated." : "Item not found.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ── DELETE ────────────────────────────────────────────────
    @Override
    public void deleteItem(int itemId) {
        String sql = "DELETE FROM menu_item WHERE item_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, itemId);

            int rows = pstmt.executeUpdate();
            System.out.println(rows > 0 ? "Item deleted." : "Item not found.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ── GET ONE ───────────────────────────────────────────────
    @Override
    public MenuItem getItem(int itemId) {
        String sql = "SELECT * FROM menu_item WHERE item_id = ?";
        MenuItem item = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, itemId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                item = mapRow(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return item;
    }

    // ── GET ALL ───────────────────────────────────────────────
    @Override
    public List<MenuItem> getAllItems() {
        String sql = "SELECT * FROM menu_item";
        List<MenuItem> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                list.add(mapRow(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ── GET BY RESTAURANT ─────────────────────────────────────
    @Override
    public List<MenuItem> getItemsByRestaurant(int restaurantId) {
        String sql = "SELECT * FROM menu_item WHERE restaurant_id = ?";
        List<MenuItem> list = new ArrayList<>();

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, restaurantId);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                list.add(mapRow(rs));
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // ── HELPER: ResultSet → MenuItem ──────────────────────────
    private MenuItem mapRow(ResultSet rs) throws SQLException {
        MenuItem item = new MenuItem();
        item.setItemId(rs.getInt("item_id"));
        item.setRestaurantId(rs.getInt("restaurant_id"));
        item.setName(rs.getString("name"));
        item.setPrice(rs.getDouble("price"));
        item.setDescription(rs.getString("description"));
        item.setImage(rs.getString("image"));
        return item;
    }
}