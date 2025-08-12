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

@WebServlet("/deletevehicle")
public class DeleteVehicleServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int v_id = Integer.parseInt(request.getParameter("v_id"));
        int owner_id = Integer.parseInt(request.getParameter("owner_id"));

        new DbConnection();
		try (Connection con = DbConnection.getConnection()) {
            if (con != null) {
                con.setAutoCommit(false);
                
                String sqlVehicle = "DELETE FROM vehicle WHERE v_id = ?";
                try (PreparedStatement stVehicle = con.prepareStatement(sqlVehicle)) {
                    stVehicle.setInt(1, v_id);
                    stVehicle.executeUpdate();
                }
                
                String sqlOwner = "DELETE FROM owner WHERE owner_id = ?";
                try (PreparedStatement stOwner = con.prepareStatement(sqlOwner)) {
                    stOwner.setInt(1, owner_id);
                    stOwner.executeUpdate();
                }
                
                con.commit();
                response.sendRedirect("/Vehicle/sell");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error deleting vehicle/owner: " + e.getMessage());
        }
    }
}
