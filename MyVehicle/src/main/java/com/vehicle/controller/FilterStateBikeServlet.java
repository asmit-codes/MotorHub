package com.vehicle.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
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

@WebServlet("/filterstatebike")
public class FilterStateBikeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("/Vehicle/bike");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String selectedState = request.getParameter("state");
        System.out.println("State: " + selectedState);

        // Prepare filter lists
        ArrayList<Area> areaList = new Area().fetchAreaBike();
        ArrayList<City> cityList = new City().fetchCityBike();
        ArrayList<State> stateList = new State().fetchStateBike();
        ArrayList<Zip> zipList = new Zip().fetchZipBike();

        ArrayList<Vehicle> bikeList = new ArrayList<>();

        String sql = "SELECT * FROM vehicle WHERE type = 2 AND avail = 'true' AND state = '" + selectedState + "'";

        new DbConnection();
		try (Connection con = DbConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            if (!rs.isBeforeFirst()) {
                System.out.println("No bikes found for state: " + selectedState);
            } else {
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
