package com.pru.model;
import com.pru.model.CartItem;
import java.util.HashMap;
import java.util.*;

public class Cart {
	Map<Integer,CartItem>items;
	
	
	public Cart() {
		items = new HashMap<Integer,CartItem>();
	}
	
	public Map<Integer,CartItem> getItem(){
		return items;
	}
	public Collection<CartItem> getItems(){
		return items.values();
	}
	
	public boolean isEmpty() {
	    return items.isEmpty();
	}
	
    public void addItem(CartItem cartItem) {
        int menuId = cartItem.getMenuId();
        if (items.containsKey(menuId)) {
            CartItem existing = items.get(menuId);
            existing.setQuantity(existing.getQuantity() + cartItem.getQuantity());
        } else {
            items.put(menuId, cartItem);
        }
    }

    // UPDATE: set quantity; remove if zero or below
    public void updateItem(int menuId, int quantity) {
        if (items.containsKey(menuId)) {
            if (quantity <= 0) {
                items.remove(menuId);
            } else {
                items.get(menuId).setQuantity(quantity);
            }
        }
    }

    // REMOVE: delete item from hashmap
    public void removeItem(int menuId) {
        items.remove(menuId);
    }

}
