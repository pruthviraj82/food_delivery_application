<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Tomor - Order Confirmed</title>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:wght@600;700&family=Lora:wght@400;500;600&display=swap" rel="stylesheet">
<style>
* { margin: 0; padding: 0; box-sizing: border-box; }

body {
    font-family: 'Lora', serif;
    background: #0F0B08;
    color: #F0E6D1;
    min-height: 100vh;
    display: flex;
    flex-direction: column;
}

.navbar {
    background: #1A130E;
    padding: 18px 40px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    border-bottom: 1px solid #2E1F14;
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

.container {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 60px 20px;
}

.card {
    background: #1A130E;
    border: 1px solid #2E1F14;
    border-radius: 6px;
    padding: 60px 50px;
    text-align: center;
    max-width: 520px;
    width: 100%;
}

/* ── Animated Checkmark ── */
.check-circle {
    width: 90px;
    height: 90px;
    border-radius: 50%;
    background: rgba(209, 122, 44, 0.15);
    border: 2px solid #D17A2C;
    display: flex;
    align-items: center;
    justify-content: center;
    margin: 0 auto 30px;
    animation: popIn 0.5s ease forwards;
}

@keyframes popIn {
    0%   { transform: scale(0); opacity: 0; }
    70%  { transform: scale(1.1); }
    100% { transform: scale(1); opacity: 1; }
}

.check-circle svg {
    width: 45px;
    height: 45px;
    stroke: #D17A2C;
    stroke-width: 3;
    stroke-dasharray: 60;
    stroke-dashoffset: 60;
    animation: drawCheck 0.5s ease 0.4s forwards;
    fill: none;
    stroke-linecap: round;
    stroke-linejoin: round;
}

@keyframes drawCheck {
    to { stroke-dashoffset: 0; }
}

h1 {
    font-family: 'Playfair Display', serif;
    font-size: 2.2rem;
    margin-bottom: 12px;
    color: #F0E6D1;
}

.subtitle {
    color: #A89574;
    font-size: 1rem;
    margin-bottom: 35px;
    line-height: 1.6;
}

.order-info {
    background: #0F0B08;
    border: 1px solid #2E1F14;
    border-radius: 4px;
    padding: 20px 25px;
    margin-bottom: 35px;
    text-align: left;
}

.info-row {
    display: flex;
    justify-content: space-between;
    padding: 8px 0;
    border-bottom: 1px solid #2E1F14;
    font-size: 0.95rem;
}

.info-row:last-child { border-bottom: none; }

.info-row span:first-child { color: #A89574; }
.info-row span:last-child  { color: #F0E6D1; font-weight: 600; }

.btn-group {
    display: flex;
    gap: 15px;
}

.btn {
    flex: 1;
    padding: 14px;
    border: none;
    border-radius: 6px;
    cursor: pointer;
    font-family: 'Lora', serif;
    font-size: 1rem;
    font-weight: 600;
    text-decoration: none;
    text-align: center;
    display: block;
    transition: 0.3s;
}

.btn-primary {
    background: #D17A2C;
    color: #F0E6D1;
}

.btn-primary:hover { opacity: 0.9; transform: translateY(-2px); }

.btn-secondary {
    background: transparent;
    color: #A89574;
    border: 1px solid #2E1F14;
}

.btn-secondary:hover { border-color: #D17A2C; color: #D17A2C; }

@media(max-width: 600px) {
    .card { padding: 40px 25px; }
    .btn-group { flex-direction: column; }
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

<div class="container">
    <div class="card">

        <!-- Animated check -->
        <div class="check-circle">
            <svg viewBox="0 0 52 52">
                <polyline points="14,27 22,35 38,19"/>
            </svg>
        </div>

        <h1>Order Placed!</h1>
        <p class="subtitle">Your order has been confirmed and is being prepared. You'll receive it soon.</p>

        <%
            Integer orderId = (Integer) session.getAttribute("lastOrderId");
            String paymentMethod = (String) session.getAttribute("lastPaymentMethod");
            Double totalAmount   = (Double)  session.getAttribute("lastTotalAmount");
        %>

        <div class="order-info">
            <% if (orderId != null) { %>
            <div class="info-row">
                <span>Order ID</span>
                <span>#<%= orderId %></span>
            </div>
            <% } %>
            <% if (paymentMethod != null) { %>
            <div class="info-row">
                <span>Payment</span>
                <span><%= paymentMethod %></span>
            </div>
            <% } %>
            <% if (totalAmount != null) { %>
            <div class="info-row">
                <span>Total Paid</span>
                <span>₹<%= String.format("%.2f", totalAmount) %></span>
            </div>
            <% } %>
            <div class="info-row">
                <span>Status</span>
                <span style="color: #D17A2C;">Pending</span>
            </div>
        </div>

        <div class="btn-group">
            <a href="view" class="btn btn-primary">View My Orders</a>
            <a href="restaurants" class="btn btn-secondary">Order Again</a>
        </div>

    </div>
</div>

</body>
</html>
