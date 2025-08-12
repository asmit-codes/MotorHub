package com.vehicle.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.vehicle.model.Vehicle;
import com.vehicle.util.DbConnection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/sell")
public class SellServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        ArrayList<Vehicle> vehicleList = new ArrayList<>();
        new DbConnection();
		try (Connection con = DbConnection.getConnection()) {
            if (con != null) {
                String sql = "SELECT * FROM vehicle WHERE user_id = ? AND avail = true";
                try (PreparedStatement pst = con.prepareStatement(sql)) {
                    pst.setInt(1, (Integer) session.getAttribute("user_id"));
                    ResultSet rs = pst.executeQuery();
                    while (rs.next()) {
                        Vehicle vehicle = new Vehicle();
                        vehicle.setV_id(rs.getInt("v_id"));
                        vehicle.setOwner_id(rs.getInt("owner_id"));
                        vehicle.setType(rs.getInt("type"));
                        vehicle.setModel(rs.getString("model"));
                        vehicle.setColor(rs.getString("color"));
                        vehicle.setReg_date(rs.getString("reg_date"));
                        vehicle.setImage(rs.getString("image"));
                        vehicle.setPrice(rs.getFloat("price"));
                        vehicle.setArea(rs.getString("area"));
                        vehicle.setCity(rs.getString("city"));
                        vehicle.setState(rs.getString("state"));
                        vehicle.setZip(rs.getString("zip"));
                        vehicle.setFuel_type(rs.getString("fuel_type"));
                        vehicle.setGear(rs.getString("gear"));
                        vehicle.setAvail(rs.getBoolean("avail"));
                        vehicleList.add(vehicle);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.setAttribute("vehicleList", vehicleList);
        RequestDispatcher rd = request.getRequestDispatcher("sell.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user_id") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        new DbConnection();
		try (Connection con = DbConnection.getConnection()) {
            if (con != null) {
                con.setAutoCommit(false);

                String ownerSql = "INSERT INTO owner (name, address, phone, email, user_id) VALUES (?, ?, ?, ?, ?)";
                int newOwnerId = 0;
                try (PreparedStatement pstOwner = con.prepareStatement(ownerSql, PreparedStatement.RETURN_GENERATED_KEYS)) {
                    pstOwner.setString(1, request.getParameter("name"));
                    pstOwner.setString(2, request.getParameter("address"));
                    pstOwner.setString(3, request.getParameter("phone"));
                    pstOwner.setString(4, request.getParameter("email"));
                    pstOwner.setInt(5, (Integer) session.getAttribute("user_id"));
                    pstOwner.executeUpdate();

                    try (ResultSet generatedKeys = pstOwner.getGeneratedKeys()) {
                        if (generatedKeys.next()) {
                            newOwnerId = generatedKeys.getInt(1);
                        } else {
                            throw new Exception("Failed to get owner_id.");
                        }
                    }
                }

                String vehicleSql = "INSERT INTO vehicle (type, model, color, reg_date, image, price, area, city, state, zip, owner_id, fuel_type, gear, avail, user_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
                try (PreparedStatement pstVehicle = con.prepareStatement(vehicleSql)) {
                    pstVehicle.setInt(1, Integer.parseInt(request.getParameter("type")));
                    pstVehicle.setString(2, request.getParameter("model"));
                    pstVehicle.setString(3, request.getParameter("color"));
                    pstVehicle.setString(4, request.getParameter("reg_date"));
                    pstVehicle.setString(5, request.getParameter("image"));
                    pstVehicle.setFloat(6, Float.parseFloat(request.getParameter("price")));
                    pstVehicle.setString(7, request.getParameter("area"));
                    pstVehicle.setString(8, request.getParameter("city"));
                    pstVehicle.setString(9, request.getParameter("state"));
                    pstVehicle.setString(10, request.getParameter("zip"));
                    pstVehicle.setInt(11, newOwnerId);
                    pstVehicle.setString(12, request.getParameter("fuel_type"));
                    pstVehicle.setString(13, request.getParameter("gear"));
                    pstVehicle.setBoolean(14, true);
                    pstVehicle.setInt(15, (Integer) session.getAttribute("user_id"));
                    pstVehicle.executeUpdate();
                }

                con.commit();
                response.sendRedirect("sell");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.getWriter().println("Error: " + e.getMessage());
        }
    }
}
