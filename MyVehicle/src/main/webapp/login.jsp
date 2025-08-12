<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MotorHub - Sign In</title>
    
    <!-- Bootstrap 5 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome Icons -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    
    <style>
        :root {
            --primary-gradient: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            --success-gradient: linear-gradient(135deg, #4facfe 0%, #00f2fe 100%);
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
            background: url('data:image/svg+xml,<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100"><circle cx="50" cy="50" r="2" fill="white" opacity="0.1"/></svg>');
            animation: float 20s ease-in-out infinite;
            z-index: -1;
        }
        
        @keyframes float {
            0%, 100% { transform: translate(0, 0) rotate(0deg); }
            33% { transform: translate(-30px, -30px) rotate(120deg); }
            66% { transform: translate(30px, -30px) rotate(240deg); }
        }
        
        /* Main Container - Fits exactly in viewport */
        .login-container {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1rem;
            position: relative;
        }
        
        /* Compact Login Card */
        .login-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: var(--card-shadow);
            border: 1px solid rgba(255, 255, 255, 0.2);
            width: 100%;
            max-width: 400px;
            max-height: 90vh; /* Ensure it fits in viewport */
            position: relative;
            overflow: hidden;
            transform: translateY(20px);
            opacity: 0;
            animation: slideUp 1s ease forwards;
        }
        
        @keyframes slideUp {
            to {
                transform: translateY(0);
                opacity: 1;
            }
        }
        
        .login-card::before {
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
        
        /* Compact Header Section */
        .login-header {
            text-align: center;
            margin-bottom: 1.5rem;
        }
        
        /* Clickable Logo Styles */
        .logo-mini-link {
            display: block;
            text-decoration: none;
            transition: all 0.3s ease;
            margin: 0 auto 0.8rem;
            width: fit-content;
        }
        
        .logo-mini-link:hover {
            transform: scale(1.1);
            text-decoration: none;
        }
        
        .logo-mini-link:hover .logo-mini {
            box-shadow: 0 25px 50px rgba(102, 126, 234, 0.4);
            transform: rotate(5deg);
        }
        
        .logo-mini {
            width: 50px;
            height: 50px;
            background: var(--primary-gradient);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0; /* Remove margin, now handled by parent link */
            box-shadow: var(--card-shadow);
            transition: all 0.3s ease;
        }
        
        .logo-mini i {
            font-size: 1.2rem;
            color: white;
        }
        
        .login-title {
            font-size: 1.8rem;
            font-weight: 700;
            background: var(--primary-gradient);
            background-clip: text;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 0.3rem;
        }
        
        .login-subtitle {
            font-size: 0.9rem;
            color: var(--text-secondary);
            font-weight: 400;
        }
        
        /* Compact Form Styles */
        .form-group {
            margin-bottom: 1rem;
            position: relative;
        }
        
        .form-label {
            font-weight: 500;
            color: var(--text-primary);
            margin-bottom: 0.3rem;
            display: flex;
            align-items: center;
            gap: 0.4rem;
            font-size: 0.9rem;
        }
        
        .form-label i {
            color: var(--text-secondary);
            width: 14px;
            font-size: 0.8rem;
        }
        
        .form-control {
            border: 2px solid #e9ecef;
            border-radius: 10px;
            padding: 0.6rem 0.8rem;
            font-size: 0.9rem;
            transition: all 0.3s ease;
            background: rgba(255, 255, 255, 0.8);
        }
        
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
            background: white;
            transform: translateY(-1px);
        }
        
        .form-control:valid {
            border-color: #28a745;
        }
        
        .form-text {
            font-size: 0.75rem;
            color: var(--text-secondary);
            margin-top: 0.2rem;
            display: flex;
            align-items: center;
            gap: 0.3rem;
        }
        
        .form-text i {
            font-size: 0.7rem;
        }
        
        /* Compact Button */
        .btn-login {
            background: var(--success-gradient);
            border: none;
            border-radius: 10px;
            padding: 0.7rem 1.5rem;
            font-size: 1rem;
            font-weight: 600;
            color: white;
            width: 100%;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            margin-top: 0.8rem;
        }
        
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(79, 172, 254, 0.4);
            color: white;
        }
        
        /* Forgot Password Link */
        .forgot-password {
            display: block;
            text-align: right;
            margin-top: 0.8rem;
            font-size: 0.8rem;
            color: var(--text-secondary);
            text-decoration: none;
            transition: all 0.3s ease;
        }
        
        .forgot-password:hover {
            color: #667eea;
            text-decoration: underline;
        }
        
        /* Register Link */
        .register-link {
            text-align: center;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid rgba(0,0,0,0.1);
            font-size: 0.9rem;
        }
        
        .register-link a {
            color: var(--text-primary);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .register-link a:hover {
            color: #667eea;
            text-decoration: underline;
        }
        
        /* Compact Alert Messages */
        .alert {
            border-radius: 10px;
            border: none;
            margin-bottom: 1rem;
            padding: 0.6rem 0.8rem;
            font-size: 0.85rem;
            animation: fadeInDown 0.5s ease;
        }
        
        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }
        
        /* Loading State */
        .btn-login.loading {
            pointer-events: none;
            opacity: 0.7;
        }
        
        .btn-login.loading::after {
            content: '';
            position: absolute;
            width: 16px;
            height: 16px;
            top: 50%;
            left: 50%;
            margin-left: -8px;
            margin-top: -8px;
            border: 2px solid transparent;
            border-top: 2px solid white;
            border-radius: 50%;
            animation: spin 1s linear infinite;
        }
        
        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
        
        /* Success Messages */
        .alert-success {
            background: linear-gradient(135deg, #d4edda 0%, #c3e6cb 100%);
            color: #155724;
        }
        
        /* Error Messages */
        .alert-danger {
            background: linear-gradient(135deg, #f8d7da 0%, #f5c6cb 100%);
            color: #721c24;
        }
        
        /* Responsive Design - Single Screen */
        @media (max-width: 768px) {
            .login-container {
                padding: 0.8rem;
            }
            
            .login-card {
                padding: 1.5rem;
                max-height: 95vh;
            }
            
            .login-title {
                font-size: 1.6rem;
            }
            
            .login-subtitle {
                font-size: 0.85rem;
            }
        }
        
        @media (max-width: 480px) {
            .login-card {
                padding: 1.2rem;
                max-height: 98vh;
            }
            
            .login-title {
                font-size: 1.5rem;
            }
            
            .form-group {
                margin-bottom: 0.8rem;
            }
        }
        
        @media (max-height: 600px) {
            .login-card {
                padding: 1rem;
                max-height: 95vh;
            }
            
            .login-header {
                margin-bottom: 1rem;
            }
            
            .login-title {
                font-size: 1.5rem;
                margin-bottom: 0.2rem;
            }
            
            .login-subtitle {
                font-size: 0.8rem;
            }
            
            .form-group {
                margin-bottom: 0.8rem;
            }
            
            .logo-mini {
                width: 40px;
                height: 40px;
            }
            
            .logo-mini i {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-card">
        
            <!-- Header with Clickable Car Icon -->
            <div class="login-header">
                <a href="<%= request.getContextPath() %>/login" 
						   class="logo-mini-link" 
						   title="MotorHub"
						   data-bs-toggle="tooltip" 
						   data-bs-placement="bottom">
						    <span class="logo-mini">
						        <i class="fas fa-car"></i>
						    </span>
						</a>

                <h2 class="login-title">Welcome Back</h2>
                <p class="login-subtitle">Sign in to your MotorHub account</p>
            </div>
            
            <!-- Enhanced Success/Error Messages handling -->
            <%
            // Get error messages from multiple sources
            String message = (String) request.getAttribute("message");
            String error = (String) request.getAttribute("error");
            String successMsg = request.getParameter("message");
            String loginError = (String) session.getAttribute("loginError");
            String sessionError = (String) session.getAttribute("error");
            
            // Debug logging (remove in production)
            System.out.println("=== LOGIN JSP ERROR CHECK ===");
            System.out.println("request.error: " + error);
            System.out.println("request.message: " + message);
            System.out.println("URL message parameter: " + successMsg);
            System.out.println("session.loginError: " + loginError);
            %>
            
            <!-- Registration Success Message -->
            <% if ("RegistrationSuccess".equals(successMsg)) { %>
                <div class="alert alert-success" role="alert">
                    <i class="fas fa-check-circle me-2"></i>Registration successful! Please login with your credentials.
                </div>
            <% } %>
            
            <!-- Logout Success Message -->
            <% if ("LogoutSuccess".equals(successMsg)) { %>
                <div class="alert alert-success" role="alert">
                    <i class="fas fa-sign-out-alt me-2"></i>You have been successfully logged out. Please login again to continue.
                </div>
            <% } %>
            
            <!-- Request Attribute Errors -->
            <% if (error != null && !error.trim().isEmpty()) { %>
                <div class="alert alert-danger" role="alert">
                    <i class="fas fa-times-circle me-2"></i><%= error %>
                </div>
            <% } %>
            
            <% if (message != null && !message.trim().isEmpty()) { %>
                <div class="alert alert-danger" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i><%= message %>
                </div>
            <% } %>
            
            <!-- Session Attribute Errors (from LoginServlet) -->
            <% if (loginError != null && !loginError.trim().isEmpty()) { %>
                <div class="alert alert-danger" role="alert">
                    <i class="fas fa-user-times me-2"></i><%= loginError %>
                </div>
                <% session.removeAttribute("loginError"); // Clear after displaying %>
            <% } %>
            
            <% if (sessionError != null && !sessionError.trim().isEmpty()) { %>
                <div class="alert alert-danger" role="alert">
                    <i class="fas fa-exclamation-triangle me-2"></i><%= sessionError %>
                </div>
                <% session.removeAttribute("error"); // Clear after displaying %>
            <% } %>
            
            <!-- Login Form -->
            <form action="<%= request.getContextPath() %>/login" method="POST" id="loginForm" novalidate>
                <div class="form-group">
                    <label for="emailInput" class="form-label">
                        <i class="fas fa-envelope"></i>
                        Email Address
                    </label>
                    <input name="email" type="email" id="emailInput" class="form-control" 
                           required placeholder="Enter your email">
                    <div class="form-text">
                        <i class="fas fa-shield-alt"></i>
                        We'll never share your email with anyone else
                    </div>
                </div>
                
                <div class="form-group">
                    <label for="passwordInput" class="form-label">
                        <i class="fas fa-lock"></i>
                        Password
                    </label>
                    <input name="password" type="password" id="passwordInput" class="form-control" 
                           required placeholder="Enter your password" autocomplete="current-password">
                </div>
                
                <button type="submit" class="btn btn-login" id="loginBtn">
                    <i class="fas fa-sign-in-alt me-2"></i>
                    Sign In
                </button>
                
                <a href="<%= request.getContextPath() %>/forgot-password" class="forgot-password">
                    Forgot Password?
                </a>
            </form>
            
            <!-- Register Link -->
            <div class="register-link">
                <p class="mb-0">Don't have an account? 
                    <a href="<%= request.getContextPath() %>/register">
                        Create one here
                    </a>
                </p>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('loginForm');
            const loginBtn = document.getElementById('loginBtn');
            
            // Initialize Bootstrap tooltips
            var tooltipTriggerList = [].slice.call(document.querySelectorAll('[data-bs-toggle="tooltip"]'));
            var tooltipList = tooltipTriggerList.map(function (tooltipTriggerEl) {
                return new bootstrap.Tooltip(tooltipTriggerEl);
            });
            
            // Logo click analytics (optional)
            document.querySelector('.logo-mini-link')?.addEventListener('click', function() {
                console.log('MotorHub logo clicked');
            });
            
            // Form submission with loading state
            form.addEventListener('submit', function(e) {
                loginBtn.classList.add('loading');
                loginBtn.innerHTML = 'Signing In...';
            });
            
            // Real-time validation
            const inputs = form.querySelectorAll('input[required]');
            inputs.forEach(input => {
                input.addEventListener('blur', function() {
                    if (this.checkValidity()) {
                        this.classList.add('is-valid');
                        this.classList.remove('is-invalid');
                    } else {
                        this.classList.add('is-invalid');
                        this.classList.remove('is-valid');
                    }
                });
            });
            
            // Email validation
            const emailInput = document.getElementById('emailInput');
            emailInput.addEventListener('input', function() {
                const email = this.value;
                const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                
                if (emailRegex.test(email)) {
                    this.classList.add('is-valid');
                    this.classList.remove('is-invalid');
                } else if (email.length > 0) {
                    this.classList.add('is-invalid');
                    this.classList.remove('is-valid');
                }
            });
        });
    </script>
</body>
</html>
