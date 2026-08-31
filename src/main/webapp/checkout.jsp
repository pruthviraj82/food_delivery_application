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

<!-- ── Razorpay Script ── -->
<script src="https://checkout.razorpay.com/v1/checkout.js"></script>

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

.main-container {
    max-width: 1200px;
    margin: 40px auto;
    padding: 0 20px 80px;
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 40px;
}

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

.form-group { margin-bottom: 20px; }

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

.form-group textarea { resize: vertical; min-height: 80px; }

.payment-methods {
    display: flex;
    gap: 15px;
    margin-top: 12px;
    flex-wrap: wrap;
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
    accent-color: #D17A2C;
}

/* Razorpay option highlight */
.radio-label.razorpay-label {
    color: #D17A2C;
    font-weight: 600;
    border: 1px solid #D17A2C;
    padding: 6px 12px;
    border-radius: 4px;
}

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

.item-details { flex: 1; }

.item-name {
    font-family: 'Playfair Display', serif;
    font-size: 1rem;
    font-weight: 600;
    color: #F0E6D1;
    margin-bottom: 5px;
}

.item-qty { color: #A89574; font-size: 0.9rem; }

.item-price { text-align: right; }

.item-price-val {
    color: #D17A2C;
    font-weight: 600;
    display: block;
}

.item-unit { color: #A89574; font-size: 0.9rem; }

.charges { margin-bottom: 20px; }

.charge-row {
    display: flex;
    justify-content: space-between;
    margin-bottom: 12px;
    font-size: 0.95rem;
}

.charge-row span:first-child { color: #A89574; }
.charge-row span:last-child { color: #F0E6D1; font-weight: 600; }

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

.total-row span:first-child { color: #F0E6D1; }
.total-row span:last-child { color: #D17A2C; }

.button-group { display: flex; gap: 15px; }

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
    text-align: center;
    text-decoration: none;
    display: inline-block;
}

.btn-submit { background: #D17A2C; color: #F0E6D1; }
.btn-submit:hover { opacity: 0.9; transform: translateY(-2px); }
.btn-back { background: #A89574; color: #F0E6D1; }
.btn-back:hover { opacity: 0.9; }

/* ── Error message ── */
.error-msg {
    background: rgba(209, 50, 50, 0.15);
    border: 1px solid #D13232;
    color: #E57373;
    padding: 12px 16px;
    border-radius: 4px;
    margin-bottom: 20px;
    font-size: 0.9rem;
    display: none;
}
.error-msg.show { display: block; }

/* ── Hidden form for verify ── */
#verifyForm { display: none; }

@media(max-width: 992px) {
    .main-container { grid-template-columns: 1fr; }
    .summary-section { position: static; }
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

<!-- ── Calculate total for Razorpay ── -->
<%
    Cart cart = (Cart) session.getAttribute("cart");
    double subtotal = 0;
    if (cart != null && !cart.isEmpty()) {
        for (CartItem item : cart.getItems()) {
            subtotal += item.getPrice() * item.getQuantity();
        }
    }
    double grandTotal = subtotal + 40 + 50;
%>

<!-- ── Main Container ── -->
<div class="main-container">

    <!-- ── FORM SECTION ── -->
    <div class="form-section">
        <h2>Delivery Details</h2>

        <!-- Error message -->
        <div class="error-msg" id="errorMsg">Please fill all fields before proceeding.</div>

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
                <label class="radio-label razorpay-label">
                    <input type="radio" name="paymentMethod" value="razorpay" checked>
                    💳 Pay Online (Razorpay)
                </label>
                <label class="radio-label">
                    <input type="radio" name="paymentMethod" value="cod">
                    🏠 Cash on Delivery
                </label>
            </div>
        </div>
    </div>

    <!-- ── ORDER SUMMARY SECTION ── -->
    <div class="summary-section">
        <h2>Order Summary</h2>

        <%
            if (cart != null && !cart.isEmpty()) {
        %>

        <div class="items-list">
            <%
                for (CartItem item : cart.getItems()) {
                    double itemTotal = item.getPrice() * item.getQuantity();
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
            <div class="charge-row">
                <span>Platform Fee</span>
                <span>₹40</span>
            </div>
            <div class="charge-row">
                <span>Delivery Fee</span>
                <span>₹50</span>
            </div>
        </div>

        <div class="total-section">
            <div class="total-row">
                <span>Grand Total</span>
                <span>₹<%= String.format("%.2f", grandTotal) %></span>
            </div>
        </div>

        <div class="button-group">
            <a href="Cart.jsp" class="btn btn-back">← Back to Cart</a>
            <button type="button" class="btn btn-submit" onclick="proceedToPayment()">
                Proceed →
            </button>
        </div>

        <%
            } else {
        %>
        <p style="color: #A89574; text-align: center; padding: 40px;">Your cart is empty</p>
        <a href="restaurants" class="btn btn-submit"
           style="display: block; text-align: center; text-decoration: none;">
            Browse Restaurants
        </a>
        <%
            }
        %>
    </div>

</div>

<!-- ── Hidden form to submit to verifyPayment servlet ── -->
<form id="verifyForm" action="verifyPayment" method="post">
    <input type="hidden" id="razorpay_payment_id"  name="razorpay_payment_id">
    <input type="hidden" id="razorpay_order_id"    name="razorpay_order_id">
    <input type="hidden" id="razorpay_signature"   name="razorpay_signature">
    <input type="hidden" id="hidden_phone"         name="phone">
    <input type="hidden" id="hidden_address"       name="address">
</form>

<!-- ── Hidden form for COD ── -->
<form id="codForm" action="checkout" method="post">
    <input type="hidden" id="cod_name"          name="name">
    <input type="hidden" id="cod_email"         name="email">
    <input type="hidden" id="cod_phone"         name="phone">
    <input type="hidden" id="cod_address"       name="address">
    <input type="hidden" name="paymentMethod"   value="Cash on Delivery">
</form>

<script>
function proceedToPayment() {

    // ── Validate all fields ──
    const name    = document.getElementById('name').value.trim();
    const email   = document.getElementById('email').value.trim();
    const phone   = document.getElementById('phone').value.trim();
    const address = document.getElementById('address').value.trim();
    const payment = document.querySelector('input[name="paymentMethod"]:checked');

    if (!name || !email || !phone || !address || !payment) {
        document.getElementById('errorMsg').classList.add('show');
        return;
    }

    document.getElementById('errorMsg').classList.remove('show');

    const paymentMethod = payment.value;

    // ── COD — submit directly to checkout servlet ──
    if (paymentMethod === 'cod') {
        document.getElementById('cod_name').value    = name;
        document.getElementById('cod_email').value   = email;
        document.getElementById('cod_phone').value   = phone;
        document.getElementById('cod_address').value = address;
        document.getElementById('codForm').submit();
        return;
    }

    // ── Razorpay — create order first ──
    const totalAmount = <%= grandTotal %>;

    fetch('createRazorpayOrder', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'amount=' + totalAmount
    })
    .then(res => res.json())
    .then(data => {

        if (data.error) {
            alert('Payment error: ' + data.error);
            return;
        }

        // ── Open Razorpay popup ──
        var options = {
            key: 'rzp_test_TD6Engm1YHy8pB',
            amount: data.amount,
            currency: data.currency,
            name: 'Tomor',
            description: 'Food Order Payment',
            order_id: data.orderId,
            handler: function(response) {
                // ── Payment success — submit to verify servlet ──
                document.getElementById('razorpay_payment_id').value = response.razorpay_payment_id;
                document.getElementById('razorpay_order_id').value   = response.razorpay_order_id;
                document.getElementById('razorpay_signature').value  = response.razorpay_signature;
                document.getElementById('hidden_phone').value        = phone;
                document.getElementById('hidden_address').value      = address;
                document.getElementById('verifyForm').submit();
            },
            prefill: {
                name:  name,
                email: email,
                contact: phone
            },
            theme: {
                color: '#D17A2C'
            },
            modal: {
                ondismiss: function() {
                    alert('Payment cancelled. Please try again.');
                }
            }
        };

        var rzp = new Razorpay(options);
        rzp.open();

    })
    .catch(err => {
        console.error('Error:', err);
        alert('Something went wrong. Please try again.');
    });
}
</script>

</body>
</html>