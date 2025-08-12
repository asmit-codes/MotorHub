<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MotorHub - Dashboard</title>
    
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
            overflow-x: hidden;
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
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="2" fill="white" opacity="0.05"/></svg>');
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
            min-height: calc(100vh - 80px);
        }
        
        .welcome-section {
            text-align: center;
            margin-bottom: 3rem;
        }
        
        .welcome-title {
            font-size: 3rem;
            font-weight: 700;
            color: white;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
            margin-bottom: 0.5rem;
        }
        
        .welcome-subtitle {
            font-size: 1.2rem;
            color: rgba(255,255,255,0.9);
            font-weight: 400;
        }
        
        /* Feature Cards */
        .feature-cards {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
            gap: 2rem;
            padding: 0 2rem;
            max-width: 1200px;
            margin: 0 auto;
        }
        
        .feature-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: var(--card-shadow);
            border: 1px solid rgba(255, 255, 255, 0.2);
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            transform: translateY(20px);
            opacity: 0;
            animation: slideUp 0.6s ease forwards;
        }
        
        .feature-card:nth-child(1) { animation-delay: 0.1s; }
        .feature-card:nth-child(2) { animation-delay: 0.3s; }
        .feature-card:nth-child(3) { animation-delay: 0.5s; }
        
        @keyframes slideUp {
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }
        
        .feature-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            transition: all 0.6s ease;
        }
        
        .feature-card:hover::before {
            left: 100%;
        }
        
        .feature-card:hover {
            transform: translateY(-10px);
            box-shadow: var(--hover-shadow);
        }
        
        .card-icon {
            width: 80px;
            height: 80px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1.5rem;
            font-size: 2rem;
            color: white;
            box-shadow: var(--card-shadow);
        }
        
        .cars-card .card-icon {
            background: var(--secondary-gradient);
        }
        
        .bikes-card .card-icon {
            background: var(--success-gradient);
        }
        
        .sell-card .card-icon {
            background: var(--warning-gradient);
            color: #333;
        }
        
        .card-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 1rem;
            text-align: center;
        }
        
        .card-description {
            color: var(--text-secondary);
            text-align: center;
            margin-bottom: 2rem;
            line-height: 1.6;
        }
        
        .card-btn {
            background: var(--primary-gradient);
            border: none;
            color: white;
            padding: 0.8rem 2rem;
            border-radius: 25px;
            font-weight: 600;
            width: 100%;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
            text-align: center;
        }
        
        .cars-card .card-btn {
            background: var(--secondary-gradient);
        }
        
        .bikes-card .card-btn {
            background: var(--success-gradient);
        }
        
        .sell-card .card-btn {
            background: var(--warning-gradient);
            color: #333;
        }
        
        .card-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(0,0,0,0.2);
            color: white;
        }
        
        .sell-card .card-btn:hover {
            color: #333;
        }
        
        /* Stats Section */
        .stats-section {
            margin: 4rem 0;
            padding: 0 2rem;
        }
        
        .stats-container {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 2rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
            max-width: 800px;
            margin: 0 auto;
        }
        
        .stats-title {
            color: white;
            text-align: center;
            font-size: 1.8rem;
            font-weight: 600;
            margin-bottom: 2rem;
        }
        
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(150px, 1fr));
            gap: 2rem;
        }
        
        .stat-item {
            text-align: center;
            color: white;
        }
        
        .stat-number {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 0.5rem;
        }
        
        .stat-label {
            font-size: 0.9rem;
            opacity: 0.8;
        }
        
        /* Footer */
        .footer {
            background: rgba(0,0,0,0.8);
            backdrop-filter: blur(20px);
            color: white;
            padding: 2rem 0;
            text-align: center;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
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
            
            .welcome-title {
                font-size: 2rem;
            }
            
            .feature-cards {
                grid-template-columns: 1fr;
                padding: 0 1rem;
            }
            
            .stats-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        
        @media (max-width: 480px) {
            .welcome-title {
                font-size: 1.8rem;
            }
            
            .feature-card {
                padding: 1.5rem;
            }
        }
    </style>
</head>
<body>

<%
    session = request.getSession(false);
    if (session == null || session.getAttribute("user_id") == null) {
        response.sendRedirect(request.getContextPath() + "/login");
        return;
    }
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    
    // Get user info safely
    String username = (String) session.getAttribute("username");
    String email = (String) session.getAttribute("email");
    Object userIdObj = session.getAttribute("user_id");
    
    // Handle case where username might be null
    if (username == null || username.trim().isEmpty()) {
        username = "User";
    }
%>

<!-- Modern Navbar -->
<nav class="navbar navbar-expand-lg">
    <div class="container">
        <a class="navbar-brand" href="#">
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
                    <a class="nav-link active" href="<%= request.getContextPath() %>/dashboard">
                        <i class="fas fa-tachometer-alt me-1"></i>Dashboard
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="<%= request.getContextPath() %>/car">
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
    <!-- Welcome Section -->
    <div class="welcome-section">
        <h1 class="welcome-title">
            Welcome back, <%= username %>!
        </h1>
        <p class="welcome-subtitle">
            Ready to explore the world of vehicles? Your journey starts here.
        </p>
    </div>
    
    <!-- Feature Cards -->
    <div class="feature-cards">
        <!-- Cars Card -->
        <div class="feature-card cars-card">
            <div class="card-icon">
                <i class="fas fa-car"></i>
            </div>
            <h3 class="card-title">Explore Cars</h3>
            <p class="card-description">
                Discover our extensive collection of premium cars. From luxury sedans to efficient hatchbacks, 
                find your perfect ride today.
            </p>
            <a href="<%= request.getContextPath() %>/car" class="card-btn">
                <i class="fas fa-search me-1"></i>Browse Cars
            </a>
        </div>
        
        <!-- Bikes Card -->
        <div class="feature-card bikes-card">
            <div class="card-icon">
                <i class="fas fa-motorcycle"></i>
            </div>
            <h3 class="card-title">Explore Bikes</h3>
            <p class="card-description">
                From powerful sports bikes to comfortable cruisers, explore our amazing 
                collection of two-wheelers for every adventure.
            </p>
            <a href="<%= request.getContextPath() %>/bike" class="card-btn">
                <i class="fas fa-search me-1"></i>Browse Bikes
            </a>
        </div>
        
        <!-- Sell Card -->
        <div class="feature-card sell-card">
            <div class="card-icon">
                <i class="fas fa-handshake"></i>
            </div>
            <h3 class="card-title">Sell Your Vehicle</h3>
            <p class="card-description">
                Ready to upgrade? List your current vehicle on our platform and 
                connect with genuine buyers in no time.
            </p>
            <a href="<%= request.getContextPath() %>/sell" class="card-btn">
                <i class="fas fa-plus me-1"></i>List Vehicle
            </a>
        </div>
    </div>
    
    <!-- Stats Section -->
    <div class="stats-section">
        <div class="stats-container">
            <h2 class="stats-title">MotorHub at a Glance</h2>
            <div class="stats-grid">
                <div class="stat-item">
                    <div class="stat-number">50K+</div>
                    <div class="stat-label">Happy Customers</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">10K+</div>
                    <div class="stat-label">Vehicles Sold</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">500+</div>
                    <div class="stat-label">Car Models</div>
                </div>
                <div class="stat-item">
                    <div class="stat-number">24/7</div>
                    <div class="stat-label">Customer Support</div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Footer -->
<footer class="footer">
    <div class="footer-content">
        <h3 class="footer-title">Developed by Asmit Kumar</h3>
        <div class="social-links">
            <a href="-" target="_blank" rel="noopener" aria-label="Facebook">
                <i class="fab fa-facebook-f"></i>
            </a>
            <a href="-" target="_blank" rel="noopener" aria-label="Twitter">
                <i class="fab fa-twitter"></i>
            </a>
            <a href="-" target="_blank" rel="noopener" aria-label="Instagram">
                <i class="fab fa-instagram"></i>
            </a>
            <a href="-" aria-label="Email">
                <i class="fas fa-envelope"></i>
            </a>
        </div>
        <p class="copyright">&copy; 2025 MotorHub. All rights reserved.</p>
    </div>
</footer>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Add smooth scrolling
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
    
    // Add click analytics (optional)
    document.querySelectorAll('.card-btn').forEach(button => {
        button.addEventListener('click', function() {
            console.log('Feature card clicked:', this.textContent.trim());
        });
    });
});
</script>

</body>
</html>
