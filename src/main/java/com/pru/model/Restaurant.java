package com.pru.model;

public class Restaurant {
    private int restaurantId;
    private String name;
    private String address;
    private double rating;
    private boolean isActive;
    private String image;
    private int deliveryTime;

    // ── Constructors ──────────────────────────────
    public Restaurant() {}

    // Without ID — for INSERT
    public Restaurant(String name, String address, double rating,
                      boolean isActive, String image, int deliveryTime) {
        this.name         = name;
        this.address      = address;
        this.rating       = rating;
        this.isActive     = isActive;
        this.image        = image;
        this.deliveryTime = deliveryTime;
    }

    // With ID — for DB reads
    public Restaurant(int restaurantId, String name, String address, double rating,
                      boolean isActive, String image, int deliveryTime) {
        this.restaurantId = restaurantId;
        this.name         = name;
        this.address      = address;
        this.rating       = rating;
        this.isActive     = isActive;
        this.image        = image;
        this.deliveryTime = deliveryTime;
    }

    // ── Getters & Setters ─────────────────────────
    public int getRestaurantId()                  { return restaurantId; }
    public void setRestaurantId(int restaurantId) { this.restaurantId = restaurantId; }

    public String getName()               { return name; }
    public void setName(String name)      { this.name = name; }

    public String getAddress()                { return address; }
    public void setAddress(String address)    { this.address = address; }

    public double getRating()               { return rating; }
    public void setRating(double rating)    { this.rating = rating; }

    public boolean isActive()                 { return isActive; }
    public void setActive(boolean isActive)   { this.isActive = isActive; }

    public String getImage()              { return image; }
    public void setImage(String image)    { this.image = image; }

    public int getDeliveryTime()                    { return deliveryTime; }
    public void setDeliveryTime(int deliveryTime)   { this.deliveryTime = deliveryTime; }

    @Override
    public String toString() {
        return "Restaurant [ID=" + restaurantId + ", Name=" + name +
               ", Rating=" + rating + ", Active=" + isActive +
               ", DeliveryTime=" + deliveryTime + " mins]";
    }
}