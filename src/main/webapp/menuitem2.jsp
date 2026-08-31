<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pru.DAO.MenuItemDAO,com.pru.DAO.implementation.MenuItemDAOImpl,com.pru.model.MenuItem,java.util.*" %>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Tomor - Menu</title>
<link href="https://fonts.googleapis.com/css2?family=Playfair+Display:ital,wght@0,600;0,700;1,600&family=Lora:wght@400;500;600&display=swap" rel="stylesheet">
<style>
* { margin: 0; padding: 0; box-sizing: border-box; }

body {
    font-family: 'Lora', serif;
    background: #0F0B08;
    color: #F0E6D1;
    min-height: 100vh;
    padding-bottom: 100px;
}

/* ── Navbar ── */
.navbar {
    background: rgba(15,11,8,0.95);
    backdrop-filter: blur(10px);
    padding: 20px 50px;
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
    font-size: 1.8rem;
    font-weight: 700;
    color: #F0E6D1;
    text-decoration: none;
    letter-spacing: 0.05em;
}

.brand span { color: #D17A2C; }

.nav-right { display: flex; align-items: center; gap: 25px; }

.nav-right a {
    color: #A89574;
    text-decoration: none;
    font-size: 0.85rem;
    letter-spacing: 0.08em;
    text-transform: uppercase;
    transition: color 0.3s;
}

.nav-right a:hover { color: #D17A2C; }

.nav-cart-btn {
    background: #D17A2C;
    color: #F0E6D1 !important;
    padding: 8px 20px;
    border-radius: 2px;
    display: flex;
    align-items: center;
    gap: 8px;
    font-size: 0.88rem !important;
}

/* ── Restaurant Banner ── */
.banner {
    position: relative;
    height: 280px;
    overflow: hidden;
}

.banner-bg {
    position: absolute;
    inset: 0;
    background: url('https://images.unsplash.com/photo-1414235077428-338989a2e8c0?w=1400') center/cover;
    filter: brightness(0.15);
}

.banner-content {
    position: relative;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: flex-end;
    padding: 35px 50px;
    border-bottom: 1px solid #2E1F14;
}

.back-link {
    position: absolute;
    top: 30px;
    left: 50px;
    color: #A89574;
    text-decoration: none;
    font-size: 0.85rem;
    letter-spacing: 0.08em;
    text-transform: uppercase;
    transition: color 0.3s;
    display: flex;
    align-items: center;
    gap: 6px;
}

.back-link:hover { color: #D17A2C; }

.banner-tag {
    display: inline-block;
    border: 1px solid #D17A2C;
    color: #D17A2C;
    padding: 4px 14px;
    font-size: 0.72rem;
    letter-spacing: 0.2em;
    text-transform: uppercase;
    margin-bottom: 12px;
    width: fit-content;
}

.banner-content h1 {
    font-family: 'Playfair Display', serif;
    font-size: 3rem;
    color: #F0E6D1;
    line-height: 1;
    margin-bottom: 10px;
}

.banner-content h1 em { font-style: italic; color: #D17A2C; }

.banner-meta {
    color: #A89574;
    font-size: 0.88rem;
}

/* ── Layout: Sidebar + Content ── */
.layout {
    display: grid;
    grid-template-columns: 220px 1fr;
    max-width: 1400px;
    margin: 0 auto;
    padding: 40px 50px;
    gap: 50px;
}

/* ── Sidebar ── */
.sidebar {
    position: sticky;
    top: 100px;
    height: fit-content;
}

.sidebar h3 {
    font-size: 0.72rem;
    letter-spacing: 0.2em;
    text-transform: uppercase;
    color: #A89574;
    margin-bottom: 16px;
    padding-bottom: 12px;
    border-bottom: 1px solid #2E1F14;
}

.sidebar-stat {
    margin-bottom: 18px;
    padding-bottom: 18px;
    border-bottom: 1px solid #2E1F14;
}

.sidebar-stat .label {
    font-size: 0.78rem;
    color: #A89574;
    text-transform: uppercase;
    letter-spacing: 0.1em;
    margin-bottom: 4px;
}

.sidebar-stat .value {
    font-family: 'Playfair Display', serif;
    font-size: 1.5rem;
    color: #D17A2C;
}

.sidebar-stat .value.small {
    font-size: 1rem;
    color: #F0E6D1;
    font-family: 'Lora', serif;
}

/* ── Menu Grid ── */
.menu-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 28px;
}

.menu-header h2 {
    font-family: 'Playfair Display', serif;
    font-size: 1.8rem;
    color: #F0E6D1;
}

.menu-header span {
    font-size: 0.85rem;
    color: #A89574;
}

.menu-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(260px, 1fr));
    gap: 20px;
}

/* ── Menu Card ── */
.card {
    background: #1A130E;
    border: 1px solid #2E1F14;
    overflow: hidden;
    display: flex;
    flex-direction: column;
    transition: border-color 0.3s, transform 0.3s;
}

.card:hover {
    border-color: #D17A2C;
    transform: translateY(-4px);
}

.card-img {
    position: relative;
    height: 175px;
    overflow: hidden;
}

.card-img img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.5s;
}

