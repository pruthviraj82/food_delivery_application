<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pru.model.Cart" %>
<%@ page import="com.pru.model.CartItem" %>
<%@ page import="java.util.Collection" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Tomor - Your Cart</title>

<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Lora:wght@400;500;600&display=swap" rel="stylesheet">

<style>
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: 'Lora', serif;
    background: #0F0B08;
    color: #F0E6D1;
    min-height: 100vh;
}

/* ── Navbar ── */
.navbar {
    background: #1A130E;
    padding: 18px 40px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #2E1F14;
    position: sticky;
    top: 0;
    z-index: 100;
}

.brand {
    font-family: 'Playfair Display', serif;
    font-size: 2rem;
    font-weight: 700;
    color: #F0E6D1;
    text-decoration: none;
}

.nav-links a {
    color: #A89574;
    text-decoration: none;
    margin-left: 25px;
    font-size: 0.95rem;
    transition: color 0.3s;
}

.nav-links a:hover {
    color: #D17A2C;
}

/* ── Hero ── */
.hero {
    text-align: center;
    padding: 50px 20px 30px;
    border-bottom: 1px solid #2E1F14;
}

.hero h1 {
    font-family: 'Playfair Display', serif;
    font-size: 2.8rem;
    margin-bottom: 10px;
}

.hero p {
    color: #A89574;
    font-size: 1rem;
}

/* ── Container ── */
.container {
    max-width: 900px;
    margin: 40px auto;
    padding: 0 20px 80px;
}

/* ── Empty Cart ── */
.empty-cart {
    text-align: center;
    padding: 80px 20px;
    color: #A89574;
}

.empty-cart h2 {
    color: #F0E6D1;
    margin-bottom: 15px;
}

.empty-cart a {
    display: inline-block;
    padding: 12px 30px;
    background: #D17A2C;
    color: #F0E6D1;
    text-decoration: none;
    border-radius: 6px;
    margin-top: 20px;
    transition: 0.3s;
}

.empty-cart a:hover {
    opacity: 0.9;
}

/* ── Cart Table ── */
.cart-table {
    background: #1A130E;
    border: 1px solid #2E1F14;
    border-radius: 6px;
    overflow: hidden;
    margin-bottom: 30px;
}

.cart-table table {
    width: 100%;
    border-collapse: collapse;
}

.cart-table th {
    background: #0F0B08;
    padding: 16px;
    text-align: left;
    font-family: 'Playfair Display', serif;
    font-size: 1.1rem;
    border-bottom: 1px solid #2E1F14;
    color: #F0E6D1;
}

.cart-table td {
    padding: 16px;
    border-bottom: 1px solid #2E1F14;
}

.cart-table tr:last-child td {
    border-bottom: none;
}

.item-name {
    font-family: 'Playfair Display', serif;
    font-size: 1.1rem;
    color: #F0E6D1;
    font-weight: 600;
}

.price, .total {
    color: #D17A2C;
    font-weight: 600;
}

/* ── Action Buttons ── */
.actions {
    display: flex;
    gap: 8px;
}

.btn-small {
    padding: 6px 12px;
    background: #D17A2C;
    color: #F0E6D1;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-size: 0.9rem;
    font-family: 'Lora', serif;
    font-weight: 600;
    transition: 0.3s;
}

.btn-small:hover {
    opacity: 0.9;
}

.btn-remove {
    background: #D13232 !important;
}

/* ── Summary ── */
.summary {
    background: #1A130E;
    border: 1px solid #2E1F14;
    border-radius: 6px;
    padding: 25px;
    margin-bottom: 30px;
}

.summary-row {
    display: flex;
    justify-content: space-between;
    margin-bottom: 15px;
    font-size: 1.1rem;
}

.summary-row.total {
    border-top: 1px solid #2E1F14;
    padding-top: 15px;
    font-weight: 600;
    font-family: 'Playfair Display', serif;
    font-size: 1.4rem;
    color: #D17A2C;
}

/* ── Checkout Section ── */
.checkout-section {
    display: flex;
    gap: 15px;
    justify-content: center;
}

.btn-large {
    padding: 14px 40px;
    background: #D17A2C;
    color: #F0E6D1;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-size: 16px;
    font-family: 'Lora', serif;
    font-weight: 600;
    transition: 0.3s;
    text-decoration: none;
    display: inline-block;
}

.btn-large:hover {
    opacity: 0.9;
    transform: translateY(-2px);
}

.btn-secondary {
    background: #A89574;
}

