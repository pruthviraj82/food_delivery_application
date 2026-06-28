package com.pru.DAO;

import com.pru.model.OrderItem;
import java.util.List;

public interface OrderItemDAO {

    void addOrderItem(OrderItem item);

    void deleteOrderItem(int orderItemId);

    OrderItem getOrderItem(int orderItemId);

    // Most important — get all items inside one order
    List<OrderItem> getItemsByOrder(int orderId);
}