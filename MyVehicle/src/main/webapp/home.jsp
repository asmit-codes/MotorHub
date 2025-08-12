<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MotorHub - Vehicle Management System</title>
    
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --secondary-gradient: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
            --dark-gradient: linear-gradient(135deg, #2c3e50 0%, #34495e 100%);
            --text-primary: #2c3e50;
            --text-secondary: #7f8c8d;
            --card-shadow: 0 20px 40px rgba(0,0,0,0.1);
        }
        
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }
        
        body, html {
            font-family: 'Poppins', sans-serif;
            background: var(--primary-gradient);
            height: 100vh;
            overflow: hidden; /* Prevents scrolling */
        }
        
        /* Animated Background */
        .bg-animation {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            overflow: hidden;
            z-index: -1;
        }
        
        .bg-animation::before {
            content: '';
            position: absolute;
            top: -50%;
            left: -50%;
            width: 200%;
            height: 200%;
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="2" fill="white" opacity="0.1"/></svg>');
            animation: float 20s ease-in-out infinite;
        }
        
        @keyframes float {
            0%, 100% { transform: translate(0, 0) rotate(0deg); }
            33% { transform: translate(-30px, -30px) rotate(120deg); }
            66% { transform: translate(30px, -30px) rotate(240deg); }
        }
        
        /* Main Container - Fits exactly in viewport */
        .main-container {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1rem;
            position: relative;
        }
        
        /* Compact Hero Card */
        .hero-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 25px;
            padding: 2rem 2.5rem;
            box-shadow: var(--card-shadow);
            border: 1px solid rgba(255, 255, 255, 0.2);
            text-align: center;
            max-width: 550px;
            width: 100%;
            position: relative;
            overflow: hidden;
            transform: translateY(20px);
            opacity: 0;
            animation: slideUp 1s ease forwards;
            max-height: 90vh; /* Ensure it fits in viewport */
        }
        
        @keyframes slideUp {
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }
        
        .hero-card::before {
            content: '';
            position: absolute;
            top: 0;
            left: -100%;
            width: 100%;
            height: 100%;
            background: linear-gradient(90deg, transparent, rgba(255,255,255,0.2), transparent);
            animation: shine 3s ease-in-out infinite;
        }
        
        @keyframes shine {
            0% { left: -100%; }
            100% { left: 100%; }
        }
        
        /* Compact Logo Section */
        .logo-section {
            margin-bottom: 1.5rem;
        }
        
        .logo-icon {
            width: 80px;
            height: 80px;
            background: var(--primary-gradient);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 1rem;
            box-shadow: var(--card-shadow);
            animation: pulse 2s ease-in-out infinite;
        }
        
        @keyframes pulse {
            0%, 100% { transform: scale(1); }
            50% { transform: scale(1.05); }
        }
        
        .logo-icon i {
            font-size: 2rem;
            color: white;
        }
        
        /* Compact Typography */
        .brand-name {
            font-size: 2.5rem;
            font-weight: 700;
            background: var(--primary-gradient);
            background-clip: text;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 0.8rem;
        }
        
        .tagline {
            font-size: 1.1rem;
            color: var(--text-secondary);
            margin-bottom: 0.8rem;
            font-weight: 400;
            line-height: 1.5;
        }
        
        .cta-text {
            font-size: 0.95rem;
            color: var(--text-primary);
            margin-bottom: 1.5rem;
            font-weight: 500;
        }
        
        /* Compact Feature Icons Row */
        .features-row {
            display: flex;
            justify-content: center;
            gap: 1.5rem;
            margin: 1.2rem 0;
        }
        
        .feature-item {
            opacity: 0;
            animation: fadeInUp 1s ease forwards;
        }
        
        .feature-item:nth-child(2) { animation-delay: 0.2s; }
        .feature-item:nth-child(3) { animation-delay: 0.4s; }
        
        @keyframes fadeInUp {
            to { opacity: 1; transform: translateY(0); }
        }
        
        .feature-icon {
            width: 45px;
            height: 45px;
            background: var(--success-gradient);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 0.4rem;
            transition: all 0.3s ease;
        }
        
        .feature-icon:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 15px rgba(0,0,0,0.2);
        }
        
        .feature-icon i {
            color: white;
            font-size: 1.1rem;
        }
        
        .feature-text {
            font-size: 0.8rem;
            color: var(--text-secondary);
            font-weight: 500;
        }
        
        /* Compact Button Styles */
        .btn-group-custom {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-bottom: 1.5rem;
        }
        
        .btn-modern {
            padding: 0.8rem 2rem;
            font-size: 1rem;
            font-weight: 600;
            border-radius: 25px;
            border: none;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            min-width: 130px;
            justify-content: center;
        }
        
        .btn-register {
            background: var(--dark-gradient);
            color: white;
            box-shadow: 0 6px 15px rgba(44, 62, 80, 0.3);
        }
        
        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(44, 62, 80, 0.4);
            color: white;
        }
        
        .btn-login {
            background: var(--success-gradient);
            color: white;
            box-shadow: 0 6px 15px rgba(79, 172, 254, 0.3);
        }
        
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(79, 172, 254, 0.4);
            color: white;
        }
        
        /* Compact Stats Section */
        .stats-section {
            display: flex;
            justify-content: center;
            gap: 2rem;
            padding-top: 1rem;
            border-top: 1px solid rgba(0,0,0,0.1);
        }
        
        .stat-item {
            text-align: center;
            opacity: 0;
            animation: fadeInUp 1s ease forwards;
        }
        
        .stat-item:nth-child(2) { animation-delay: 0.3s; }
        .stat-item:nth-child(3) { animation-delay: 0.6s; }
        
        .stat-number {
            font-size: 1.4rem;
            font-weight: 700;
            background: var(--primary-gradient);
            background-clip: text;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            display: block;
        }
        
        .stat-label {
            font-size: 0.75rem;
            color: var(--text-secondary);
            font-weight: 500;
        }
        
        /* Responsive Design - Single Screen */
        @media (max-width: 768px) {
            .hero-card {
                padding: 1.5rem 1.8rem;
                margin: 0.5rem;
                max-height: 95vh;
            }
            
            .brand-name {
                font-size: 2rem;
            }
            
            .tagline {
                font-size: 1rem;
            }
            
            .btn-group-custom {
                flex-direction: column;
                align-items: center;
                gap: 0.8rem;
            }
            
            .btn-modern {
                width: 100%;
                max-width: 250px;
                padding: 0.7rem 1.5rem;
            }
            
            .features-row,
            .stats-section {
                gap: 1.2rem;
            }
            
            .logo-icon {
                width: 70px;
                height: 70px;
            }
            
            .logo-icon i {
                font-size: 1.8rem;
            }
        }
        
        @media (max-width: 480px) {
            .hero-card {
                padding: 1.2rem 1.4rem;
                max-height: 98vh;
            }
            
            .brand-name {
                font-size: 1.8rem;
            }
            
            .tagline {
                font-size: 0.95rem;
            }
            
            .btn-modern {
                padding: 0.6rem 1.2rem;
                font-size: 0.9rem;
            }
            
            .stats-section {
                gap: 1rem;
            }
            
            .stat-number {
                font-size: 1.2rem;
            }
            
            .stat-label {
                font-size: 0.7rem;
            }
        }
        
        @media (max-height: 600px) {
            .hero-card {
                padding: 1rem 1.5rem;
            }
            
            .brand-name {
                font-size: 2rem;
                margin-bottom: 0.5rem;
            }
            
            .tagline, .cta-text {
                font-size: 0.9rem;
                margin-bottom: 0.8rem;
            }
            
            .features-row {
                margin: 0.8rem 0;
            }
            
            .btn-group-custom {
                margin-bottom: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="bg-animation"></div>
    
    <div class="main-container">
        <div class="hero-card">
            <!-- Logo Section -->
            <div class="logo-section">
                <div class="logo-icon">
                    <i class="fas fa-car"></i>
                </div>
                <h1 class="brand-name">MotorHub</h1>
            </div>
            
            <!-- Main Content -->
            <h2 class="tagline">Fast and Secure Platform to Buy and Sell Cars and Bikes</h2>
            <p class="cta-text">Join thousands of satisfied customers in our trusted marketplace</p>
            
            <!-- Feature Icons -->
            <div class="features-row">
                <div class="feature-item">
                    <div class="feature-icon">
                        <i class="fas fa-shield-alt"></i>
                    </div>
                    <div class="feature-text">Secure</div>
                </div>
                <div class="feature-item">
                    <div class="feature-icon">
                        <i class="fas fa-bolt"></i>
                    </div>
                    <div class="feature-text">Fast</div>
                </div>
                <div class="feature-item">
                    <div class="feature-icon">
                        <i class="fas fa-heart"></i>
                    </div>
                    <div class="feature-text">Trusted</div>
                </div>
            </div>
            
            <!-- Action Buttons -->
            <div class="btn-group-custom">
                <a href="${pageContext.request.contextPath}/register" class="btn-modern btn-register">
                    <i class="fas fa-user-plus"></i>
                    Create Account
                </a>
                <a href="${pageContext.request.contextPath}/login" class="btn-modern btn-login">
                    <i class="fas fa-sign-in-alt"></i>
                    Sign In
                </a>
            </div>
            
            <!-- Stats Section -->
            <div class="stats-section">
                <div class="stat-item">
                    <span class="stat-number">10K+</span>
                    <span class="stat-label">Happy Users</span>
                </div>
                <div class="stat-item">
                    <span class="stat-number">5K+</span>
                    <span class="stat-label">Vehicles</span>
                </div>
                <div class="stat-item">
                    <span class="stat-number">24/7</span>
                    <span class="stat-label">Support</span>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        // Interactive effects
        document.addEventListener('DOMContentLoaded', function() {
            const featureItems = document.querySelectorAll('.feature-item');
            featureItems.forEach((item, index) => {
                item.style.transform = 'translateY(20px)';
                item.style.animationDelay = `${0.5 + index * 0.2}s`;
            });
            
            const buttons = document.querySelectorAll('.btn-modern');
            buttons.forEach(button => {
                button.addEventListener('mouseenter', function() {
                    this.style.transform = 'translateY(-2px) scale(1.02)';
                });
                
                button.addEventListener('mouseleave', function() {
                    this.style.transform = 'translateY(0) scale(1)';
                });
            });
        });
    </script>
</body>
</html>
