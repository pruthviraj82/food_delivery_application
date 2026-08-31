package com.pru.DAO;

import com.pru.model.Restaurant;
import java.util.List;

public interface RestaurantDAO {

    void addRestaurant(Restaurant restaurant);

    void updateRestaurant(Restaurant restaurant);

    void deleteRestaurant(int restaurantId);

    Restaurant getRestaurant(int restaurantId);

    List<Restaurant> getAllRestaurants();

    // Extra useful methods for your app
    List<Restaurant> getActiveRestaurants();        
    void toggleStatus(int restaurantId, boolean status);
}