package com.vehicle.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import com.vehicle.util.DbConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // Redirect GET request to register.jsp
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.sendRedirect("register.jsp");
    }

    // Handle user registration POST
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        System.out.println("User name:\t" + name);
        System.out.println("User email:\t" + email);
        System.out.println("User password:\t" + password);

        String sql = "INSERT INTO users (username, email, password) VALUES (?, ?, ?)";

        try (Connection con = DbConnection.getConnection();
        		
             PreparedStatement pst = con.prepareStatement(sql)) 
        {

            pst.setString(1, name);
            pst.setString(2, email);
            pst.setString(3, password);

            int rows = pst.executeUpdate();

            if (rows > 0) {
                // Registration success: redirect to login
                response.sendRedirect("login");
            } else {
                // Handle failure (you may forward an error message)
                response.sendRedirect("register.jsp?error=RegistrationFailed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            // Redirect back with error
            response.sendRedirect("register.jsp?error=ServerError");
        }
    }
}
