<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pru.model.Cart" %>
<%@ page import="com.pru.model.CartItem" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Tomor - Checkout</title>

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
    padding: 40px 20px;
    border-bottom: 1px solid #2E1F14;
}

.hero h1 {
    font-family: 'Playfair Display', serif;
    font-size: 2.5rem;
    margin-bottom: 8px;
}

.hero p {
    color: #A89574;
}

/* ── Main Container ── */
.main-container {
    max-width: 1200px;
    margin: 40px auto;
    padding: 0 20px 80px;
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 40px;
}

/* ── Form Section ── */
.form-section {
    background: #1A130E;
    border: 1px solid #2E1F14;
    border-radius: 6px;
    padding: 30px;
}

.form-section h2 {
    font-family: 'Playfair Display', serif;
    font-size: 1.8rem;
    margin-bottom: 25px;
    color: #F0E6D1;
}

.form-group {
    margin-bottom: 20px;
}

.form-group label {
    display: block;
    margin-bottom: 8px;
    color: #A89574;
    font-size: 0.95rem;
    font-weight: 600;
}

.form-group input,
.form-group select,
.form-group textarea {
    width: 100%;
    padding: 12px;
    background: #0F0B08;
    border: 1px solid #2E1F14;
    color: #F0E6D1;
    border-radius: 4px;
    font-family: 'Lora', serif;
    font-size: 0.95rem;
}

.form-group input:focus,
.form-group select:focus,
.form-group textarea:focus {
    outline: none;
    border-color: #D17A2C;
    box-shadow: 0 0 5px rgba(209, 122, 44, 0.3);
}

.form-group textarea {
    resize: vertical;
    min-height: 80px;
}

.payment-methods {
    display: flex;
    gap: 15px;
    margin-top: 12px;
}

.radio-label {
    display: flex;
    align-items: center;
    gap: 8px;
    cursor: pointer;
    margin: 0;
    color: #A89574;
}

.radio-label input[type="radio"] {
    width: auto;
    margin: 0;
    cursor: pointer;
}

/* ── Order Summary Section ── */
.summary-section {
    background: #1A130E;
    border: 1px solid #2E1F14;
    border-radius: 6px;
    padding: 30px;
    height: fit-content;
    position: sticky;
    top: 100px;
}

.summary-section h2 {
    font-family: 'Playfair Display', serif;
    font-size: 1.8rem;
    margin-bottom: 25px;
    color: #F0E6D1;
}

/* ── Items List ── */
.items-list {
    border-bottom: 1px solid #2E1F14;
    padding-bottom: 20px;
    margin-bottom: 20px;
}

.item-row {
    display: flex;
    justify-content: space-between;
    margin-bottom: 15px;
    padding-bottom: 10px;
    border-bottom: 1px solid #2E1F14;
}

.item-details {
    flex: 1;
}

.item-name {
    font-family: 'Playfair Display', serif;
    font-size: 1rem;
    font-weight: 600;
    color: #F0E6D1;
    margin-bottom: 5px;
}

.item-qty {
    color: #A89574;
    font-size: 0.9rem;
}

.item-price {
    text-align: right;
}

.item-price-val {
    color: #D17A2C;
    font-weight: 600;
    display: block;
}

.item-unit {
    color: #A89574;
    font-size: 0.9rem;
}

/* ── Charges ── */
.charges {
    margin-bottom: 20px;
}

.charge-row {
    display: flex;
    justify-content: space-between;
    margin-bottom: 12px;
    font-size: 0.95rem;
}

.charge-row span:first-child {
    color: #A89574;
}

.charge-row span:last-child {
    color: #F0E6D1;
    font-weight: 600;
}

.charge-row.platform,
.charge-row.delivery {
    padding: 8px 0;
}

/* ── Total ── */
.total-section {
    border-top: 2px solid #D17A2C;
    padding-top: 20px;
    margin-bottom: 25px;
}

.total-row {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-family: 'Playfair Display', serif;
    font-size: 1.4rem;
    font-weight: 700;
}

.total-row span:first-child {
    color: #F0E6D1;
}

.total-row span:last-child {
    color: #D17A2C;
}

/* ── Buttons ── */
.button-group {
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
    transition: 0.3s;
}

.btn-submit {
    background: #D17A2C;
    color: #F0E6D1;
}

.btn-submit:hover {
    opacity: 0.9;
    transform: translateY(-2px);
}

.btn-back {
    background: #A89574;
    color: #F0E6D1;
}

.btn-back:hover {
    opacity: 0.9;
}

