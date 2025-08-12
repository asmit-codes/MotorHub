<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.ArrayList" %>
<%@page import="com.vehicle.model.Vehicle" %>
<%@page import="com.vehicle.model.Area" %>
<%@page import="com.vehicle.model.City" %>
<%@page import="com.vehicle.model.State" %>
<%@page import="com.vehicle.model.Zip" %>  
<%@page import="com.vehicle.model.Booking" %>
<%@page import="com.vehicle.model.Vehicle" %>


<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>My Orders</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" 
      integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">

<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500&family=Ubuntu:wght@700&display=swap" rel="stylesheet">

<style>
    body {
        font-family: 'Poppins', sans-serif;
        /* background-color: #EEEEEE; */
    }
    .navbar {
        background-color: #00ADB5 !important;
    }
    .logout {
        color: white;
        margin-right: 5rem;
    }
    .navbar-brand {
        margin-left: 5rem !important;
        font-family: 'Poppins', sans-serif !important;
        font-size: 2.5rem !important;
    }
    .act-cust {
        color: #D6E4F0 !important;
        border-bottom: 4px solid white !important;
    }
    .nav-item {
        font-family: 'Poppins', sans-serif !important;
        font-size: 1.2rem;
        margin-left: 1rem;
    }
    .nav-name {
        color: #F8F3D4 !important;
    }
    .vehicle-vehicled {
        width: 65.5rem;
        margin-top: 2rem;
        border-radius: 10px;
        box-shadow: 5px 5px 5px rgb(60, 81, 85);
        margin-left: 15rem;
        margin-bottom: 2rem;
    }
    .veh-img {
        width: 500px;
        height: 300px;
        border-radius: 26px;
        margin-left: 10rem;
        object-fit: cover;
    }
    .vehicled-head {
        margin-top: 20px;
        margin-left: 15rem;
    }
    .book-btn {
        margin-left: 30rem;
        margin-bottom: 1rem;
    }
    .cancel-btn {
        margin-left: 30rem;
        margin-bottom: 1rem;
        background-color: #dc3545;
        border-color: #dc3545;
    }
    .cancel-btn:hover {
        background-color: #bb2d3b;
        border-color: #bb2d3b;
    }
    table.table {
        margin-top: 20px;
    }
    /* Footer Section */
    #ganesh {
        font-family: 'Ubuntu', sans-serif;
        font-size: 20px;
        padding-bottom: 20px;
        margin-left: 3rem;
    }
    .fth {
        margin-top: 70px;
    }
    .footer {
        position: absolute;
        margin-top: 2rem;
    }
    .footer-item {
        padding-top: 10px;
        margin-left: 550px;
    }
    .social-icon {
        color: #000;
        margin-left: 50px;
        font-size: 30px;
        padding-bottom: 20px;
    }
    #copyright {
        font-family: 'Ubuntu', sans-serif;
        font-size: 16px;
        margin-left: 80px;
    }
</style>

</head>
<body>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    if(session.getAttribute("user_id") == null) {
        response.sendRedirect("/Vehicle/login");
        return;
    }
    session = request.getSession();
    String name = (String)session.getAttribute("name");
%>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
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
                <li class="nav-item"><a class="nav-link" href="/Vehicle/sell">Sell your vehicle</a></li>
                <li class="nav-item"><a class="nav-link act-cust" href="/Vehicle/orders">My Orders</a></li>
                <li class="nav-item"><a class="nav-link nav-name"><%= name %></a></li>
            </ul>
            <a href="/Vehicle/logout"><button class="btn btn-danger logout" type="button">Logout</button></a>
        </div>
    </div>
</nav>

