package com.vehicle.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.vehicle.util.DbConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        System.out.println("Message parameter: " + request.getParameter("message"));
        
        // Forward to login.jsp (preserves URL parameters)
        request.getRequestDispatcher("/login.jsp").forward(request, response);  // ✅ Keeps URL parameters
    }


    // Handle login POST request
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        String sql = "SELECT * FROM users WHERE email = ?";

        try (Connection con = DbConnection.getConnection();
             PreparedStatement pst = con.prepareStatement(sql)) {

            pst.setString(1, email);
            ResultSet rs = pst.executeQuery();

            if (!rs.isBeforeFirst()) {
                // Email not found
                session.setAttribute("loginError", "Email ID not found");
                response.sendRedirect("login.jsp");
            } else {
                rs.next();
                String dbPassword = rs.getString("password");

                if (password.equals(dbPassword)) {
                    // Successful login
                    session.setAttribute("user_id", rs.getInt("user_id"));
                    session.setAttribute("username", rs.getString("username"));
                    session.setAttribute("email", rs.getString("email"));
                    response.sendRedirect("dashboard");
                } else {
                    // Invalid password
                    session.setAttribute("loginError", "Invalid password");
                    response.sendRedirect("login.jsp");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("loginError", "Internal error occurred");
            response.sendRedirect("login.jsp");
        }
    }
}