/* ── Responsive ── */
@media(max-width: 992px) {
    .main-container {
        grid-template-columns: 1fr;
    }
    
    .summary-section {
        position: static;
        top: auto;
    }
}

@media(max-width: 768px) {
    .navbar { padding: 16px 20px; }
    .hero h1 { font-size: 1.8rem; }
    .main-container { gap: 20px; }
    .form-section, .summary-section { padding: 20px; }
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
    <h1>Checkout</h1>
    <p>Complete your order</p>
</div>

<!-- ── Main Container ── -->
<div class="main-container">

    <!-- ── FORM SECTION ── -->
    <form class="form-section">
        <h2>Delivery Details</h2>
        
        <div class="form-group">
            <label for="name">Full Name *</label>
            <input type="text" id="name" name="name" required>
        </div>
        
        <div class="form-group">
            <label for="email">Email Address *</label>
            <input type="email" id="email" name="email" required>
        </div>
        
        <div class="form-group">
            <label for="phone">Phone Number *</label>
            <input type="tel" id="phone" name="phone" placeholder="10 digit number" required>
        </div>
        
        <div class="form-group">
            <label for="address">Delivery Address *</label>
            <textarea id="address" name="address" required></textarea>
        </div>
        
        <div class="form-group">
            <label>Payment Method *</label>
            <div class="payment-methods">
                <label class="radio-label">
                    <input type="radio" name="paymentMethod" value="credit_card" required>
                    Credit Card
                </label>
                <label class="radio-label">
                    <input type="radio" name="paymentMethod" value="debit_card">
                    Debit Card
                </label>
                <label class="radio-label">
                    <input type="radio" name="paymentMethod" value="upi">
                    UPI
                </label>
                <label class="radio-label">
                    <input type="radio" name="paymentMethod" value="cod">
                    Cash on Delivery
                </label>
            </div>
        </div>
    </form>

    <!-- ── ORDER SUMMARY SECTION ── -->
    <div class="summary-section">
        <h2>Order Summary</h2>
        
        <%
            Cart cart = (Cart) session.getAttribute("cart");
            double subtotal = 0;
            
            if (cart != null && !cart.isEmpty()) {
        %>
        
        <div class="items-list">
            <%
                for (CartItem item : cart.getItems()) {
                    double itemTotal = item.getPrice() * item.getQuantity();
                    subtotal += itemTotal;
            %>
            <div class="item-row">
                <div class="item-details">
                    <div class="item-name"><%= item.getName() %></div>
                    <div class="item-qty">Qty: <%= item.getQuantity() %></div>
                </div>
                <div class="item-price">
                    <span class="item-price-val">₹<%= String.format("%.2f", itemTotal) %></span>
                    <span class="item-unit">₹<%= item.getPrice() %>/unit</span>
                </div>
            </div>
            <%
                }
            %>
        </div>
        
        <div class="charges">
            <div class="charge-row">
                <span>Subtotal</span>
                <span>₹<%= String.format("%.2f", subtotal) %></span>
            </div>
            <div class="charge-row platform">
                <span>Platform Fee</span>
                <span>₹40</span>
            </div>
            <div class="charge-row delivery">
                <span>Delivery Fee</span>
                <span>₹50</span>
            </div>
        </div>
        
        <div class="total-section">
            <div class="total-row">
                <span>Grand Total</span>
                <span>₹<%= String.format("%.2f", subtotal + 40 + 50) %></span>
            </div>
        </div>
        
        <div class="button-group">
            <a href="Cart.jsp" class="btn btn-back">← Back to Cart</a>
            <form method="post" action="checkout">
    <!-- keep all your existing input fields inside this form -->
    <button type="submit" class="btn btn-submit">Proceed →</button>
</form>        </div>
        
        <%
            } else {
        %>
        <p style="color: #A89574; text-align: center; padding: 40px;">Your cart is empty</p>
        <a href="restaurants" class="btn btn-submit" style="display: block; text-align: center; text-decoration: none;">Browse Restaurants</a>
        <%
            }
        %>
    </div>

</div>

<script>
function proceedToPayment() {
    const name = document.getElementById('name').value;
    const email = document.getElementById('email').value;
    const phone = document.getElementById('phone').value;
    const address = document.getElementById('address').value;
    const paymentMethod = document.querySelector('input[name="paymentMethod"]:checked');
    
    if (!name || !email || !phone || !address || !paymentMethod) {
        alert('Please fill all fields');
        return;
    }
    
    // Redirect to payment success page
    window.location.href = 'payment-success.html';
}
</script>

</body>
</html>