<div class="vehicled">
    <div class="vehicled-body">
        <div class="row">
            <div class="col-md-9">
                <% @SuppressWarnings("unchecked") 
                    ArrayList<Booking> bookingList = (ArrayList<Booking>)request.getAttribute("bookingList");
                @SuppressWarnings("unchecked") ArrayList<Vehicle> vehicleList = (ArrayList<Vehicle>)request.getAttribute("vehicleList");
                %>
                <h2 class="vehicled-head">Your Orders (<%= bookingList != null ? bookingList.size() : 0 %>)</h2>

                <% if (bookingList != null && !bookingList.isEmpty()) { %>
                    <% for (int i = 0; i < bookingList.size(); i++) { 
                        Booking booking = bookingList.get(i);
                        Vehicle vehicle = vehicleList.get(i);
                    %>
                    <div class="vehicled vehicle-vehicled">
                        <div class="vehicled-body">
                            <div class="row">
                                <div class="col-md-12">
                                    <img class="veh-img" src="<%= vehicle.getImage() %>" alt="Vehicle Image">
                                </div>
                            </div>
                            
                            <table class="table table-hover table-borderless">
                                <thead>
                                    <tr>
                                        <th>Booking ID</th>
                                        <th>Date</th>
                                        <th>User ID</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><%= booking.getBooking_id() %></td>
                                        <td><%= booking.getDate() %></td>
                                        <td><%= booking.getUser_id() %></td>
                                    </tr>
                                </tbody>
                            </table>
                            
                            <table class="table table-hover table-borderless">
                                <thead>
                                    <tr>
                                        <th>Vehicle ID</th>
                                        <th>Type</th>
                                        <th>Model</th>
                                        <th>Color</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><%= vehicle.getV_id() %></td>
                                        <td><%= vehicle.getType() %></td>
                                        <td><%= vehicle.getModel() %></td>
                                        <td><%= vehicle.getColor() %></td>
                                    </tr>
                                </tbody>
                            </table>

                            <table class="table table-hover table-borderless">
                                <thead>
                                    <tr>
                                        <th>Reg. Date</th>
                                        <th>Price</th>
                                        <th>Area</th>
                                        <th>City</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><%= vehicle.getReg_date() %></td>
                                        <td><%= vehicle.getPrice() %></td>
                                        <td><%= vehicle.getArea() %></td>
                                        <td><%= vehicle.getCity() %></td>
                                    </tr>
                                </tbody>
                            </table>

                            <table class="table table-hover table-borderless">
                                <thead>
                                    <tr>
                                        <th>State</th>
                                        <th>Zip</th>
                                        <th>Owner ID</th>
                                        <th>Fuel Type</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <td><%= vehicle.getState() %></td>
                                        <td><%= vehicle.getZip() %></td>
                                        <td><%= vehicle.getOwner_id() %></td>
                                        <td><%= vehicle.getFuel_type() %></td>
                                    </tr>
                                </tbody>
                            </table>

                            <table class="table table-hover table-borderless">
                                <thead>
                                    <tr><th>Gear</th></tr>
                                </thead>
                                <tbody>
                                    <tr><td><%= vehicle.getGear() %></td></tr>
                                </tbody>
                            </table>

                            <div class="row">
                                <div class="col-md-12">
                                    <form action="/Vehicle/orders" method="POST" onsubmit="return confirm('Are you sure you want to cancel this booking?');">
                                        <input type="hidden" name="vehicle_id" value="<%= booking.getVehicle_id() %>">
                                        <button type="submit" class="btn btn-danger cancel-btn" name="booking_id" value="<%= booking.getBooking_id() %>">Cancel</button>
                                    </form>
                                </div>
                            </div>

                        </div>
                    </div>
                    <% } %>
                <% } else { %>
                    <p class="vehicled-head">You have no orders yet.</p>
                <% } %>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="footer">
    <div class="footer-item">
        <h1 id="ganesh">Developed by Ganesh Sindagi</h1>
        <a href="https://www.facebook.com/ganesh.sindagi.3"><i class="social-icon fab fa-facebook-f"></i></a>
        <a href="https://twitter.com/GaneshSindagi"><i class="social-icon fab fa-twitter"></i></a>
        <a href="https://www.instagram.com/ganesh_sindagi/"><i class="social-icon fab fa-instagram"></i></a>
        <a href="mailto:ganeshsindagi7@gmail.com"><i class="social-icon fas fa-envelope"></i></a>
        <p id="copyright">Copyright 2020 MotorHub</p>
    </div>
</footer>

<script src="https://kit.fontawesome.com/b6a0edf9cb.js" crossorigin="anonymous"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" 
    integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>

</body>
</html>
