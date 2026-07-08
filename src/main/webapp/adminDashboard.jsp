<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pru.model.Restaurant" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Tomor - Admin Dashboard</title>

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

.nav-right {
    display: flex;
    align-items: center;
    gap: 20px;
}

.admin-badge {
    background: #D17A2C;
    color: #0F0B08;
    padding: 4px 12px;
    border-radius: 4px;
    font-size: 0.8rem;
    font-weight: 700;
    letter-spacing: 1px;
    text-transform: uppercase;
}

.nav-links a {
    color: #A89574;
    text-decoration: none;
    font-size: 0.95rem;
    transition: color 0.3s;
}

.nav-links a:hover { color: #D17A2C; }

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

.hero p { color: #A89574; }

.container {
    max-width: 1200px;
    margin: 40px auto;
    padding: 0 20px 80px;
}

.section-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-bottom: 30px;
}

.section-header h2 {
    font-family: 'Playfair Display', serif;
    font-size: 1.8rem;
}

/* ── Forms ── */
.add-form, .edit-form {
    background: #1A130E;
    border: 1px solid #2E1F14;
    border-radius: 8px;
    padding: 30px;
    margin-bottom: 40px;
    display: none;
}

.add-form.show, .edit-form.show { display: block; }

.add-form h3 {
    font-family: 'Playfair Display', serif;
    font-size: 1.5rem;
    margin-bottom: 25px;
    color: #D17A2C;
}

.edit-form h3 {
    font-family: 'Playfair Display', serif;
    font-size: 1.5rem;
    margin-bottom: 25px;
    color: #A89574;
}

.form-grid {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 20px;
    margin-bottom: 20px;
}

.form-group { display: flex; flex-direction: column; gap: 8px; }

.form-group label {
    font-size: 0.75rem;
    letter-spacing: 0.15em;
    text-transform: uppercase;
    color: #A89574;
}

.form-group input,
.form-group select {
    padding: 11px 14px;
    background: #0F0B08;
    border: 1px solid #2E1F14;
    color: #F0E6D1;
    border-radius: 4px;
    font-family: 'Lora', serif;
    font-size: 0.95rem;
    outline: none;
    transition: border-color 0.3s;
}

.form-group input:focus,
.form-group select:focus { border-color: #D17A2C; }

.form-full { grid-column: 1 / -1; }

.form-actions {
    display: flex;
    gap: 12px;
    justify-content: flex-end;
}

/* ── Buttons ── */
.btn {
    padding: 10px 22px;
    border: none;
    border-radius: 4px;
    cursor: pointer;
    font-family: 'Lora', serif;
    font-size: 0.95rem;
    font-weight: 600;
    transition: 0.3s;
    text-decoration: none;
    display: inline-block;
}

.btn:hover { opacity: 0.9; transform: translateY(-1px); }
.btn-primary   { background: #D17A2C; color: #F0E6D1; }
.btn-danger    { background: #D13232; color: #F0E6D1; }
.btn-secondary { background: #A89574; color: #F0E6D1; }
.btn-edit      { background: #2E6EA6; color: #F0E6D1; }
.btn-outline {
    background: transparent;
    border: 1px solid #D17A2C;
    color: #D17A2C;
}

/* ── Restaurant Grid ── */
.restaurant-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
    gap: 25px;
}

.restaurant-card {
    background: #1A130E;
    border: 1px solid #2E1F14;
    border-radius: 8px;
    overflow: hidden;
    transition: border-color 0.3s;
}

.restaurant-card:hover { border-color: #D17A2C; }

.card-image {
    width: 100%;
    height: 180px;
    object-fit: cover;
    display: block;
}

.card-image-placeholder {
    width: 100%;
    height: 180px;
    background: #0F0B08;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #A89574;
    font-size: 0.9rem;
}

.card-body { padding: 20px; }

.card-name {
    font-family: 'Playfair Display', serif;
    font-size: 1.3rem;
    margin-bottom: 8px;
}

.card-address {
    color: #A89574;
    font-size: 0.88rem;
    margin-bottom: 12px;
}

.card-meta {
    display: flex;
    gap: 15px;
    margin-bottom: 15px;
    font-size: 0.85rem;
}

.meta-item { color: #A89574; }
.meta-item span { color: #D17A2C; font-weight: 600; }

.badge {
    display: inline-block;
    padding: 3px 10px;
    border-radius: 4px;
    font-size: 0.78rem;
    font-weight: 600;
}

.badge-active   { background: rgba(34,197,94,0.15); color: #22c55e; }
.badge-inactive { background: rgba(209,50,50,0.15);  color: #D13232; }

.card-actions {
    display: flex;
    gap: 8px;
    margin-top: 15px;
    padding-top: 15px;
    border-top: 1px solid #2E1F14;
    flex-wrap: wrap;
}

.empty {
    text-align: center;
    padding: 60px 20px;
    color: #A89574;
}

.empty h3 {
    font-family: 'Playfair Display', serif;
    color: #F0E6D1;
    margin-bottom: 10px;
}

@media(max-width: 768px) {
    .navbar { padding: 16px 20px; }
    .hero h1 { font-size: 2rem; }
    .form-grid { grid-template-columns: 1fr; }
    .restaurant-grid { grid-template-columns: 1fr; }
    .section-header { flex-direction: column; gap: 15px; align-items: flex-start; }
}
</style>
</head>
<body>

<!-- ── Navbar ── -->
<nav class="navbar">
    <a href="adminDashboard" class="brand">tomor</a>
    <div class="nav-right">
        <span class="admin-badge">Admin</span>
        <div class="nav-links">
            <a href="login.html">Logout</a>
        </div>
    </div>
</nav>

<!-- ── Hero ── -->
<div class="hero">
    <h1>Admin Dashboard</h1>
    <p>Manage restaurants and menu items</p>
</div>

<div class="container">

    <!-- ── Section Header ── -->
    <div class="section-header">
        <h2>All Restaurants</h2>
        <button class="btn btn-primary" onclick="toggleAddForm()">+ Add Restaurant</button>
    </div>

    <!-- ── ADD Form ── -->
    <div class="add-form" id="addForm">
        <h3>Add New Restaurant</h3>
        <form action="adminRestaurant" >
            <input type="hidden" name="action" value="add">
            <div class="form-grid">
                <div class="form-group">
                    <label>Restaurant Name *</label>
                    <input type="text" name="name" required>
                </div>
                <div class="form-group">
                    <label>Rating (0.0 - 5.0)</label>
                    <input type="number" name="rating" step="0.1" min="0" max="5" value="4.0">
                </div>
                <div class="form-group form-full">
                    <label>Address *</label>
                    <input type="text" name="address" required>
                </div>
                <div class="form-group">
                    <label>Delivery Time (mins)</label>
                    <input type="number" name="deliveryTime" value="30" min="1">
                </div>
                <div class="form-group">
                    <label>Status</label>
                    <select name="isActive">
                        <option value="true">Active (Open)</option>
                        <option value="false">Inactive (Closed)</option>
                    </select>
                </div>
                <div class="form-group form-full">
                    <label>Image URL</label>
                    <input type="text" name="image" placeholder="https://...">
                </div>
            </div>
            <div class="form-actions">
                <button type="button" class="btn btn-secondary" onclick="toggleAddForm()">Cancel</button>
                <button type="submit" class="btn btn-primary">Add Restaurant</button>
            </div>
        </form>
    </div>

    <!-- ── EDIT Form ── -->
    <div class="edit-form" id="editForm">
        <h3>Edit Restaurant</h3>
        <form action="adminRestaurant" >
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="restaurantId" id="editId">
            <div class="form-grid">
                <div class="form-group">
                    <label>Restaurant Name *</label>
                    <input type="text" name="name" id="editName" required>
                </div>
                <div class="form-group">
                    <label>Rating (0.0 - 5.0)</label>
                    <input type="number" name="rating" id="editRating" step="0.1" min="0" max="5">
                </div>
                <div class="form-group form-full">
                    <label>Address *</label>
                    <input type="text" name="address" id="editAddress" required>
                </div>
                <div class="form-group">
                    <label>Delivery Time (mins)</label>
                    <input type="number" name="deliveryTime" id="editDeliveryTime" min="1">
                </div>
                <div class="form-group">
                    <label>Status</label>
                    <select name="isActive" id="editIsActive">
                        <option value="true">Active (Open)</option>
                        <option value="false">Inactive (Closed)</option>
                    </select>
                </div>
                <div class="form-group form-full">
                    <label>Image URL</label>
                    <input type="text" name="image" id="editImage" placeholder="https://...">
                </div>
            </div>
            <div class="form-actions">
                <button type="button" class="btn btn-secondary" onclick="closeEditForm()">Cancel</button>
                <button type="submit" class="btn btn-primary">Update Restaurant</button>
            </div>
        </form>
    </div>

    <!-- ── Restaurant Cards ── -->
    <%
        List<Restaurant> restaurants = (List<Restaurant>) request.getAttribute("restaurants");
        if (restaurants == null || restaurants.isEmpty()) {
    %>
        <div class="empty">
            <h3>No restaurants found</h3>
            <p>Click "Add Restaurant" to get started.</p>
        </div>
    <%
        } else {
    %>
    <div class="restaurant-grid">
        <%
            for (Restaurant r : restaurants) {
        %>
        <div class="restaurant-card">

            <% if (r.getImage() != null && !r.getImage().isEmpty()) { %>
                <img class="card-image" src="<%= r.getImage() %>" alt="<%= r.getName() %>">
            <% } else { %>
                <div class="card-image-placeholder">No Image</div>
            <% } %>

            <div class="card-body">
                <div class="card-name"><%= r.getName() %></div>
                <div class="card-address"><%= r.getAddress() %></div>

                <div class="card-meta">
                    <div class="meta-item">⭐ <span><%= r.getRating() %></span></div>
                    <div class="meta-item">🕐 <span><%= r.getDeliveryTime() %> mins</span></div>
                </div>

                <span class="badge <%= r.isActive() ? "badge-active" : "badge-inactive" %>">
                    <%= r.isActive() ? "● Open" : "● Closed" %>
                </span>

                <div class="card-actions">

                    <!-- ── Manage Menu ── -->
                    <a href="adminMenu?restaurantId=<%= r.getRestaurantId() %>"
                       class="btn btn-outline">Menu</a>

                    <!-- ── Edit ── -->
                    <button class="btn btn-edit" onclick="openEditForm(
                        '<%= r.getRestaurantId() %>',
                        '<%= r.getName().replace("'", "\\'") %>',
                        '<%= r.getAddress().replace("'", "\\'") %>',
                        '<%= r.getRating() %>',
                        '<%= r.getDeliveryTime() %>',
                        '<%= r.isActive() %>',
                        '<%= r.getImage() != null ? r.getImage().replace("'", "\\'") : "" %>'
                    )">Edit</button>

                    <!-- ── Delete ── -->
                    <form action="adminRestaurant" style="display:inline;"
                          onsubmit="return confirm('Delete <%= r.getName().replace("'", "\\'") %>?')">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="restaurantId" value="<%= r.getRestaurantId() %>">
                        <button type="submit" class="btn btn-danger">Delete</button>
                    </form>

                </div>
            </div>
        </div>
        <%
            }
        %>
    </div>
    <%
        }
    %>

</div>

<script>
// ── Toggle Add Form ──
function toggleAddForm() {
    const addForm = document.getElementById('addForm');
    const editForm = document.getElementById('editForm');
    editForm.classList.remove('show');
    addForm.classList.toggle('show');
    addForm.scrollIntoView({ behavior: 'smooth' });
}

// ── Open Edit Form with existing data ──
function openEditForm(id, name, address, rating, deliveryTime, isActive, image) {
    const addForm = document.getElementById('addForm');
    const editForm = document.getElementById('editForm');

    addForm.classList.remove('show');

    document.getElementById('editId').value          = id;
    document.getElementById('editName').value        = name;
    document.getElementById('editAddress').value     = address;
    document.getElementById('editRating').value      = rating;
    document.getElementById('editDeliveryTime').value = deliveryTime;
    document.getElementById('editIsActive').value    = isActive;
    document.getElementById('editImage').value       = image;

    editForm.classList.add('show');
    editForm.scrollIntoView({ behavior: 'smooth' });
}

// ── Close Edit Form ──
function closeEditForm() {
    document.getElementById('editForm').classList.remove('show');
}
</script>

</body>
</html>