@media(max-width: 768px) {
    .navbar { padding: 16px 20px; }
    .hero h1 { font-size: 2rem; }
    .cart-table { overflow-x: auto; }
    .checkout-section { flex-direction: column; }
}
</style>
</head>
<body>

<!-- ── Navbar ── -->
<nav class="navbar">
    <a href="restaurants" class="brand">tomor</a>
    <div class="nav-links">
        <a href="restaurants">Restaurants</a>
        <a href="Cart.jsp">Cart</a>
    </div>
</nav>

<!-- ── Hero ── -->
<div class="hero">
    <h1>Your Order</h1>
    <p>Review your items before checkout.</p>
</div>

<div class="container">

<%
    Cart cart = (Cart) session.getAttribute("cart");
    Integer restaurantId = (Integer) session.getAttribute("restaurantId");
    double grandTotal = 0;

    if (cart == null || cart.isEmpty()) {
%>
    <!-- ── Empty Cart ── -->
    <div class="empty-cart">
        <h2>Your cart is empty</h2>
        <p>Add some delicious items to get started.</p>
        <a href="restaurants">Browse Restaurants</a>
    </div>

<%
    } else {
%>

    <!-- ── Cart Items Table ── -->
    <div class="cart-table">
        <table>
            <thead>
                <tr>
                    <th style="width: 35%;">Item Name</th>
                    <th style="width: 15%;">Price</th>
                    <th style="width: 15%;">Quantity</th>
                    <th style="width: 15%;">Total</th>
                    <th style="width: 20%;">Actions</th>
                </tr>
            </thead>
            <tbody>
        <%
            for (CartItem item : cart.getItems()) {
                double itemTotal = item.getPrice() * item.getQuantity();
                grandTotal += itemTotal;
        %>
                <tr>
                    <td>
                        <span class="item-name"><%= item.getName() %></span>
                    </td>
                    <td>
                        <span class="price">₹<%= item.getPrice() %></span>
                    </td>
                    <td>
                        <span><%= item.getQuantity() %></span>
                    </td>
                    <td>
                        <span class="total">₹<%= String.format("%.2f", itemTotal) %></span>
                    </td>
                    <td>
                        <div class="actions">
                            <!-- ── UPDATE (+) ── -->
                            <form action="cart" style="display:inline;">
                                <input type="hidden" name="menuId" value="<%= item.getMenuId() %>">
                                <input type="hidden" name="restaurantId" value="<%= item.getRestaurantId() %>">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="quantity" value="<%= item.getQuantity() + 1 %>">
                                <button type="submit" class="btn-small">+</button>
                            </form>

                            <!-- ── UPDATE (-) ── -->
                            <form action="cart" style="display:inline;">
                                <input type="hidden" name="menuId" value="<%= item.getMenuId() %>">
                                <input type="hidden" name="restaurantId" value="<%= item.getRestaurantId() %>">
                                <input type="hidden" name="action" value="update">
                                <input type="hidden" name="quantity" value="<%= item.getQuantity() - 1 %>">
                                <button type="submit" class="btn-small">−</button>
                            </form>

                            <!-- ── REMOVE ── -->
                            <form action="cart" style="display:inline;">
                                <input type="hidden" name="menuId" value="<%= item.getMenuId() %>">
                                <input type="hidden" name="restaurantId" value="<%= item.getRestaurantId() %>">
                                <input type="hidden" name="action" value="delete">
                                <button type="submit" class="btn-small btn-remove">Remove</button>
                            </form>
                        </div>
                    </td>
                </tr>
        <%
            }
        %>
            </tbody>
        </table>
    </div>

    <!-- ── Summary ── -->
    <div class="summary">
        <div class="summary-row">
            <span>Subtotal:</span>
            <span>₹<%= String.format("%.2f", grandTotal) %></span>
        </div>
        <div class="summary-row">
            <span>Delivery Charge:</span>
            <span>₹50</span>
        </div>
        <div class="summary-row total">
            <span>Grand Total:</span>
            <span>₹<%= String.format("%.2f", grandTotal + 50) %></span>
        </div>
    </div>

    <!-- ── Checkout Buttons ── -->
    <div class="checkout-section">
        <a href= "MenuItem?restaurantId=<%= restaurantId %>"class="btn-large btn-secondary">
            ← Add More Items
        </a>
        <a href="checkout.jsp" class="btn-large">
            Proceed to Checkout →
        </a>
    </div>

<%
    }
%>

</div>

</body>
</html>