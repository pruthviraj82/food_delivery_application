<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.pru.model.MenuItem" %>
<%@ page import="com.pru.model.Restaurant" %>
<%@ page import="java.util.List" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Tomor - Manage Menu</title>

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

.hero p { color: #A89574; font-size: 1rem; }

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

.back-link {
    color: #A89574;
    text-decoration: none;
    font-size: 0.95rem;
    display: inline-flex;
    align-items: center;
    gap: 6px;
    margin-bottom: 30px;
    transition: color 0.3s;
}

.back-link:hover { color: #D17A2C; }

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
.form-group textarea {
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
.form-group textarea:focus { border-color: #D17A2C; }

.form-group textarea {
    resize: vertical;
    min-height: 80px;
}

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

/* ── Menu Grid ── */
.menu-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
    gap: 25px;
}

.menu-card {
    background: #1A130E;
    border: 1px solid #2E1F14;
    border-radius: 8px;
    overflow: hidden;
    transition: border-color 0.3s;
}

.menu-card:hover { border-color: #D17A2C; }

.card-image {
    width: 100%;
    height: 160px;
    object-fit: cover;
    display: block;
}

.card-image-placeholder {
    width: 100%;
    height: 160px;
    background: #0F0B08;
    display: flex;
    align-items: center;
    justify-content: center;
    color: #A89574;
    font-size: 0.9rem;
}

.card-body { padding: 18px; }

.card-name {
    font-family: 'Playfair Display', serif;
    font-size: 1.2rem;
    margin-bottom: 6px;
}

.card-description {
    color: #A89574;
    font-size: 0.85rem;
    margin-bottom: 12px;
    line-height: 1.5;
}

.card-price {
    color: #D17A2C;
    font-size: 1.2rem;
    font-weight: 700;
    margin-bottom: 15px;
}

.card-actions {
    display: flex;
    gap: 8px;
    padding-top: 15px;
    border-top: 1px solid #2E1F14;
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
    .menu-grid { grid-template-columns: 1fr; }
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

<%
    Restaurant restaurant = (Restaurant) request.getAttribute("restaurant");
    List<MenuItem> menuItems = (List<MenuItem>) request.getAttribute("menuItems");
    int restaurantId = restaurant != null ? restaurant.getRestaurantId() : 0;
%>

<!-- ── Hero ── -->
<div class="hero">
    <h1><%= restaurant != null ? restaurant.getName() : "Menu" %></h1>
    <p>Manage menu items for this restaurant</p>
</div>

<div class="container">

    <!-- ── Back Link ── -->
    <a href="adminDashboard" class="back-link">← Back to Dashboard</a>

    <!-- ── Section Header ── -->
    <div class="section-header">
        <h2>Menu Items</h2>
        <button class="btn btn-primary" onclick="toggleAddForm()">+ Add Item</button>
    </div>

    <!-- ── ADD Form ── -->
    <div class="add-form" id="addForm">
        <h3>Add New Menu Item</h3>
        <form action="adminMenu" >
            <input type="hidden" name="action" value="add">
            <input type="hidden" name="restaurantId" value="<%= restaurantId %>">
            <div class="form-grid">
                <div class="form-group">
                    <label>Item Name *</label>
                    <input type="text" name="name" required>
                </div>
                <div class="form-group">
                    <label>Price (₹) *</label>
                    <input type="number" name="price" step="0.01" min="0" required>
                </div>
                <div class="form-group form-full">
                    <label>Description</label>
                    <textarea name="description" placeholder="Describe the item..."></textarea>
                </div>
                <div class="form-group form-full">
                    <label>Image URL</label>
                    <input type="text" name="image" placeholder="https://...">
                </div>
            </div>
            <div class="form-actions">
                <button type="button" class="btn btn-secondary" onclick="toggleAddForm()">Cancel</button>
                <button type="submit" class="btn btn-primary">Add Item</button>
            </div>
        </form>
    </div>

    <!-- ── EDIT Form ── -->
    <div class="edit-form" id="editForm">
        <h3>Edit Menu Item</h3>
        <form action="adminMenu" >
            <input type="hidden" name="action" value="update">
            <input type="hidden" name="restaurantId" value="<%= restaurantId %>">
            <input type="hidden" name="itemId" id="editItemId">
            <div class="form-grid">
                <div class="form-group">
                    <label>Item Name *</label>
                    <input type="text" name="name" id="editName" required>
                </div>
                <div class="form-group">
                    <label>Price (₹) *</label>
                    <input type="number" name="price" id="editPrice" step="0.01" min="0" required>
                </div>
                <div class="form-group form-full">
                    <label>Description</label>
                    <textarea name="description" id="editDescription"></textarea>
                </div>
                <div class="form-group form-full">
                    <label>Image URL</label>
                    <input type="text" name="image" id="editImage" placeholder="https://...">
                </div>
            </div>
            <div class="form-actions">
                <button type="button" class="btn btn-secondary" onclick="closeEditForm()">Cancel</button>
                <button type="submit" class="btn btn-primary">Update Item</button>
            </div>
        </form>
    </div>

    <!-- ── Menu Items Grid ── -->
    <%
        if (menuItems == null || menuItems.isEmpty()) {
    %>
        <div class="empty">
            <h3>No menu items found</h3>
            <p>Click "Add Item" to add your first menu item.</p>
        </div>
    <%
        } else {
    %>
    <div class="menu-grid">
        <%
            for (MenuItem item : menuItems) {
        %>
        <div class="menu-card">

            <% if (item.getImage() != null && !item.getImage().isEmpty()) { %>
                <img class="card-image" src="<%= item.getImage() %>" alt="<%= item.getName() %>">
            <% } else { %>
                <div class="card-image-placeholder">No Image</div>
            <% } %>

            <div class="card-body">
                <div class="card-name"><%= item.getName() %></div>
                <div class="card-description">
                    <%= item.getDescription() != null ? item.getDescription() : "" %>
                </div>
                <div class="card-price">₹<%= item.getPrice() %></div>

                <div class="card-actions">

                    <!-- ── Edit ── -->
                    <button class="btn btn-edit" style="flex:1;" onclick="openEditForm(
                        '<%= item.getItemId() %>',
                        '<%= item.getName().replace("'", "\\'") %>',
                        '<%= item.getPrice() %>',
                        '<%= item.getDescription() != null ? item.getDescription().replace("'", "\\'") : "" %>',
                        '<%= item.getImage() != null ? item.getImage().replace("'", "\\'") : "" %>'
                    )">Edit</button>

                    <!-- ── Delete ── -->
                    <form action="adminMenu"  style="flex:1;"
                          onsubmit="return confirm('Delete <%= item.getName().replace("'", "\\'") %>?')">
                        <input type="hidden" name="action" value="delete">
                        <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                        <input type="hidden" name="restaurantId" value="<%= restaurantId %>">
                        <button type="submit" class="btn btn-danger" style="width:100%;">Delete</button>
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
    const addForm  = document.getElementById('addForm');
    const editForm = document.getElementById('editForm');
    editForm.classList.remove('show');
    addForm.classList.toggle('show');
    addForm.scrollIntoView({ behavior: 'smooth' });
}

// ── Open Edit Form with existing data ──
function openEditForm(itemId, name, price, description, image) {
    const addForm  = document.getElementById('addForm');
    const editForm = document.getElementById('editForm');

    addForm.classList.remove('show');

    document.getElementById('editItemId').value     = itemId;
    document.getElementById('editName').value        = name;
    document.getElementById('editPrice').value       = price;
    document.getElementById('editDescription').value = description;
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