package com.vehicle.controller;

import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet("/filterzipbike")
public class FilterZipBikeServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("/Vehicle/bike");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
       PrintWriter out = response.getWriter();
        
        String selectedZip = request.getParameter("zip");
        System.out.println("Zip: " + selectedZip);
        
        // Load filter lists
        ArrayList<Area> areaList = new Area().fetchAreaBike();
        ArrayList<City> cityList = new City().fetchCityBike();
        ArrayList<State> stateList = new State().fetchStateBike();
        ArrayList<Zip> zipList = new Zip().fetchZipBike();
        
        ArrayList<Vehicle> bikeList = new ArrayList<>();
        
        try (Connection con = DbConnection.getConnection()) {
            if (con != null) {
                System.out.println("Connection Successful");
                
                Statement st = con.createStatement();
                String sql = "SELECT * FROM vehicle WHERE type=2 AND avail='true' AND zip='" + selectedZip + "'";
                ResultSet rs = st.executeQuery(sql);
                
                if (!rs.isBeforeFirst()) {
                    out.println("No bikes found");
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
                        bike.setAvail(Boolean.parseBoolean(rs.getString("avail")));
                        
                        bikeList.add(bike);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        
        // Set request attributes
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
