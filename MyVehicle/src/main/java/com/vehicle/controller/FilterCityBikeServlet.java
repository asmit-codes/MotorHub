package com.vehicle.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import com.vehicle.model.Area;
import com.vehicle.model.City;
import com.vehicle.model.State;
import com.vehicle.model.Vehicle;
import com.vehicle.model.Zip;
import com.vehicle.util.DbConnection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/filtercitybike")
public class FilterCityBikeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect GET requests to the bike page
        response.sendRedirect(request.getContextPath() + "/bike");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String selectedCity = request.getParameter("city");
        System.out.println("City:\t" + selectedCity);

        // Load filter lists
        ArrayList<Area> areaList = new Area().fetchAreaBike();
        ArrayList<City> cityList = new City().fetchCityBike();
        ArrayList<State> stateList = new State().fetchStateBike();
        ArrayList<Zip> zipList = new Zip().fetchZipBike();

        ArrayList<Vehicle> bikeList = new ArrayList<>();

        String sql = "SELECT * FROM vehicle WHERE type = ? AND avail = ? AND city = ?";

        new DbConnection();
		try (Connection con = DbConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, 2); // type = 2 → bike
            ps.setString(2, "true");
            ps.setString(3, selectedCity);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Vehicle bike = new Vehicle();
                    bike.setV_id(rs.getInt("v_id"));
                    bike.setOwner_id(rs.getInt("owner_id"));
                    bike.setType(rs.getInt("type"));
                    bike.setModel(rs.getString("model"));
                    bike.setColor(rs.getString("color"));
                    bike.setReg_date(rs.getString("reg_date"));
                    bike.setImage(rs.getString("image"));
                    bike.setPrice(rs.getFloat("price"));
                    bike.setArea(rs.getString("area"));
                    bike.setCity(rs.getString("city"));
                    bike.setState(rs.getString("state"));
                    bike.setZip(rs.getString("zip"));
                    bike.setFuel_type(rs.getString("fuel_type"));
                    bike.setGear(rs.getString("gear"));
                    bike.setAvail(rs.getBoolean("avail"));

                    bikeList.add(bike);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error fetching bike list: " + e.getMessage());
        }

        // Set attributes for JSP
        request.setAttribute("areaList", areaList);
        request.setAttribute("cityList", cityList);
        request.setAttribute("stateList", stateList);
        request.setAttribute("zipList", zipList);
        request.setAttribute("bikeList", bikeList);

        RequestDispatcher rd = request.getRequestDispatcher("bike.jsp");
        rd.forward(request, response);
    }
}
