<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="java.util.ArrayList" %>
<%@page import="com.vehicle.model.Vehicle" %>
<%@page import="com.vehicle.model.Area" %>
<%@page import="com.vehicle.model.City" %>
<%@page import="com.vehicle.model.State" %>
<%@page import="com.vehicle.model.Zip" %>  

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="ISO-8859-1">
<title>Bikes</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" 
      integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Poppins:wght@500&family=Ubuntu:wght@700&display=swap" rel="stylesheet">

<style>
    body {
        font-family: 'Poppins', sans-serif;
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
    .form-range {
        width: 80%;
    }
    .filters-div {
        margin-left: 20px;
    }
    .vehicle-biked {
        width: 65.5rem;
        margin-top: 2rem;
        border-radius: 10px;
        box-shadow: 5px 5px 5px rgb(60, 81, 85);
    }
    .veh-img {
        width: 500px;
        height: 300px;
        border-radius: 30px;
        margin-left: 10rem;
    }
    .biked-head {
        margin-top: 20px;
    }
    .book-btn {
        margin-left: 25rem;
        margin-bottom: 10px;
    }
    #ganesh {
        font-family: 'Ubuntu', sans-serif;
        font-size: 20px;
        padding-bottom: 20px;
        margin-left: 3rem;
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
    if(session.getAttribute("user_id") == null)
        response.sendRedirect("/Vehicle/login");
  
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
                <li class="nav-item"><a class="nav-link active" href="/Vehicle/dashboard">Dashboard</a></li>
                <li class="nav-item"><a class="nav-link active" href="/Vehicle/car">Buy a Car</a></li>
                <li class="nav-item"><a class="nav-link active act-cust" href="/Vehicle/bike">Buy a Bike</a></li>
                <li class="nav-item"><a class="nav-link active" href="/Vehicle/sell">Sell your vehicle</a></li>
                <li class="nav-item"><a class="nav-link active" href="/Vehicle/orders">My Orders</a></li>
                <li class="nav-item"><a class="nav-link active nav-name"><%= name %></a></li>
            </ul>
            <a href="/Vehicle/logout"><button class="btn btn-danger logout">Logout</button></a>
        </div>
    </div>
</nav>

<div class="container-fluid">
    <div class="row">
        <!-- Filters Column -->
        <div class="col-md-3">
            <div class="filters-div">
                <h3 style="margin-top: 2rem;">Filters</h3>
                <p>Filter By Price</p>
                <form action="/Vehicle/filterpricebike" method="POST">
                    <label for="customRange2" class="form-label">Select Price Range</label>
                    <input name="price_range" type="range" class="form-range" min="10000" max="1000000" 
                           step="5000" value="200000" id="customRange2" onChange="this.form.submit()">
                    <p>Rs 10K <span style="margin-left: 9rem;">Rs 10 Lakh</span></p>
                </form>
                
                <form action="/Vehicle/filterareabike" method="POST">
                    <p style="margin-top: 30px;">Filter By Area</p>
                   
                    <% 
                    @SuppressWarnings("unchecked")
                    ArrayList<Area> areaList = (ArrayList<Area>)request.getAttribute("areaList"); 
                    if(areaList != null && !areaList.isEmpty()) { 
                        for(int i=0; i<areaList.size(); i++){ 
                            Area area = (Area)areaList.get(i); 
                    %>
                        <div class="form-check">
                            <input name="area" class="form-check-input" type="checkbox" 
                                   value="<%= area.getName() %>" id="areaCheck<%= i %>" onChange="this.form.submit()">
                            <label class="form-check-label" for="areaCheck<%= i %>">
                                <%= area.getName() %>
                            </label>
                        </div>
                    <% 
                        } 
                    } 
                    %>
                </form>
                
                <form action="/Vehicle/filtercitybike" method="POST">
                    <p style="margin-top: 30px;">Filter By City</p>
                    <% @SuppressWarnings("unchecked")
                   ArrayList<City> cityList = (ArrayList<City>) request.getAttribute("cityList");
                        if(cityList != null && !cityList.isEmpty()) { 
                            for(int i=0; i<cityList.size(); i++){ 
                                City city = (City)cityList.get(i); 
                    %>
                        <div class="form-check">
                            <input name="city" class="form-check-input" type="checkbox" 
                                   value="<%= city.getCity() %>" id="cityCheck<%= i %>" onChange="this.form.submit()">
                            <label class="form-check-label" for="cityCheck<%= i %>">
                                <%= city.getCity() %>
                            </label>
                        </div>
                    <% 
                            } 
                        } 
                    %>
                </form>
                
                <form action="/Vehicle/filterstatebike" method="POST">
                    <p style="margin-top: 30px;">Filter By State</p>
                    <% 
                    @SuppressWarnings("unchecked")
                        ArrayList<State> stateList = (ArrayList<State>)request.getAttribute("stateList"); 
                        if(stateList != null && !stateList.isEmpty()) { 
                            for(int i=0; i<stateList.size(); i++){ 
                                State state = (State)stateList.get(i); 
                    %>
                        <div class="form-check">
                            <input name="state" class="form-check-input" type="checkbox" 
                                   value="<%= state.getState() %>" id="stateCheck<%= i %>" onChange="this.form.submit()">
                            <label class="form-check-label" for="stateCheck<%= i %>">
                                <%= state.getState() %>
                            </label>
                        </div>
                    <% 
                            } 
                        } 
                    %>
                </form>
                
                <form action="/Vehicle/filterzipbike" method="POST">
                    <p style="margin-top: 30px;">Filter By Zip</p>
                    <% 
                    @SuppressWarnings("unchecked")
                        ArrayList<Zip> zipList = (ArrayList<Zip>)request.getAttribute("zipList"); 
                        if(zipList != null && !zipList.isEmpty()) { 
                            for(int i=0; i<zipList.size(); i++){ 
                                Zip zip = (Zip)zipList.get(i); 
                    %>
                        <div class="form-check">
                            <input name="zip" class="form-check-input" type="checkbox" 
                                   value="<%= zip.getZip() %>" id="zipCheck<%= i %>" onChange="this.form.submit()">
                            <label class="form-check-label" for="zipCheck<%= i %>">
                                <%= zip.getZip() %>
                            </label>
                        </div>
                    <% 
                            } 
                        } 
                    %>
                </form>
            </div>
        </div>
        
        <!-- Bikes Listing Column -->
        <div class="col-md-9">
            <% 
            @SuppressWarnings("unchecked")
            ArrayList<Vehicle> bikeList = (ArrayList<Vehicle>) request.getAttribute("bikeList");
                if(bikeList != null) {
            %>
            <h2 class="biked-head">Available bikes <%= bikeList.size() %></h2>
            <% if(!bikeList.isEmpty()) { %>
                <% for(int i=0; i < bikeList.size(); i++) { 
                    Vehicle bike = bikeList.get(i); 
                %>
                <div class="biked vehicle-biked">
                    <div class="biked-body">
                        <div class="row">
                            <div class="col-md-12">
                                <img class="veh-img" src="<%= bike.getImage() %>" alt="Image of <%= bike.getModel() %>">
                            </div>
                        </div>
                        
                        <table class="table table-hover table-borderless">
                            <thead>
                                <tr>
                                    <th>Vehicle_id</th>
                                    <th>Type</th>
                                    <th>Model</th>
                                    <th>Color</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><%= bike.getV_id() %></td>
                                    <td><%= bike.getType() %></td>
                                    <td><%= bike.getModel() %></td>
                                    <td><%= bike.getColor() %></td>
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
                                    <td><%= bike.getReg_date() %></td>
                                    <td><%= bike.getPrice() %></td>
                                    <td><%= bike.getArea() %></td>
                                    <td><%= bike.getCity() %></td>
                                </tr>
                            </tbody>
                        </table>
                        
                        <table class="table table-hover table-borderless">
                            <thead>
                                <tr>
                                    <th>State</th>
                                    <th>Zip</th>
                                    <th>Owner_id</th>
                                    <th>Fuel_type</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <td><%= bike.getState() %></td>
                                    <td><%= bike.getZip() %></td>
                                    <td><%= bike.getOwner_id() %></td>
                                    <td><%= bike.getFuel_type() %></td>
                                </tr>
                            </tbody>
                        </table>
                        
                        <table class="table table-hover table-borderless">
                            <thead>
                                <tr><th>Gear</th></tr>
                            </thead>
                            <tbody>
                                <tr><td><%= bike.getGear() %></td></tr>
                            </tbody>
                        </table>
                        
                        <div class="row">
                            <div class="col-md-12">
                                <form action="/Vehicle/book" method="POST">
                                    <input type="hidden" name="owner_id" value="<%= bike.getOwner_id() %>">
                                    <button type="submit" class="btn btn-dark book-btn" name="v_id" value="<%= bike.getV_id() %>">Book Vehicle</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
                <% } %>
            <% } else { %>
                <p>No bikes available matching the selected filters.</p>
            <% } } else { %>
                <p>Bike list is not available.</p>
            <% } %>
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