.card:hover .card-img img { transform: scale(1.07); }

.card-price-tag {
    position: absolute;
    bottom: 0;
    right: 0;
    background: #D17A2C;
    color: #F0E6D1;
    font-family: 'Playfair Display', serif;
    font-size: 1.1rem;
    font-weight: 700;
    padding: 6px 14px;
}

.card-body {
    padding: 18px;
    flex: 1;
    display: flex;
    flex-direction: column;
}

.card-body h2 {
    font-family: 'Playfair Display', serif;
    font-size: 1.15rem;
    margin-bottom: 8px;
    color: #F0E6D1;
    line-height: 1.3;
}

.card-desc {
    color: #A89574;
    font-size: 0.82rem;
    line-height: 1.6;
    flex: 1;
    margin-bottom: 16px;
}

.card-footer {
    border-top: 1px solid #2E1F14;
    padding-top: 14px;
}

/* ── Add to cart form ── */
.add-form {
    display: flex;
    gap: 8px;
    align-items: center;
}

.qty-wrap {
    display: flex;
    align-items: center;
    background: #0F0B08;
    border: 1px solid #2E1F14;
    border-radius: 2px;
    overflow: hidden;
    flex-shrink: 0;
}

.qty-btn {
    background: none;
    border: none;
    color: #D17A2C;
    font-size: 1.1rem;
    width: 30px;
    height: 34px;
    cursor: pointer;
    transition: background 0.2s;
    display: flex;
    align-items: center;
    justify-content: center;
}

