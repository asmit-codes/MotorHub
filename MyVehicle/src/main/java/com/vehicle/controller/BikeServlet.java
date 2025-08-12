package com.vehicle.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.vehicle.model.State;

import com.vehicle.model.Area;
import com.vehicle.model.City;
import com.vehicle.model.Vehicle;
import com.vehicle.model.Zip;
import com.vehicle.util.DbConnection;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/bike")
public class BikeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	Area a = new Area();
    	ArrayList<Area> areaList = a.fetchAreaByType(2);  // fetch areas for bikes

    	City c = new City();
    	ArrayList<City> cityList = c.fetchCityByType(2);

    	State s = new State();
    	ArrayList<State> stateList = s.fetchStateByType(2);

    	Zip z = new Zip();
    	ArrayList<Zip> zipList = z.fetchZipByType(2);


        ArrayList<Vehicle> bikeList = new ArrayList<>();

        String sql = "SELECT * FROM vehicle WHERE type=2 AND avail=true";

        try (Connection con = DbConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            if (!rs.isBeforeFirst()) {
                request.setAttribute("message", "No Bikes Found");
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
            request.setAttribute("errorMessage", "Unable to retrieve bikes data.");
        }

        request.setAttribute("areaList", areaList);
        request.setAttribute("cityList", cityList);
        request.setAttribute("stateList", stateList);
        request.setAttribute("zipList", zipList);
        request.setAttribute("bikeList", bikeList);

        RequestDispatcher rd = request.getRequestDispatcher("bike.jsp");
        rd.forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO: Handle POST if needed
    }
}
