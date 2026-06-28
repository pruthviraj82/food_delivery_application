package com.pru.DAO.implementation;

import com.pru.model.Restaurant;
import com.pru.DAO.RestaurantDAO;
import com.pru.utility.DBConnection;

import java.sql.*;
import java.util.*;

public class RestaurantDAOImpl implements RestaurantDAO {

    // ── ADD ───────────────────────────────────────────────────
    @Override
    public void addRestaurant(Restaurant r) {
        String sql = "INSERT INTO restaurant (name, address, rating, is_active, image, delivery_time) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setString(1, r.getName());
            pstmt.setString(2, r.getAddress());
            pstmt.setDouble(3, r.getRating());
            pstmt.setBoolean(4, r.isActive());
            pstmt.setString(5, r.getImage());
            pstmt.setInt(6, r.getDeliveryTime());

            int rows = pstmt.executeUpdate();
            System.out.println(rows > 0 ? "Restaurant added." : "Failed to add.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ── UPDATE ────────────────────────────────────────────────
    @Override
    public void updateRestaurant(Restaurant r) {
        String sql = "UPDATE restaurant SET name=?, address=?, rating=?, " +
                     "is_active=?, image=?, delivery_time=? WHERE restaurant_id=?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setString(1, r.getName());
            pstmt.setString(2, r.getAddress());
            pstmt.setDouble(3, r.getRating());
            pstmt.setBoolean(4, r.isActive());
            pstmt.setString(5, r.getImage());
            pstmt.setInt(6, r.getDeliveryTime());
            pstmt.setInt(7, r.getRestaurantId());

            int rows = pstmt.executeUpdate();
            System.out.println(rows > 0 ? "Restaurant updated." : "Not found.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ── DELETE ────────────────────────────────────────────────
    @Override
    public void deleteRestaurant(int restaurantId) {
        String sql = "DELETE FROM restaurant WHERE restaurant_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, restaurantId);

            int rows = pstmt.executeUpdate();
            System.out.println(rows > 0 ? "Restaurant deleted." : "Not found.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ── GET ONE ───────────────────────────────────────────────
    @Override
    public Restaurant getRestaurant(int restaurantId) {
        String sql = "SELECT * FROM restaurant WHERE restaurant_id = ?";
        Restaurant r = null;

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setInt(1, restaurantId);
            ResultSet rs = pstmt.executeQuery();

            if (rs.next()) {
                r = mapRow(rs);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return r;
    }

    // ── GET ALL ───────────────────────────────────────────────
    @Override
    public List<Restaurant> getAllRestaurants() {
        String sql = "SELECT * FROM restaurant";
        List<Restaurant> list = new ArrayList<>();

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

    // ── ACTIVE ONLY ───────────────────────────────────────────
    @Override
    public List<Restaurant> getActiveRestaurants() {
        String sql = "SELECT * FROM restaurant WHERE is_active = true";
        List<Restaurant> list = new ArrayList<>();

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

    // ── TOGGLE OPEN/CLOSE ─────────────────────────────────────
    @Override
    public void toggleStatus(int restaurantId, boolean status) {
        String sql = "UPDATE restaurant SET is_active = ? WHERE restaurant_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement pstmt = con.prepareStatement(sql)) {

            pstmt.setBoolean(1, status);
            pstmt.setInt(2, restaurantId);

            int rows = pstmt.executeUpdate();
            System.out.println(rows > 0
                ? "Status updated to: " + (status ? "Open" : "Closed")
                : "Restaurant not found.");

        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ── HELPER: ResultSet → Restaurant ────────────────────────
    private Restaurant mapRow(ResultSet rs) throws SQLException {
        Restaurant r = new Restaurant();
        r.setRestaurantId(rs.getInt("restaurant_id"));
        r.setName(rs.getString("name"));
        r.setAddress(rs.getString("address"));
        r.setRating(rs.getDouble("rating"));
        r.setActive(rs.getBoolean("is_active"));
        r.setImage(rs.getString("image"));
        r.setDeliveryTime(rs.getInt("delivery_time"));
        return r;
    }
}