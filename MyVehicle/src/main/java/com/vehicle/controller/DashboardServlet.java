package com.vehicle.controller;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/dashboard")
public class DashboardServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // Check if user is authenticated
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("user_id") == null) {
            // User not logged in - redirect to login page
            System.out.println("❌ Unauthorized access to dashboard - redirecting to login");
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // User is authenticated - get user details
        String username = (String) session.getAttribute("username");
        String email = (String) session.getAttribute("email");
        Object userIdObj = session.getAttribute("user_id");
        
        System.out.println("✅ Dashboard access granted for user: " + username);
        
        // Set user info as request attributes (optional - already in session)
        request.setAttribute("username", username);
        request.setAttribute("email", email);
        request.setAttribute("user_id", userIdObj);
        
        // Set cache control headers to prevent caching of dashboard
        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);
        
        // Forward to dashboard.jsp (server-side)
        request.getRequestDispatcher("/dashboard.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // For POST requests, also check authentication
        HttpSession session = request.getSession(false);
        
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // Handle any POST operations here (like dashboard form submissions)
        // For now, redirect to GET method
        response.sendRedirect(request.getContextPath() + "/dashboard");
    }
}