.qty-btn:hover { background: #2E1F14; }

.qty-val {
    font-size: 0.9rem;
    color: #F0E6D1;
    width: 26px;
    text-align: center;
}

.btn-add {
    flex: 1;
    padding: 8px 12px;
    background: #D17A2C;
    color: #F0E6D1;
    border: none;
    cursor: pointer;
    font-family: 'Lora', serif;
    font-size: 0.88rem;
    font-weight: 600;
    transition: opacity 0.2s;
    border-radius: 2px;
}

.btn-add:hover { opacity: 0.88; }

/* ── Cart Drawer (bottom bar) ── */
.cart-bar {
    position: fixed;
    bottom: -80px;
    left: 0;
    right: 0;
    background: #1A130E;
    border-top: 2px solid #D17A2C;
    padding: 16px 50px;
    display: flex;
    justify-content: space-between;
    align-items: center;
    z-index: 200;
    transition: bottom 0.4s cubic-bezier(0.22,1,0.36,1);
}

.cart-bar.show { bottom: 0; }

.cart-bar-left { display: flex; flex-direction: column; }

.cart-bar-items {
    font-size: 0.78rem;
    color: #A89574;
    text-transform: uppercase;
    letter-spacing: 0.1em;
    margin-bottom: 2px;
}

.cart-bar-total {
    font-family: 'Playfair Display', serif;
    font-size: 1.5rem;
    color: #D17A2C;
}

.cart-bar-btn {
    background: #D17A2C;
    color: #F0E6D1;
    text-decoration: none;
    padding: 12px 30px;
    font-family: 'Lora', serif;
    font-weight: 600;
    font-size: 0.95rem;
    letter-spacing: 0.05em;
    transition: opacity 0.2s;
    border-radius: 2px;
}

.cart-bar-btn:hover { opacity: 0.9; }

/* ── Empty ── */
.empty {
    text-align: center;
    padding: 80px 20px;
    color: #A89574;
    grid-column: 1 / -1;
}

/* ── Mobile ── */
@media(max-width: 900px) {
    .layout { grid-template-columns: 1fr; padding: 25px 20px; }
    .sidebar { display: none; }
    .banner-content { padding: 25px 20px; }
    .back-link { left: 20px; }
    .navbar { padding: 16px 20px; }
    .cart-bar { padding: 14px 20px; }
}
</style>
</head>
<body>

<!-- ── Navbar ── -->
<nav class="navbar">
    <a href="restaurants" class="brand">tom<span>o</span>r</a>
    <div class="nav-right">
        <a href="restaurants">Explore</a>
        <a href="view">Orders</a>
        <a href="Cart.jsp" class="nav-cart-btn">Cart </a>
    </div>
</nav>

<!-- ── Banner ── -->
<%
    List<MenuItem> menuItems = (List<MenuItem>) request.getAttribute("menuitem");
    String restaurantId = request.getParameter("restaurantId");
    int itemCount = (menuItems != null) ? menuItems.size() : 0;
%>

<div class="banner">
    <div class="banner-bg"></div>
    <a href="restaurants" class="back-link">← Back to Restaurants</a>
    <div class="banner-content">
        <div class="banner-tag">Menu</div>
        <h1>What would you like <em>today?</em></h1>
        <div class="banner-meta"><%= itemCount %> dishes available</div>
    </div>
</div>

<!-- ── Layout ── -->
<div class="layout">

    <!-- Sidebar -->
    <aside class="sidebar">
        <h3>At a Glance</h3>
        <div class="sidebar-stat">
            <div class="label">Total Dishes</div>
            <div class="value"><%= itemCount %></div>
        </div>
        <div class="sidebar-stat">
            <div class="label">Restaurant ID</div>
            <div class="value small">#<%= restaurantId %></div>
        </div>
        <div class="sidebar-stat">
            <div class="label">Your Cart</div>
            <div class="value" id="sidebarCartTotal">₹0</div>
        </div>
    </aside>

    <!-- Menu -->
    <main>
        <div class="menu-header">
            <h2>Full Menu</h2>
            <span><%= itemCount %> items</span>
        </div>

        <div class="menu-grid">
        <%
            if (menuItems != null && !menuItems.isEmpty()) {
                for (MenuItem item : menuItems) {
        %>
        <div class="card">
            <div class="card-img">
                <img src="<%= item.getImage() != null && !item.getImage().isEmpty()
                               ? item.getImage()
                               : "https://images.unsplash.com/photo-1589302168068-964664d93dc0?w=400" %>"
                     alt="<%= item.getName() %>">
                <div class="card-price-tag">₹<%= item.getPrice() %></div>
            </div>
            <div class="card-body">
                <h2><%= item.getName() %></h2>
                <p class="card-desc"><%= item.getDescription() %></p>
                <div class="card-footer">
                    <form action="cart" class="add-form"
                          onsubmit="onAddToCart(event, '<%= item.getName() %>', <%= item.getPrice() %>)">
                        <input type="hidden" name="action"       value="add">
                        <input type="hidden" name="itemId"       value="<%= item.getItemId() %>">
                        <input type="hidden" name="restaurantId" value="<%= restaurantId %>">
                        <input type="hidden" name="quantity"     id="qty_<%= item.getItemId() %>" value="1">

                        

                        <button type="submit" class="btn-add">Add to Order</button>
                    </form>
                </div>
            </div>
        </div>
        <%
                }
            } else {
        %>
            <div class="empty">No items found for this restaurant.</div>
        <%
            }
        %>
        </div>
    </main>

</div>

<!-- ── Cart Bar ── -->
<div class="cart-bar" id="cartBar">
    <div class="cart-bar-left">
        <span class="cart-bar-items" id="cartItemsLabel">0 items in your order</span>
        <span class="cart-bar-total" id="cartTotalLabel">₹0.00</span>
    </div>
    <a href="Cart.jsp" class="cart-bar-btn">View Order →</a>
</div>

<script>
    let cartCount = 0;
    let cartTotal = 0;

    function changeQty(itemId, delta) {
        const valEl  = document.getElementById('qtyVal_' + itemId);
        const inpEl  = document.getElementById('qty_' + itemId);
        let qty = parseInt(valEl.textContent);
        qty = Math.max(1, qty + delta);
        valEl.textContent = qty;
        inpEl.value = qty;
    }

    function onAddToCart(e, name, price) {
        const form  = e.target;
        const itemId = form.querySelector('[name="itemId"]').value;
        const qty   = parseInt(document.getElementById('qty_' + itemId).value);

        cartCount += qty;
        cartTotal += price * qty;

        document.getElementById('cartItemsLabel').textContent =
            cartCount + ' item' + (cartCount !== 1 ? 's' : '') + ' in your order';
        document.getElementById('cartTotalLabel').textContent =
            '₹' + cartTotal.toFixed(2);
        document.getElementById('navCartCount').textContent = cartCount;
        document.getElementById('sidebarCartTotal').textContent =
            '₹' + cartTotal.toFixed(2);

        document.getElementById('cartBar').classList.add('show');

        // reset qty display
        document.getElementById('qtyVal_' + itemId).textContent = 1;
        document.getElementById('qty_' + itemId).value = 1;
    }
</script>

</body>
</html>
