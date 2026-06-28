package com.pru;

import com.pru.DAO.MenuItemDAO;
import com.pru.DAO.implementation.MenuItemDAOImpl;
import com.pru.model.MenuItem;

import java.util.*;

public class MenuItemMain {

    public static void main(String[] args) {
        MenuItemDAO mdao = new MenuItemDAOImpl();
        Scanner scan = new Scanner(System.in);

        // ── ADD ───────────────────────────────────────
        System.out.print("Restaurant ID: ");
        int rid = Integer.parseInt(scan.nextLine());
        System.out.print("Item Name: ");       String name  = scan.nextLine();
        System.out.print("Price: ");           double price = Double.parseDouble(scan.nextLine());
        System.out.print("Description: ");     String desc  = scan.nextLine();
        System.out.print("Image path: ");      String image = scan.nextLine();

        MenuItem item = new MenuItem(rid, name, price, desc, image);
        mdao.addItem(item);

        // ── GET ALL ───────────────────────────────────
        System.out.println("\n── All Items ──");
        mdao.getAllItems().forEach(System.out::println);

        // ── GET BY RESTAURANT ─────────────────────────
        System.out.print("\nGet items for Restaurant ID: ");
        int filterRid = Integer.parseInt(scan.nextLine());
        System.out.println("── Items for Restaurant " + filterRid + " ──");
        mdao.getItemsByRestaurant(filterRid).forEach(System.out::println);

        // ── GET ONE ───────────────────────────────────
        System.out.print("\nEnter item ID to fetch: ");
        int id = Integer.parseInt(scan.nextLine());
        System.out.println("Fetched: " + mdao.getItem(id));

        // ── UPDATE ────────────────────────────────────
        System.out.print("\nEnter item ID to update: ");
        int uid = Integer.parseInt(scan.nextLine());
        MenuItem toUpdate = mdao.getItem(uid);
        System.out.print("New price: ");
        toUpdate.setPrice(Double.parseDouble(scan.nextLine()));
        mdao.updateItem(toUpdate);
        System.out.println("After update: " + mdao.getItem(uid));

        // ── DELETE ────────────────────────────────────
        System.out.print("\nEnter item ID to delete: ");
        int did = Integer.parseInt(scan.nextLine());
        mdao.deleteItem(did);

        scan.close();
    }
}