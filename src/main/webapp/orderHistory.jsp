<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pru.model.Order" %>
<%@ page import="com.pru.model.OrderItem" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Tomor - My Orders</title>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Lora:wght@400;500;600&display=swap" rel="stylesheet">
<style>
* { margin: 0; padding: 0; box-sizing: border-box; }

body {
    font-family: 'Lora', serif;
    background: #0F0B08;
    color: #F0E6D1;
    min-height: 100vh;
}

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

.nav-links a:hover { color: #D17A2C; }

.hero {
    text-align: center;
    padding: 40px 20px;
    border-bottom: 1px solid #2E1F14;
}

.hero h1 {
    font-family: 'Playfair Display', serif;
    font-size: 2.5rem;
    margin-bottom: 8px;
}

.hero p { color: #A89574; }

.container {
    max-width: 900px;
    margin: 40px auto;
    padding: 0 20px 80px;
}

/* ── Order Card ── */
.order-card {
    background: #1A130E;
    border: 1px solid #2E1F14;
    border-radius: 6px;
    margin-bottom: 25px;
    overflow: hidden;
}

.order-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 20px 25px;
    border-bottom: 1px solid #2E1F14;
    flex-wrap: wrap;
    gap: 12px;
}

.order-id {
    font-family: 'Playfair Display', serif;
    font-size: 1.2rem;
    font-weight: 700;
    color: #F0E6D1;
}

.order-date {
    color: #A89574;
    font-size: 0.88rem;
    margin-top: 4px;
}

.order-meta {
    display: flex;
    align-items: center;
    gap: 20px;
}

.status-badge {
    padding: 5px 14px;
    border-radius: 20px;
    font-size: 0.85rem;
    font-weight: 600;
    text-transform: capitalize;
}

.status-pending  { background: rgba(209,122,44,0.15); color: #D17A2C; border: 1px solid rgba(209,122,44,0.3); }
.status-delivered{ background: rgba(74,163,80,0.15);  color: #5CB85C; border: 1px solid rgba(74,163,80,0.3); }
.status-cancelled{ background: rgba(220,53,69,0.15);  color: #DC3545; border: 1px solid rgba(220,53,69,0.3); }
.status-preparing{ background: rgba(168,149,116,0.15);color: #A89574; border: 1px solid rgba(168,149,116,0.3); }

.order-total {
    font-family: 'Playfair Display', serif;
    font-size: 1.3rem;
    font-weight: 700;
    color: #D17A2C;
}

/* ── Items Table ── */
.items-table {
    width: 100%;
    border-collapse: collapse;
}

.items-table th {
    background: #0F0B08;
    color: #A89574;
    font-size: 0.85rem;
    font-weight: 600;
    text-align: left;
    padding: 12px 25px;
    text-transform: uppercase;
    letter-spacing: 0.05em;
}

.items-table td {
    padding: 14px 25px;
    border-top: 1px solid #2E1F14;
    font-size: 0.95rem;
    color: #F0E6D1;
}

.items-table td:last-child { text-align: right; color: #D17A2C; font-weight: 600; }
.items-table th:last-child { text-align: right; }

.item-qty-badge {
    display: inline-block;
    background: rgba(209,122,44,0.1);
    color: #A89574;
    border-radius: 3px;
    padding: 2px 8px;
    font-size: 0.85rem;
    margin-left: 8px;
}

/* ── Payment row ── */
.order-footer {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding: 14px 25px;
    background: #0F0B08;
    border-top: 1px solid #2E1F14;
    font-size: 0.9rem;
}

.payment-info { color: #A89574; }
.payment-info span { color: #F0E6D1; font-weight: 600; margin-left: 6px; }

/* ── Empty State ── */
.empty-state {
    text-align: center;
    padding: 80px 20px;
    background: #1A130E;
    border: 1px solid #2E1F14;
    border-radius: 6px;
}

.empty-state h2 {
    font-family: 'Playfair Display', serif;
    font-size: 1.8rem;
    margin-bottom: 12px;
}

.empty-state p { color: #A89574; margin-bottom: 30px; }

.btn {
    display: inline-block;
    padding: 14px 30px;
    background: #D17A2C;
    color: #F0E6D1;
    text-decoration: none;
    border-radius: 6px;
    font-family: 'Lora', serif;
    font-weight: 600;
    font-size: 1rem;
    transition: 0.3s;
}

.btn:hover { opacity: 0.9; transform: translateY(-2px); }

@media(max-width: 768px) {
    .navbar { padding: 16px 20px; }
    .hero h1 { font-size: 1.8rem; }
    .order-header { flex-direction: column; align-items: flex-start; }
    .items-table th, .items-table td { padding: 12px 15px; }
    .order-footer { flex-direction: column; gap: 8px; align-items: flex-start; }
}
</style>
</head>
<body>

<nav class="navbar">
    <a href="restaurants" class="brand">tomor</a>
    <div class="nav-links">
        <a href="restaurants">Restaurants</a>
        <a href="view">My Orders</a>
    </div>
</nav>

<div class="hero">
    <h1>My Orders</h1>
    <p>Your order history</p>
</div>

<div class="container">

<%
    List<Order> orders = (List<Order>) request.getAttribute("orders");
    Map<Integer, List<OrderItem>> orderItemsMap =
        (Map<Integer, List<OrderItem>>) request.getAttribute("orderItemsMap");

    if (orders == null || orders.isEmpty()) {
%>
    <div class="empty-state">
        <h2>No orders yet</h2>
        <p>You haven't placed any orders. Start exploring restaurants.</p>
        <a href="restaurants" class="btn">Browse Restaurants</a>
    </div>
<%
    } else {
        for (Order order : orders) {

            String status = order.getStatus() != null ? order.getStatus().toLowerCase() : "pending";
            String badgeClass = "status-" + status;

            List<OrderItem> items = orderItemsMap.get(order.getOrderId());
%>
    <div class="order-card">

        <!-- Header -->
        <div class="order-header">
            <div>
                <div class="order-id">Order #<%= order.getOrderId() %></div>
                <div class="order-date">
                    <%= order.getOrderDate() != null
                        ? new java.text.SimpleDateFormat("dd MMM yyyy, hh:mm a").format(order.getOrderDate())
                        : "—" %>
                </div>
            </div>
            <div class="order-meta">
                <span class="status-badge <%= badgeClass %>"><%= order.getStatus() %></span>
                <span class="order-total">₹<%= String.format("%.2f", order.getTotalAmount()) %></span>
            </div>
        </div>

        <!-- Items -->
        <% if (items != null && !items.isEmpty()) { %>
        <table class="items-table">
            <thead>
                <tr>
                    <th>Item</th>
                    <th>Qty</th>
                    <th>Total</th>
                </tr>
            </thead>
            <tbody>
                <% for (OrderItem item : items) { %>
                <tr>
                    <td>Item #<%= item.getMenuId() %></td>
                    <td><span class="item-qty-badge">× <%= item.getQuantity() %></span></td>
                    <td>₹<%= String.format("%.2f", item.getItemTotal()) %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
        <% } %>

        <!-- Footer -->
        <div class="order-footer">
            <div class="payment-info">
                Payment:
                <span><%= order.getPaymentMethod() != null ? order.getPaymentMethod() : "—" %></span>
            </div>
            <div class="payment-info">
                Restaurant ID: <span><%= order.getRestaurantId() %></span>
            </div>
        </div>

    </div>
<%
        }
    }
%>

</div>

</body>
</html>
