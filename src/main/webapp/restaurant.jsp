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

/* ── Mood Suggest ── */
.mood-box { max-width:1400px; margin:30px auto 0; padding:0 50px; }
.mood-panel { background:#1A130E; border:1px solid #2E1F14; border-radius:6px; padding:24px; }
.mood-panel h2 { font-family:'Playfair Display',serif; font-size:1.5rem; margin-bottom:6px; }
.mood-panel p.sub { color:#A89574; font-size:0.9rem; margin-bottom:16px; }
.chips { display:flex; flex-wrap:wrap; gap:10px; margin-bottom:14px; }
.chip { background:#0F0B08; border:1px solid #2E1F14; color:#F0E6D1; padding:8px 16px;
        border-radius:20px; cursor:pointer; font-family:'Lora',serif; font-size:0.9rem; transition:0.2s; }
.chip:hover { border-color:#D17A2C; color:#D17A2C; }
.mood-row { display:flex; gap:10px; }
.mood-row input { flex:1; padding:12px; background:#0F0B08; border:1px solid #2E1F14;
        color:#F0E6D1; border-radius:4px; font-family:'Lora',serif; outline:none; }
.mood-row input:focus { border-color:#D17A2C; }
.mood-row button { padding:12px 24px; background:#D17A2C; color:#F0E6D1; border:none;
        border-radius:4px; cursor:pointer; font-weight:600; font-family:'Lora',serif; }
#moodStatus { color:#A89574; margin-top:14px; font-size:0.9rem; }
#moodResults { display:grid; grid-template-columns:repeat(auto-fill,minmax(240px,1fr)); gap:16px; margin-top:18px; }
.sug-card { background:#0F0B08; border:1px solid #2E1F14; border-radius:6px; overflow:hidden; }
.sug-card img { width:100%; height:130px; object-fit:cover; }
.sug-body { padding:14px; }
.sug-body h3 { font-family:'Playfair Display',serif; font-size:1.05rem; margin-bottom:4px; }
.sug-rest { color:#A89574; font-size:0.8rem; margin-bottom:8px; }
.sug-reason { font-size:0.85rem; font-style:italic; color:#E4D6B8; margin-bottom:10px; }
.sug-price { color:#D17A2C; font-weight:700; margin-bottom:10px; }
.sug-body button { width:100%; padding:9px; background:#D17A2C; color:#F0E6D1; border:none;
        border-radius:4px; cursor:pointer; font-weight:600; font-family:'Lora',serif; }
@media(max-width:768px){ .mood-box{padding:0 20px;} .mood-row{flex-direction:column;} }




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




<div class="mood-box">
  <div class="mood-panel">
    <h2>🍽 What's your mood today?</h2>
    <p class="sub">Tell us how you feel and our AI will pick dishes for you.</p>
    <div class="chips">
      <button class="chip" onclick="askMood('Happy and celebrating')">😄 Happy</button>
      <button class="chip" onclick="askMood('Stressed and need comfort food')">😣 Stressed</button>
      <button class="chip" onclick="askMood('Tired and low energy')">😴 Tired</button>
      <button class="chip" onclick="askMood('Sad and need cheering up')">😢 Sad</button>
      <button class="chip" onclick="askMood('Cold rainy weather')">🌧 Rainy day</button>
      <button class="chip" onclick="askMood('Very hungry, want something heavy')">🤤 Very hungry</button>
    </div>
    <div class="mood-row">
      <input type="text" id="moodInput" maxlength="100" placeholder="Or type your own mood...">
      <button onclick="askMood(document.getElementById('moodInput').value)">Suggest</button>
    </div>
    <div id="moodStatus"></div>
    <div id="moodResults"></div>
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


<script>
function askMood(mood) {
    mood = (mood || '').trim();
    const status = document.getElementById('moodStatus');
    const box = document.getElementById('moodResults');
    if (!mood) { status.textContent = 'Please type or pick a mood.'; return; }

    status.textContent = 'Thinking about the perfect meal for you...';
    box.innerHTML = '';

    fetch('moodSuggest', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'mood=' + encodeURIComponent(mood)
    })
    .then(r => r.json().then(d => ({ ok: r.ok, status: r.status, d })))
    .then(({ ok, status: code, d }) => {
        if (code === 401) { window.location.href = 'login.html'; return; }
        if (!ok) { status.textContent = d.error || 'Something went wrong.'; return; }
        if (!d.suggestions.length) { status.textContent = 'No suggestions found. Try another mood.'; return; }
        status.textContent = 'Here is what we suggest for "' + mood + '":';
        d.suggestions.forEach(s => box.appendChild(buildCard(s)));
    })
    .catch(() => { status.textContent = 'Network error. Please try again.'; });
}

function buildCard(s) {
    const card = document.createElement('div');
    card.className = 'sug-card';

    if (s.image) {
        const img = document.createElement('img');
        img.src = s.image; img.alt = s.name;
        card.appendChild(img);
    }

    const body = document.createElement('div');
    body.className = 'sug-body';

    const h = document.createElement('h3');   h.textContent = s.name;
    const r = document.createElement('div');  r.className = 'sug-rest';   r.textContent = s.restaurantName;
    const why = document.createElement('div'); why.className = 'sug-reason'; why.textContent = s.reason;
    const p = document.createElement('div');  p.className = 'sug-price';  p.textContent = '₹' + s.price;

    // Uses your existing /cart servlet
    const form = document.createElement('form');
    form.action = 'cart';
    [['action','add'],['itemId',s.itemId],['restaurantId',s.restaurantId],['quantity',1]].forEach(([n,v]) => {
        const i = document.createElement('input');
        i.type = 'hidden'; i.name = n; i.value = v;
        form.appendChild(i);
    });
    const btn = document.createElement('button');
    btn.type = 'submit'; btn.textContent = 'Add to Order';
    form.appendChild(btn);

    [h, r, why, p, form].forEach(el => body.appendChild(el));
    card.appendChild(body);
    return card;
}
</script>
</body>
</html>
