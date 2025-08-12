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
import jakarta.servlet.http.HttpSession;

@WebServlet("/book")
public class BookServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
       
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Optional: Redirect or show booking page if needed
        response.sendRedirect("dashboard");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            // User not logged in, redirect to login page
            response.sendRedirect("login");
            return;
        }

        int v_id = Integer.parseInt(request.getParameter("v_id"));
        int owner_id = Integer.parseInt(request.getParameter("owner_id"));
        int user_id = (Integer) session.getAttribute("user_id");

        try (Connection con = DbConnection.getConnection()) {
            if (con != null) {
                // Update vehicle availability to false (not available)
                String sqlUpdate = "UPDATE vehicle SET avail = false WHERE v_id = ?";
                try (PreparedStatement pstUpdate = con.prepareStatement(sqlUpdate)) {
                    pstUpdate.setInt(1, v_id);
                    pstUpdate.executeUpdate();
                }

                // Insert booking record
                String sqlInsert = "INSERT INTO booking (user_id, owner_id, vehicle_id, date) VALUES (?, ?, ?, ?)";
                try (PreparedStatement pstInsert = con.prepareStatement(sqlInsert)) {
                    pstInsert.setInt(1, user_id);
                    pstInsert.setInt(2, owner_id);
                    pstInsert.setInt(3, v_id);
                    pstInsert.setDate(4, java.sql.Date.valueOf(java.time.LocalDate.now()));
                    pstInsert.executeUpdate();
                }

                System.out.println("Successfully Booked");
                response.sendRedirect("dashboard");
            } else {
                response.getWriter().println("Database connection failed.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Booking failed: " + e.getMessage());
        }
    }
}
