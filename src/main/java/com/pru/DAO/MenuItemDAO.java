package com.pru.DAO;

import com.pru.model.MenuItem;
import java.util.List;

public interface MenuItemDAO {

    void addItem(MenuItem item);

    void updateItem(MenuItem item);

    void deleteItem(int itemId);

    MenuItem getItem(int itemId);

    List<MenuItem> getAllItems();

    // Extra — get all items for a specific restaurant
    List<MenuItem> getItemsByRestaurant(int restaurantId);
}