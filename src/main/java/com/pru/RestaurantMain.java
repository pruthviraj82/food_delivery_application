package com.pru;

import com.pru.DAO.RestaurantDAO;
import com.pru.DAO.implementation.RestaurantDAOImpl;
import com.pru.model.Restaurant;

import java.util.*;

public class RestaurantMain {

    public static void main(String[] args) {
        RestaurantDAO rdao = new RestaurantDAOImpl();
        Scanner scan = new Scanner(System.in);

        // ── ADD ───────────────────────────────────────
        System.out.print("Name: ");          String name  = scan.nextLine();
        System.out.print("Address: ");       String addr  = scan.nextLine();
        System.out.print("Rating (0-5): ");  double rating = Double.parseDouble(scan.nextLine());
        System.out.print("Active (true/false): "); boolean active = Boolean.parseBoolean(scan.nextLine());
        System.out.print("Image path: ");    String image = scan.nextLine();
        System.out.print("Delivery time (mins): "); int time = Integer.parseInt(scan.nextLine());

        Restaurant r = new Restaurant(name, addr, rating, active, image, time);
        rdao.addRestaurant(r);

        // ── GET ALL ───────────────────────────────────
        System.out.println("\n── All Restaurants ──");
        rdao.getAllRestaurants().forEach(System.out::println);

        // ── ACTIVE ONLY ───────────────────────────────
        System.out.println("\n── Active Restaurants ──");
        rdao.getActiveRestaurants().forEach(System.out::println);

        // ── GET ONE ───────────────────────────────────
        System.out.print("\nEnter restaurant ID to fetch: ");
        int id = Integer.parseInt(scan.nextLine());
        System.out.println("Fetched: " + rdao.getRestaurant(id));

        // ── TOGGLE STATUS ─────────────────────────────
        System.out.print("\nEnter ID to toggle status: ");
        int tid = Integer.parseInt(scan.nextLine());
        System.out.print("Set active (true/false): ");
        boolean status = Boolean.parseBoolean(scan.nextLine());
        rdao.toggleStatus(tid, status);

        // ── DELETE ────────────────────────────────────
        System.out.print("\nEnter ID to delete: ");
        int did = Integer.parseInt(scan.nextLine());
        rdao.deleteRestaurant(did);

        scan.close();
    }
}