package com.pru.DAO;

import com.pru.model.Order;
import com.pru.model.OrderItem;
import java.util.List;

public interface OrderDAO {

    int addOrder(Order order);              // returns generated order_id
    void addOrderItem(OrderItem orderItem);
    List<Order> getOrdersByUserId(int userId);
}