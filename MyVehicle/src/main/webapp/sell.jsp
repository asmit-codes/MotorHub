<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.vehicle.model.Vehicle" %>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Sell your Vehicle</title>
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Google Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500&family=Ubuntu:wght@700&display=swap" rel="stylesheet">

<style>
    body {
        font-family: 'Poppins', sans-serif;
        background-color: #f8f9fa;
        margin-bottom: 100px; /* space for footer */
    }
    .navbar {
        background-color: #00ADB5 !important;
    }
    .logout {
        color: white;
        margin-right: 3rem;
    }
    .navbar-brand {
        margin-left: 5rem !important;
        font-size: 2.5rem !important;
        font-family: 'Poppins', sans-serif !important;
    }
    .act-cust {
        color: #D6E4F0!important;
        border-bottom: 4px solid white !important;
    }
    .nav-item {
        font-size: 1.2rem;
        margin-left: 1rem;
        font-family: 'Poppins', sans-serif !important;
    }
    .nav-name {
        color: #F8F3D4 !important;
        font-weight: 600;
    }

    .vehicle-list-container {
        max-width: 1100px;
        margin: 2rem auto;
        padding: 0 1rem;
    }
    .vehicle-card {
        box-shadow: 0 4px 8px rgba(60,81,85,0.2);
        border-radius: 15px;
        margin-bottom: 2rem;
        padding: 1rem;
        background: white;
    }
    .vehicle-img {
        max-width: 100%;
        height: 300px;
        border-radius: 15px;
        object-fit: cover;
    }
    .table th, .table td {
        vertical-align: middle;
    }
    .book-btn {
        margin-top: 1rem;
    }
    .reg-form {
        max-width: 700px;
        margin: 3rem auto 5rem;
        padding: 2rem;
        background: white;
        border-radius: 15px;
        box-shadow: 0 4px 8px rgba(60,81,85,0.2);
    }
    .footer {
        position: fixed;
        bottom: 0;
        width: 100%;
        background: #222831;
        color: white;
        padding: 1rem 0;
        text-align: center;
        font-family: 'Ubuntu', sans-serif;
    }
    .footer a {
        color: white;
        margin: 0 15px;
        font-size: 24px;
        text-decoration: none;
    }
    .footer a:hover {
        color: #00ADB5;
    }
</style>
</head>
<body>

<%
    // Session validation
    session = request.getSession(false);
    if(session == null || session.getAttribute("user_id") == null) {
        response.sendRedirect("/Vehicle/login");
        return;
    }
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    String name = (String) session.getAttribute("name");

    // Retrieve vehicle list from request attribute
      @SuppressWarnings("unchecked")
    ArrayList<Vehicle> vehicleList = (ArrayList<Vehicle>) request.getAttribute("vehicleList");
%>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark">
  <div class="container-fluid">
    <a class="navbar-brand" href="#">MotorHub</a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" 
            data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" 
            aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <ul class="navbar-nav me-auto mb-2 mb-lg-0">
        <li class="nav-item"><a class="nav-link" href="/Vehicle/dashboard">Dashboard</a></li>
        <li class="nav-item"><a class="nav-link" href="/Vehicle/car">Buy a Car</a></li>
        <li class="nav-item"><a class="nav-link" href="/Vehicle/bike">Buy a Bike</a></li>
        <li class="nav-item"><a class="nav-link act-cust" href="/Vehicle/sell">Sell your vehicle</a></li>
        <li class="nav-item"><a class="nav-link" href="/Vehicle/orders">My Orders</a></li>
        <li class="nav-item nav-name"><span><%= name %></span></li>
      </ul>
      <a href="/Vehicle/logout" class="btn btn-danger logout">Logout</a>
    </div>
  </div>
</nav>

<!-- Your Vehicles List -->
<div class="vehicle-list-container">
    <h2>Your Vehicles: <%= (vehicleList != null) ? vehicleList.size() : 0 %></h2>

    <%
        if(vehicleList != null && !vehicleList.isEmpty()) {
            for(Vehicle vehicle : vehicleList) {
    %>
    <div class="vehicle-card row">
        <div class="col-md-5">
            <img class="vehicle-img" src="<%= vehicle.getImage() %>" alt="Vehicle image of <%= vehicle.getModel() %>">
        </div>
        <div class="col-md-7">
            <table class="table table-hover">
                <tbody>
                    <tr>
                        <th>Vehicle ID</th>
                        <td><%= vehicle.getV_id() %></td>
                        <th>Type</th>
                        <td><%= vehicle.getType() %></td>
                    </tr>
                    <tr>
                        <th>Model</th>
                        <td><%= vehicle.getModel() %></td>
                        <th>Color</th>
                        <td><%= vehicle.getColor() %></td>
                    </tr>
                    <tr>
                        <th>Registration Date</th>
                        <td><%= vehicle.getReg_date() %></td>
                        <th>Price</th>
                        <td><%= vehicle.getPrice() %></td>
                    </tr>
                    <tr>
                        <th>Area</th>
                        <td><%= vehicle.getArea() %></td>
                        <th>City</th>
                        <td><%= vehicle.getCity() %></td>
                    </tr>
                    <tr>
                        <th>State</th>
                        <td><%= vehicle.getState() %></td>
                        <th>Zip</th>
                        <td><%= vehicle.getZip() %></td>
                    </tr>
                    <tr>
                        <th>Owner ID</th>
                        <td><%= vehicle.getOwner_id() %></td>
                        <th>Fuel Type</th>
                        <td><%= vehicle.getFuel_type() %></td>
                    </tr>
                    <tr>
                        <th>Gear</th>
                        <td><%= vehicle.getGear() %></td>
                    </tr>
                </tbody>
            </table>

            <form action="/Vehicle/deletevehicle" method="POST">
                <input type="hidden" name="owner_id" value="<%= vehicle.getOwner_id() %>">
                <button type="submit" class="btn btn-danger book-btn" name="v_id" value="<%= vehicle.getV_id() %>">Delete</button>
            </form>
        </div>
    </div>
    <%  
            } // end for
        } else {
    %>
    <p>You have no vehicles registered for sale.</p>
    <% } %>
