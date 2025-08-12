package com.vehicle.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.time.LocalDate;
import java.util.ArrayList;

import com.vehicle.model.Booking;
import com.vehicle.model.Vehicle;
import com.vehicle.util.DbConnection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/orders")
public class OrdersServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    // GET request – Fetch bookings & vehicles
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();
        HttpSession session = request.getSession();

        ArrayList<Booking> bookingList = new ArrayList<>();
        ArrayList<Vehicle> vehicleList = new ArrayList<>();

        try (Connection con = DbConnection.getConnection()) {
            if (con != null) {
                System.out.println("Connection Successful");

                // Fetch bookings for logged-in user
                String bookingQuery = "SELECT * FROM booking WHERE user_id = ?";
                try (PreparedStatement pst = con.prepareStatement(bookingQuery)) {
                    pst.setInt(1, (int) session.getAttribute("user_id"));
                    try (ResultSet rs = pst.executeQuery()) {
                        if (!rs.isBeforeFirst()) {
                            out.println("No Bookings Found");
                        } else {
                            while (rs.next()) {
                                Booking booking = new Booking();
                                int booking_id = rs.getInt("booking_id");
                                int user_id = rs.getInt("user_id");
                                int owner_id = rs.getInt("owner_id");
                                int vehicle_id = rs.getInt("vehicle_id");
                                LocalDate date = rs.getDate("date").toLocalDate();

                                booking.setBooking_id(booking_id);
                                booking.setUser_id(user_id);
                                booking.setOwner_id(owner_id);
                                booking.setVehicle_id(vehicle_id);
                                booking.setDate(date);

                                bookingList.add(booking);

                                // Fetch vehicle details for this booking
                                String vehicleQuery = "SELECT * FROM vehicle WHERE v_id = ?";
                                try (PreparedStatement pstV = con.prepareStatement(vehicleQuery)) {
                                    pstV.setInt(1, vehicle_id);
                                    try (ResultSet rsV = pstV.executeQuery()) {
                                        while (rsV.next()) {
                                            Vehicle vehicle = new Vehicle();
                                            vehicle.setV_id(rsV.getInt("v_id"));
                                            vehicle.setOwner_id(rsV.getInt("owner_id"));
                                            vehicle.setType(rsV.getInt("type"));
                                            vehicle.setModel(rsV.getString("model"));
                                            vehicle.setColor(rsV.getString("color"));
                                            vehicle.setReg_date(rsV.getString("reg_date"));
                                            vehicle.setImage(rsV.getString("image"));
                                            vehicle.setPrice(rsV.getFloat("price"));
                                            vehicle.setArea(rsV.getString("area"));
                                            vehicle.setCity(rsV.getString("city"));
                                            vehicle.setState(rsV.getString("state"));
                                            vehicle.setZip(rsV.getString("zip"));
                                            vehicle.setFuel_type(rsV.getString("fuel_type"));
                                            vehicle.setGear(rsV.getString("gear"));
                                            vehicle.setAvail(rsV.getBoolean("avail"));

                                            vehicleList.add(vehicle);
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        request.setAttribute("bookingList", bookingList);
        request.setAttribute("vehicleList", vehicleList);
        RequestDispatcher rd = request.getRequestDispatcher("orders.jsp");
        rd.forward(request, response);
    }

    // POST request – Cancel booking & update vehicle availability
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int v_id = Integer.parseInt(request.getParameter("vehicle_id"));
        int booking_id = Integer.parseInt(request.getParameter("booking_id"));

        new DbConnection();
		try (Connection con = DbConnection.getConnection()) {
            if (con != null) {
                System.out.println("Connection Successful");

                // Delete booking
                String deleteBookingQuery = "DELETE FROM booking WHERE booking_id = ?";
                try (PreparedStatement pst = con.prepareStatement(deleteBookingQuery)) {
                    pst.setInt(1, booking_id);
                    pst.executeUpdate();
                }

                // Update vehicle availability
                String updateVehicleQuery = "UPDATE vehicle SET avail = true WHERE v_id = ?";
                try (PreparedStatement pst = con.prepareStatement(updateVehicleQuery)) {
                    pst.setInt(1, v_id);
                    pst.executeUpdate();
                }

                System.out.println("Booking deleted and vehicle availability updated");
                response.sendRedirect(request.getContextPath() + "/orders");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
