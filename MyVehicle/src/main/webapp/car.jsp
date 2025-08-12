<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.util.ArrayList" %>
<%@page import="com.vehicle.model.Vehicle" %>
<%@page import="com.vehicle.model.Area" %>
<%@page import="com.vehicle.model.City" %>
<%@page import="com.vehicle.model.State" %>
<%@page import="com.vehicle.model.Zip" %>  
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MotorHub - Browse Cars</title>
    
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --success-gradient: linear-gradient(135deg, #84fab0 0%, #8fd3f4 100%);
            --warning-gradient: linear-gradient(135deg, #ffecd2 0%, #fcb69f 100%);
            --text-primary: #2c3e50;
            --text-secondary: #7f8c8d;
            --card-shadow: 0 20px 40px rgba(0,0,0,0.1);
            --hover-shadow: 0 30px 60px rgba(0,0,0,0.15);
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body {
            font-family: 'Poppins', sans-serif;
            background: var(--primary-gradient);
            min-height: 100vh;
            position: relative;
        }
        
        /* Animated Background */
        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="2" fill="white" opacity="0.03"/></svg>');
            animation: float 20s ease-in-out infinite;
            z-index: -1;
        }
        
        @keyframes float {
            0%, 100% { transform: translate(0, 0) rotate(0deg); }
            33% { transform: translate(-30px, -30px) rotate(120deg); }
            66% { transform: translate(30px, -30px) rotate(240deg); }
        }
        
        /* Modern Navbar */
        .navbar {
            background: rgba(255, 255, 255, 0.95) !important;
            backdrop-filter: blur(20px);
            box-shadow: 0 8px 32px rgba(0,0,0,0.1);
            border-bottom: 1px solid rgba(255, 255, 255, 0.2);
            padding: 1rem 2rem;
        }
        
        .navbar-brand {
            font-size: 2rem !important;
            font-weight: 700;
            background: var(--primary-gradient);
            background-clip: text;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
        }
        
        .navbar-nav .nav-link {
            color: var(--text-primary) !important;
            font-weight: 500;
            margin: 0 0.5rem;
            padding: 0.5rem 1rem !important;
            border-radius: 10px;
            transition: all 0.3s ease;
        }
        
        .navbar-nav .nav-link:hover,
        .navbar-nav .nav-link.active {
            background: var(--primary-gradient);
            color: white !important;
            transform: translateY(-2px);
        }
        
        .user-info {
            background: var(--secondary-gradient);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 20px;
            font-weight: 600;
        }
        
        .logout-btn {
            background: linear-gradient(135deg, #ff6b6b 0%, #ee5a52 100%);
            border: none;
            color: white;
            padding: 0.5rem 1.5rem;
            border-radius: 20px;
            font-weight: 600;
            transition: all 0.3s ease;
            text-decoration: none;
        }
        
        .logout-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(255, 107, 107, 0.4);
            color: white;
        }
        
        /* Main Content */
        .main-content {
            padding: 2rem 0;
            min-height: calc(100vh - 100px);
        }
        
        /* Filters Section */
        .filters-section {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 1.5rem;
            box-shadow: var(--card-shadow);
            border: 1px solid rgba(255, 255, 255, 0.2);
            margin-bottom: 2rem;
            position: sticky;
            top: 100px;
            max-height: calc(100vh - 120px);
            overflow-y: auto;
        }
        
        .filters-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 1.5rem;
            text-align: center;
        }
        
        .filter-group {
            margin-bottom: 2rem;
            padding-bottom: 1.5rem;
            border-bottom: 1px solid rgba(0,0,0,0.1);
        }
        
        .filter-group:last-child {
            border-bottom: none;
            margin-bottom: 0;
        }
        
        .filter-label {
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 1rem;
            font-size: 1rem;
        }
        
        .form-range {
            background: var(--primary-gradient);
            height: 8px;
            border-radius: 5px;
        }
        
        .form-check {
            margin-bottom: 0.5rem;
        }
        
        .form-check-input:checked {
            background-color: #667eea;
            border-color: #667eea;
        }
        
        .form-check-label {
            font-weight: 500;
            color: var(--text-secondary);
        }
        
        /* Cars Section */
        .cars-section {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 2rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        
        .cars-header {
            color: white;
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 2rem;
            text-align: center;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }
        
        /* Car Cards */
        .car-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 1.5rem;
            margin-bottom: 2rem;
            box-shadow: var(--card-shadow);
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .car-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: all 0.6s ease;
        }
        
        .car-card:hover::before {
            left: 100%;
        }
        
        .car-card:hover {
            transform: translateY(-5px);
            box-shadow: var(--hover-shadow);
        }
        
        .car-image {
            width: 100%;
            height: 250px;
            object-fit: cover;
            border-radius: 15px;
            margin-bottom: 1.5rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.2);
        }
        
        .car-details {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 1.5rem;
        }
        
        .detail-item {
            display: flex;
            flex-direction: column;
            align-items: center;
            text-align: center;
            padding: 1rem;
            background: rgba(255, 255, 255, 0.5);
            border-radius: 10px;
            transition: all 0.3s ease;
        }
        
        .detail-item:hover {
            background: rgba(255, 255, 255, 0.8);
            transform: translateY(-2px);
        }
        
        .detail-label {
            font-size: 0.8rem;
            font-weight: 600;
            color: var(--text-secondary);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 0.5rem;
        }
        
        .detail-value {
            font-size: 1rem;
            font-weight: 600;
            color: var(--text-primary);
        }
        
        .price-highlight {
            color: #e74c3c;
            font-size: 1.2rem;
            font-weight: 700;
        }
        
        /* Book Button */
        .book-btn {
            background: var(--success-gradient);
            border: none;
            color: white;
            padding: 1rem 2rem;
            border-radius: 50px;
            font-weight: 600;
            font-size: 1.1rem;
            width: 100%;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
        }
        
        .book-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 15px 35px rgba(132, 250, 176, 0.4);
            color: white;
        }
        
        .book-btn::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: all 0.6s ease;
        }
        
        .book-btn:hover::before {
            left: 100%;
        }
        
        /* No Cars Message */
        .no-cars {
            text-align: center;
            color: white;
            font-size: 1.2rem;
            margin: 3rem 0;
        }
        
        /* Footer */
        .footer {
            background: rgba(0,0,0,0.8);
            backdrop-filter: blur(20px);
            color: white;
            padding: 2rem 0;
            text-align: center;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
            margin-top: 3rem;
        }
        
        .footer-content {
            max-width: 800px;
            margin: 0 auto;
            padding: 0 2rem;
        }
        
        .footer-title {
            font-size: 1.2rem;
            font-weight: 600;
            margin-bottom: 1rem;
        }
        
        .social-links {
            margin: 1rem 0;
        }
        
        .social-links a {
            color: white;
            font-size: 1.5rem;
            margin: 0 1rem;
            transition: all 0.3s ease;
            text-decoration: none;
        }
        
        .social-links a:hover {
            color: #667eea;
            transform: translateY(-2px);
        }
        
        .copyright {
            margin-top: 1rem;
            opacity: 0.7;
            font-size: 0.9rem;
        }
        
        /* Responsive Design */
        @media (max-width: 768px) {
            .navbar {
                padding: 1rem;
            }
            
            .main-content {
                padding: 1rem 0;
            }
            
            .filters-section {
                position: static;
                margin-bottom: 1rem;
            }
            
            .car-details {
                grid-template-columns: repeat(2, 1fr);
            }
            
            .cars-header {
                font-size: 1.5rem;
            }
        }
        
        @media (max-width: 480px) {
            .car-details {
                grid-template-columns: 1fr;
            }
            
            .detail-item {
                padding: 0.8rem;
            }
        }
    </style>
