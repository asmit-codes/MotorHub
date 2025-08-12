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

@WebServlet("/filterareabike")
public class FilterAreaBikeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect to bike listing page if GET request
        response.sendRedirect("/Vehicle/bike");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String selectedArea = request.getParameter("area");
        System.out.println("Selected Area: " + selectedArea);

        // Load filter lists
        Area a = new Area();
        ArrayList<Area> areaList = a.fetchAreaBike();

        City c = new City();
        ArrayList<City> cityList = c.fetchCityBike();

        State s = new State();
        ArrayList<State> stateList = s.fetchStateBike();

        Zip z = new Zip();
        ArrayList<Zip> zipList = z.fetchZipBike();

        ArrayList<Vehicle> bikeList = new ArrayList<>();

        try (Connection con = DbConnection.getConnection();
             Statement st = con.createStatement()) {

            String sql = "SELECT * FROM vehicle WHERE type = 2 AND avail = 'true' AND area = '" + selectedArea + "'";
            ResultSet rs = st.executeQuery(sql);

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

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Set attributes for JSP
        request.setAttribute("areaList", areaList);
        request.setAttribute("cityList", cityList);
        request.setAttribute("stateList", stateList);
        request.setAttribute("zipList", zipList);
        request.setAttribute("bikeList", bikeList);

        // Forward to JSP
        RequestDispatcher rd = request.getRequestDispatcher("bike.jsp");
        rd.forward(request, response);
    }
}
