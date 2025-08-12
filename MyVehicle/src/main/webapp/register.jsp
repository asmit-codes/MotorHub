<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MotorHub - Create Account</title>
    
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
        .register-container {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 1rem;
            position: relative;
        }
        
        /* Compact Registration Card */
        .register-card {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(20px);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: var(--card-shadow);
            border: 1px solid rgba(255, 255, 255, 0.2);
            width: 100%;
            max-width: 420px;
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
        
        .register-card::before {
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
        .register-header {
            text-align: center;
            margin-bottom: 1.5rem;
        }
        
        .logo-mini {
            width: 50px;
            height: 50px;
            background: var(--primary-gradient);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 0.8rem;
            box-shadow: var(--card-shadow);
        }
        
        .logo-mini i {
            font-size: 1.2rem;
            color: white;
        }
        
        .register-title {
            font-size: 1.8rem;
            font-weight: 700;
            background: var(--primary-gradient);
            background-clip: text;
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            margin-bottom: 0.3rem;
        }
        
        .register-subtitle {
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
        
        /* Compact Password Strength */
        .password-strength {
            margin-top: 0.3rem;
            height: 3px;
            background: #e9ecef;
            border-radius: 2px;
            overflow: hidden;
            transition: all 0.3s ease;
        }
        
        .password-strength-bar {
            height: 100%;
            width: 0%;
            transition: all 0.3s ease;
        }
        
        .strength-weak { background: #dc3545; width: 33%; }
        .strength-medium { background: #ffc107; width: 66%; }
        .strength-strong { background: #28a745; width: 100%; }
        
        /* Compact Button */
        .btn-register {
            background: var(--primary-gradient);
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
        
        .btn-register:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(102, 126, 234, 0.4);
            color: white;
        }
        
        /* Compact Login Link */
        .login-link {
            text-align: center;
            margin-top: 1rem;
            padding-top: 1rem;
            border-top: 1px solid rgba(0,0,0,0.1);
        }
        
        .login-link {
            font-size: 0.9rem;
        }
        
        .login-link a {
            color: var(--text-primary);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }
        
        .login-link a:hover {
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
        .btn-register.loading {
            pointer-events: none;
            opacity: 0.7;
        }
        
        .btn-register.loading::after {
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
        
        /* Responsive Design - Single Screen */
        @media (max-width: 768px) {
            .register-container {
                padding: 0.8rem;
            }
            
            .register-card {
                padding: 1.5rem;
                max-height: 95vh;
            }
            
            .register-title {
                font-size: 1.6rem;
            }
            
            .register-subtitle {
                font-size: 0.85rem;
            }
        }
        
        @media (max-width: 480px) {
            .register-card {
                padding: 1.2rem;
                max-height: 98vh;
            }
            
            .register-title {
                font-size: 1.5rem;
            }
            
            .form-group {
                margin-bottom: 0.8rem;
            }
        }
        
        @media (max-height: 600px) {
            .register-card {
                padding: 1rem;
                max-height: 95vh;
            }
            
            .register-header {
                margin-bottom: 1rem;
            }
            
            .register-title {
                font-size: 1.5rem;
                margin-bottom: 0.2rem;
            }
            
            .register-subtitle {
                font-size: 0.8rem;
            }
            
            .form-group {
                margin-bottom: 0.8rem;
            }
            
            .logo-mini {
                width: 40px;
                height: 40px;
                margin-bottom: 0.5rem;
            }
            
            .logo-mini i {
                font-size: 1rem;
            }
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-card">
            <!-- Header -->
            <div class="register-header">
                <div class="logo-mini">
                    <i class="fas fa-car"></i>
                </div>
                <h2 class="register-title">Join MotorHub</h2>
                <p class="register-subtitle">Create your account to start buying and selling vehicles</p>
            </div>
            
            <!-- Error/Success Messages using JSP scriptlets -->
            <%
            String error = (String) request.getAttribute("error");
            String message = (String) request.getAttribute("message");
            %>
            
            <% if (error != null && !error.trim().isEmpty()) { %>
                <div class="alert alert-danger" role="alert">
                    <i class="fas fa-exclamation-circle me-2"></i><%= error %>
                </div>
            <% } %>
            
            <% if (message != null && !message.trim().isEmpty()) { %>
                <div class="alert alert-success" role="alert">
                    <i class="fas fa-check-circle me-2"></i><%= message %>
                </div>
            <% } %>
            
            <!-- Registration Form -->
            <form action="<%= request.getContextPath() %>/register" method="POST" id="registerForm" >
                <div class="form-group">
                    <label for="nameInput" class="form-label">
                        <i class="fas fa-user"></i>
                        Full Name
                    </label>
                    <input name="name" type="text" id="nameInput" class="form-control" 
                           value="<%= request.getParameter("name") != null ? request.getParameter("name") : "" %>" 
                           required placeholder="Enter your full name">
                </div>
                
                <div class="form-group">
                    <label for="emailInput" class="form-label">
                        <i class="fas fa-envelope"></i>
                        Email Address
                    </label>
                    <input name="email" type="email" id="emailInput" class="form-control" 
                           value="<%= request.getParameter("email") != null ? request.getParameter("email") : "" %>" 
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
                           required placeholder="Create a strong password" autocomplete="new-password">
                    <div class="password-strength">
                        <div class="password-strength-bar"></div>
                    </div>
                    <div class="form-text" id="passwordHelp">
                        <i class="fas fa-info-circle"></i>
                        Use at least 8 characters with numbers and symbols
                    </div>
                </div>
                
                <button type="submit" class="btn btn-register" id="registerBtn">
                    <i class="fas fa-user-plus me-2"></i>
                    Create Account
                </button>
            </form>
            
            <!-- Login Link -->
            <div class="login-link">
                <p class="mb-0">Already have an account? 
                    <a href="<%= request.getContextPath() %>/login">
                        Sign in here
                    </a>
                </p>
            </div>
        </div>
    </div>
    
    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    
    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.getElementById('registerForm');
            const passwordInput = document.getElementById('passwordInput');
            const strengthBar = document.querySelector('.password-strength-bar');
            const registerBtn = document.getElementById('registerBtn');
            
            // Password strength checker
            passwordInput.addEventListener('input', function() {
                const password = this.value;
                let strength = 0;
                
                // Check password criteria
                if (password.length >= 8) strength++;
                if (/[A-Z]/.test(password)) strength++;
                if (/[0-9]/.test(password)) strength++;
                if (/[^A-Za-z0-9]/.test(password)) strength++;
                
                // Update strength bar
                strengthBar.className = 'password-strength-bar';
                if (strength >= 2) strengthBar.classList.add('strength-weak');
                if (strength >= 3) strengthBar.classList.add('strength-medium');
                if (strength >= 4) strengthBar.classList.add('strength-strong');
            });
            
            // Form submission with loading state
            form.addEventListener('submit', function(e) {
                registerBtn.classList.add('loading');
                registerBtn.innerHTML = 'Creating Account...';
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
