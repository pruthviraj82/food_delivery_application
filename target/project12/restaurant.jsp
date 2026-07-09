<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pru.DAO.RestaurantDAO,com.pru.DAO.implementation.RestaurantDAOImpl,com.pru.model.Restaurant,java.util.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Tomor - Restaurants</title>

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

/* ── Hero (video background) ── */
.hero {
    position: relative;
    text-align: center;
    padding: 100px 20px 80px;
    border-bottom: 1px solid #2E1F14;
    overflow: hidden;
    height = 100px;
}

.hero-video {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    object-fit: cover;
    z-index: 0;
}

.hero-overlay {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: linear-gradient(180deg, rgba(15,11,8,0.55) 0%, rgba(15,11,8,0.85) 100%);
    z-index: 1;
}

.hero-content {
    position: relative;
    z-index: 2;
}

.hero h1 {
    font-family: 'Playfair Display', serif;
    font-size: 3rem;
    margin-bottom: 12px;
    color: #F0E6D1;
}

.hero p {
    color: #E4D6B8;
    font-size: 1rem;
}

/* ── Grid ── */
.grid {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
    gap: 25px;
    padding: 40px 50px 60px;
    max-width: 1400px;
    margin: auto;
}

/* ── Card ── */
.card {
    background: #1A130E;
    border: 1px solid #2E1F14;
    border-radius: 6px;
    overflow: hidden;
    transition: transform 0.3s, box-shadow 0.3s;
    text-decoration: none;
    color: #F0E6D1;
    display: block;
}

.card:hover {
    transform: translateY(-6px);
    box-shadow: 0 12px 30px rgba(0,0,0,0.5);
}

.card img {
    width: 100%;
    height: 210px;
    object-fit: cover;
}

.card-body {
    padding: 22px;
}

.card-body h2 {
    font-family: 'Playfair Display', serif;
    font-size: 1.4rem;
    margin-bottom: 16px;
    color: #F0E6D1;
}

.detail {
    margin-bottom: 10px;
    font-size: 0.9rem;
    color: #A89574;
}

.detail strong {
    display: block;
    font-size: 0.75rem;
    letter-spacing: 0.15em;
    text-transform: uppercase;
    color: #F0E6D1;
    margin-bottom: 2px;
}

.rating {
    color: #D17A2C;
    font-weight: 600;
}

.divider {
    border: none;
    border-top: 1px solid #2E1F14;
    margin: 16px 0;
}

/* ── Badge ── */
.badge {
    display: inline-block;
    padding: 4px 12px;
    border-radius: 20px;
    font-size: 0.8rem;
    font-weight: 600;
}

.badge-active {
    background: rgba(34, 197, 94, 0.15);
    color: #22c55e;
    border: 1px solid #22c55e;
}

.badge-inactive {
    background: rgba(239, 68, 68, 0.15);
    color: #ef4444;
    border: 1px solid #ef4444;
}

/* ── Button ── */
.btn {
    display: block;
    width: 100%;
    padding: 13px;
    background: #D17A2C;
    color: #F0E6D1;
    border: none;
    border-radius: 4px;
    text-align: center;
    font-family: 'Lora', serif;
    font-size: 0.95rem;
    font-weight: 600;
    margin-top: 18px;
    transition: 0.3s;
    cursor: pointer;
}

.btn:hover {
    opacity: 0.9;
    transform: translateY(-2px);
}

/* ── Empty ── */
.empty {
    text-align: center;
    padding: 80px;
    color: #A89574;
    grid-column: 1 / -1;
}

/* ── Mobile ── */
@media(max-width: 768px) {
    .navbar {
        padding: 16px 20px;
        flex-direction: column;
        gap: 15px;
    }

    .hero { padding: 70px 20px 50px; }
    .hero h1 { font-size: 2rem; }
    .grid { padding: 20px; }
}




</style>
</head>
<body>

<!-- ── Navbar ── -->
<nav class="navbar">
    <a href="restaurants" class="brand">tomor</a>
    <div class="nav-links">
        <a href="restaurants">Restaurants</a>
        <a href="login.html">Login</a>
        <a href="index.html">Register</a>
      
            <a href="login.html">Logout</a>
        
    </div>
</nav>

<!-- ── Hero ── -->
<div class="hero">
    <video class="hero-video" autoplay muted loop playsinline>
        <source src="8094295-hd_1920_1080_25fps.mp4" type="video/mp4">
    </video>
    <div class="hero-overlay"></div>

    <div class="hero-content">
        <h1>Explore Restaurants</h1>
        <p>Discover the best food & drinks in your city.</p>
    </div>
</div>

<!-- ── Cards ── -->
<div class="grid">

<%
    List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");

    if (restaurants != null && !restaurants.isEmpty()) {
        for (Restaurant r : restaurants) {
%>

<a href="MenuItem?restaurantId=<%= r.getRestaurantId() %>" class="card">

    <img src='<%= r.getImage() != null && !r.getImage().isEmpty()
               ? r.getImage()
               : "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=400" %>'
         alt="<%= r.getName() %>">

    <div class="card-body">

        <h2><%= r.getName() %></h2>

        <div class="detail">
            <strong>📍 Address</strong>
            <%= r.getAddress() %>
        </div>

        <div class="detail">
            <strong>⏱ Delivery Time</strong>
            <%= r.getDeliveryTime() %> mins
        </div>

        <div class="detail">
            <strong>⭐ Rating</strong>
            <span class="rating"><%= r.getRating() %></span>
        </div>

        <hr class="divider">

        <div class="detail">
            <strong>Status</strong>
            <span class='badge <%= r.isActive() ? "badge-active" : "badge-inactive" %>'>
                <%= r.isActive() ? "● Open" : "● Closed" %>
            </span>
        </div>

        <div class="btn">View Menu →</div>

    </div>
</a>

<%
        }
    } else {
%>
    <div class="empty">
        <p>No restaurants found.</p>
    </div>
<%
    }
%>

</div>
</body>
</html>