</div>

<!-- Register Vehicle Form -->
<div class="reg-form">
  <h2>Register your vehicle for sale!</h2>
  <h4>Please fill the details below</h4>
  
  <form action="/Vehicle/sell" method="POST">
    <div class="mb-3">
      <label class="form-label" for="name">Name:</label>
      <input id="name" class="form-control" type="text" name="name" required>
    </div>
    
    <div class="mb-3">
      <label class="form-label" for="address">Address:</label>
      <textarea id="address" name="address" rows="3" class="form-control" required></textarea>
    </div>
    
    <div class="mb-3">
      <label class="form-label" for="phone">Phone:</label>
      <input id="phone" type="tel" name="phone" class="form-control" required>
    </div>
    
    <div class="mb-3">
      <label class="form-label" for="email">Email:</label>
      <input id="email" type="email" name="email" class="form-control" required>
    </div>

    <hr>

    <h5>Your Vehicle Details</h5>
    
    <div class="mb-3">
      <label class="form-label" for="type">Type:</label>
      <select id="type" name="type" class="form-select" required>
        <option value="2">2 Wheeler</option>
        <option value="4">4 Wheeler</option>
      </select>
    </div>

    <div class="mb-3">
      <label class="form-label" for="model">Model:</label>
      <input id="model" type="text" name="model" class="form-control" required>
    </div>

    <div class="mb-3">
      <label class="form-label" for="color">Color:</label>
      <input id="color" type="text" name="color" class="form-control" required>
    </div>

    <div class="mb-3">
      <label class="form-label" for="reg_date">Registration Date:</label>
      <input id="reg_date" type="date" name="reg_date" class="form-control" required>
    </div>

    <div class="mb-3">
      <label class="form-label" for="image">Image URL:</label>
      <input id="image" type="url" name="image" class="form-control" required>
    </div>

    <div class="mb-3">
      <label class="form-label" for="price">Price:</label>
      <input id="price" type="number" step="0.01" name="price" class="form-control" required>
    </div>

    <div class="mb-3">
      <label class="form-label" for="area">Area:</label>
      <input id="area" type="text" name="area" class="form-control" required>
    </div>

    <div class="mb-3">
      <label class="form-label" for="city">City:</label>
      <input id="city" type="text" name="city" class="form-control" required>
    </div>

    <div class="mb-3">
      <label class="form-label" for="state">State:</label>
      <input id="state" type="text" name="state" class="form-control" required>
    </div>

    <div class="mb-3">
      <label class="form-label" for="zip">Zip:</label>
      <input id="zip" type="text" name="zip" class="form-control" required>
    </div>

    <div class="mb-3">
      <label class="form-label" for="fuel_type">Fuel Type:</label>
      <input id="fuel_type" type="text" name="fuel_type" class="form-control" required>
    </div>

    <div class="mb-3">
      <label class="form-label" for="gear">Gear:</label>
      <input id="gear" type="text" name="gear" class="form-control" required>
    </div>

    <button type="submit" class="btn btn-success">Register Vehicle</button>
  </form>
</div>

<!-- Footer -->
<footer class="footer">
  <div>
    <h1 style="font-size: 1.2rem; margin-bottom: 0.5rem;">Developed by Ganesh Sindagi</h1>
    <a href="https://www.facebook.com/ganesh.sindagi.3" target="_blank" rel="noopener" aria-label="Facebook"><i class="fab fa-facebook-f"></i></a>
    <a href="https://twitter.com/GaneshSindagi" target="_blank" rel="noopener" aria-label="Twitter"><i class="fab fa-twitter"></i></a>
    <a href="https://www.instagram.com/ganesh_sindagi/" target="_blank" rel="noopener" aria-label="Instagram"><i class="fab fa-instagram"></i></a>
    <a href="mailto:ganeshsindagi7@gmail.com" aria-label="Email"><i class="fas fa-envelope"></i></a>
    <p>&copy; 2020 MotorHub</p>
  </div>
</footer>

<!-- Font Awesome -->
<script src="https://kit.fontawesome.com/b6a0edf9cb.js" crossorigin="anonymous"></script>

<!-- Bootstrap Bundle JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