</head>
<body>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    if(session.getAttribute("user_id") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    
    String username = (String) session.getAttribute("username");
    if (username == null || username.trim().isEmpty()) {
        username = "User";
    }
%>

<!-- Modern Navbar -->
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="<%= request.getContextPath() %>/dashboard">
            <i class="fas fa-car me-2"></i>MotorHub
        </a>
        
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" 
                data-bs-target="#navbarNav" aria-controls="navbarNav" 
                aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/dashboard">
                        <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="<%= request.getContextPath() %>/car">
                        <i class="fas fa-car me-1"></i>Buy Cars
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/bike">
                        <i class="fas fa-motorcycle me-1"></i>Buy Bikes
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/sell">
                        <i class="fas fa-handshake me-1"></i>Sell Vehicle
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/orders">
                        <i class="fas fa-shopping-cart me-1"></i>My Orders
                    </a>
                </li>
            </ul>
            
            <div class="d-flex align-items-center">
                <span class="user-info me-3">
                    <i class="fas fa-user me-1"></i><%= username %>
                </span>
                <a href="<%= request.getContextPath() %>/logout" class="logout-btn">
                    <i class="fas fa-sign-out-alt me-1"></i>Logout
                </a>
            </div>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="main-content">
    <div class="container-fluid">
        <div class="row">
            <!-- Filters Column -->
            <div class="col-lg-3 col-md-4">
                <div class="filters-section">
                    <h3 class="filters-title">
                        <i class="fas fa-filter me-2"></i>Filters
                    </h3>
                    
                    <!-- Price Filter -->
                    <div class="filter-group">
                        <div class="filter-label">
                            <i class="fas fa-rupee-sign me-2"></i>Price Range
                        </div>
                        <form action="<%= request.getContextPath() %>/filterpricecar" method="POST">
                            <input name="price_range" type="range" class="form-range mb-2" 
                                   min="100000" max="10000000" step="50000" value="5000000" 
                                   id="priceRange" onChange="updatePriceLabel(this.value); this.form.submit()">
                            <div class="d-flex justify-content-between">
                                <small>₹1L</small>
                                <small id="currentPrice">₹50L</small>
                                <small>₹1Cr</small>
                            </div>
                        </form>
                    </div>
                    
                    <!-- Area Filter -->
                    <div class="filter-group">
                        <div class="filter-label">
                            <i class="fas fa-map-marker-alt me-2"></i>Area
                        </div>
                        <form action="<%= request.getContextPath() %>/filterareacar" method="POST">
                            <% 
                            @SuppressWarnings("unchecked") 
                            ArrayList<Area> areaList = (ArrayList<Area>)request.getAttribute("areaList"); 
                            if(areaList != null && !areaList.isEmpty()){ 
                                for(Area area : areaList){ 
                            %>
                                <div class="form-check">
                                    <input name="area" class="form-check-input" type="checkbox" 
                                           value="<%= area.getName() %>" id="area_<%= area.getName().hashCode() %>" 
                                           onChange="this.form.submit()">
                                    <label class="form-check-label" for="area_<%= area.getName().hashCode() %>">
                                        <%= area.getName() %>
                                    </label>
                                </div>
                            <% 
                                } 
                            } 
                            %>
                        </form>
                    </div>

                    <!-- City Filter -->
                    <div class="filter-group">
                        <div class="filter-label">
                            <i class="fas fa-city me-2"></i>City
                        </div>
                        <form action="<%= request.getContextPath() %>/filtercitycar" method="POST">
                            <% 
                            @SuppressWarnings("unchecked") 
                            ArrayList<City> cityList = (ArrayList<City>)request.getAttribute("cityList"); 
                            if(cityList != null && !cityList.isEmpty()){ 
                                for(City city : cityList){ 
                            %>
                                <div class="form-check">
                                    <input name="city" class="form-check-input" type="checkbox" 
                                           value="<%= city.getCity() %>" id="city_<%= city.getCity().hashCode() %>" 
                                           onChange="this.form.submit()">
                                    <label class="form-check-label" for="city_<%= city.getCity().hashCode() %>">
                                        <%= city.getCity() %>
                                    </label>
                                </div>
                            <% 
                                } 
                            } 
                            %>
                        </form>
                    </div>

                    <!-- State Filter -->
                    <div class="filter-group">
                        <div class="filter-label">
                            <i class="fas fa-flag me-2"></i>State
                        </div>
                        <form action="<%= request.getContextPath() %>/filterstatecar" method="POST">
                            <% 
                            @SuppressWarnings("unchecked") 
                            ArrayList<State> stateList = (ArrayList<State>)request.getAttribute("stateList"); 
                            if(stateList != null && !stateList.isEmpty()){ 
                                for(State state : stateList){ 
                            %>
                                <div class="form-check">
                                    <input name="state" class="form-check-input" type="checkbox" 
                                           value="<%= state.getState() %>" id="state_<%= state.getState().hashCode() %>" 
                                           onChange="this.form.submit()">
                                    <label class="form-check-label" for="state_<%= state.getState().hashCode() %>">
                                        <%= state.getState() %>
                                    </label>
                                </div>
                            <% 
                                } 
                            } 
                            %>
                        </form>
                    </div>

                    <!-- Zip Filter -->
                    <div class="filter-group">
                        <div class="filter-label">
                            <i class="fas fa-map-pin me-2"></i>Zip Code
                        </div>
                        <form action="<%= request.getContextPath() %>/filterzipcar" method="POST">
                            <% 
                            @SuppressWarnings("unchecked") 
                            ArrayList<Zip> zipList = (ArrayList<Zip>)request.getAttribute("zipList"); 
                            if(zipList != null && !zipList.isEmpty()){ 
                                for(Zip zip : zipList){ 
                            %>
                                <div class="form-check">
                                    <input name="zip" class="form-check-input" type="checkbox" 
                                           value="<%= zip.getZip() %>" id="zip_<%= zip.getZip().hashCode() %>" 
                                           onChange="this.form.submit()">
                                    <label class="form-check-label" for="zip_<%= zip.getZip().hashCode() %>">
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
            </div>

            <!-- Cars List Column -->
            <div class="col-lg-9 col-md-8">
                <div class="cars-section">
                    <% 
                    @SuppressWarnings("unchecked") 
                    ArrayList<Vehicle> carList = (ArrayList<Vehicle>)request.getAttribute("carList"); 
                    int carCount = carList != null ? carList.size() : 0;
                    %>
                    
                    <h2 class="cars-header">
                        <i class="fas fa-car me-2"></i>Available Cars (<%= carCount %>)
                    </h2>

                    <% if(carList != null && !carList.isEmpty()){ %>
                        <% for(Vehicle car : carList){ %>
                            <div class="car-card">
                                <img class="car-image" src="<%= car.getImage() %>" alt="<%= car.getModel() %> Car Image">
                                
                                <div class="car-details">
                                    <div class="detail-item">
                                        <div class="detail-label">Vehicle ID</div>
                                        <div class="detail-value"><%= car.getV_id() %></div>
                                    </div>
                                    <div class="detail-item">
                                        <div class="detail-label">Type</div>
                                        <div class="detail-value"><%= car.getType() %></div>
                                    </div>
                                    <div class="detail-item">
                                        <div class="detail-label">Model</div>
                                        <div class="detail-value"><%= car.getModel() %></div>
                                    </div>
                                    <div class="detail-item">
                                        <div class="detail-label">Color</div>
                                        <div class="detail-value"><%= car.getColor() %></div>
                                    </div>
                                    <div class="detail-item">
                                        <div class="detail-label">Reg. Date</div>
                                        <div class="detail-value"><%= car.getReg_date() %></div>
                                    </div>
                                    <div class="detail-item">
                                        <div class="detail-label">Price</div>
                                        <div class="detail-value price-highlight">₹<%= car.getPrice() %></div>
                                    </div>
                                    <div class="detail-item">
                                        <div class="detail-label">Area</div>
                                        <div class="detail-value"><%= car.getArea() %></div>
                                    </div>
                                    <div class="detail-item">
                                        <div class="detail-label">City</div>
                                        <div class="detail-value"><%= car.getCity() %></div>
                                    </div>
                                    <div class="detail-item">
                                        <div class="detail-label">State</div>
                                        <div class="detail-value"><%= car.getState() %></div>
                                    </div>
                                    <div class="detail-item">
                                        <div class="detail-label">Zip</div>
                                        <div class="detail-value"><%= car.getZip() %></div>
                                    </div>
                                    <div class="detail-item">
                                        <div class="detail-label">Fuel Type</div>
                                        <div class="detail-value"><%= car.getFuel_type() %></div>
                                    </div>
                                    <div class="detail-item">
                                        <div class="detail-label">Gear</div>
                                        <div class="detail-value"><%= car.getGear() %></div>
                                    </div>
                                </div>

                                <form action="<%= request.getContextPath() %>/book" method="POST">
                                    <input type="hidden" name="owner_id" value="<%= car.getOwner_id() %>">
                                    <button type="submit" class="book-btn" name="v_id" value="<%= car.getV_id() %>">
                                        <i class="fas fa-calendar-check me-2"></i>Book This Vehicle
                                    </button>
                                </form>
                            </div>
                        <% } %>
                    <% } else { %>
                        <div class="no-cars">
                            <i class="fas fa-car-crash fa-3x mb-3"></i>
                            <p>No cars available at the moment.</p>
                            <p>Please try adjusting your filters or check back later.</p>
                        </div>
                    <% } %>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="footer">
    <div class="footer-content">
        <h3 class="footer-title">Developed by Ganesh Sindagi</h3>
        <div class="social-links">
            <a href="https://www.facebook.com/ganesh.sindagi.3" target="_blank" rel="noopener" aria-label="Facebook">
                <i class="fab fa-facebook-f"></i>
            </a>
            <a href="https://twitter.com/GaneshSindagi" target="_blank" rel="noopener" aria-label="Twitter">
                <i class="fab fa-twitter"></i>
            </a>
            <a href="https://www.instagram.com/ganesh_sindagi/" target="_blank" rel="noopener" aria-label="Instagram">
                <i class="fab fa-instagram"></i>
            </a>
            <a href="mailto:ganeshsindagi7@gmail.com" aria-label="Email">
                <i class="fas fa-envelope"></i>
            </a>
        </div>
        <p class="copyright">&copy; 2020 MotorHub. All rights reserved.</p>
    </div>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Price range update function
    window.updatePriceLabel = function(value) {
        const priceLabel = document.getElementById('currentPrice');
        const lakh = Math.round(value / 100000);
        if (lakh >= 100) {
            priceLabel.textContent = '₹' + (lakh / 10).toFixed(1) + 'Cr';
        } else {
            priceLabel.textContent = '₹' + lakh + 'L';
        }
    };
    
    // Initialize price label
    const priceRange = document.getElementById('priceRange');
    if (priceRange) {
        updatePriceLabel(priceRange.value);
    }
    
    // Add click analytics for book buttons
    document.querySelectorAll('.book-btn').forEach(button => {
        button.addEventListener('click', function() {
            console.log('Book button clicked for vehicle:', this.value);
        });
    });
    
    // Smooth scrolling for anchor links
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function (e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                target.scrollIntoView({
                    behavior: 'smooth'
                });
            }
        });
    });
});
</script>

</body>
</html>
