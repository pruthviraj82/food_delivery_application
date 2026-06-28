package com.pru.model;

public class MenuItem {
    private int itemId;
    private int restaurantId;     // FK → restaurant
    private String name;
    private double price;
    private String description;
    private String image;

    // ── Constructors ──────────────────────────────
    public MenuItem() {}

    // Without ID — for INSERT
    public MenuItem(int restaurantId, String name, double price,
                    String description, String image) {
        this.restaurantId = restaurantId;
        this.name         = name;
        this.price        = price;
        this.description  = description;
        this.image        = image;
    }

    // With ID — for DB reads
    public MenuItem(int itemId, int restaurantId, String name, double price,
                    String description, String image) {
        this.itemId       = itemId;
        this.restaurantId = restaurantId;
        this.name         = name;
        this.price        = price;
        this.description  = description;
        this.image        = image;
    }

    // ── Getters & Setters ─────────────────────────
    public int getItemId()                { return itemId; }
    public void setItemId(int itemId)     { this.itemId = itemId; }

    public int getRestaurantId()                      { return restaurantId; }
    public void setRestaurantId(int restaurantId)     { this.restaurantId = restaurantId; }

    public String getName()               { return name; }
    public void setName(String name)      { this.name = name; }

    public double getPrice()              { return price; }
    public void setPrice(double price)    { this.price = price; }

    public String getDescription()                    { return description; }
    public void setDescription(String description)    { this.description = description; }

    public String getImage()              { return image; }
    public void setImage(String image)    { this.image = image; }

    @Override
    public String toString() {
        return "MenuItem [ID=" + itemId + ", RestaurantID=" + restaurantId +
               ", Name=" + name + ", Price=" + price + "]";
    }
}