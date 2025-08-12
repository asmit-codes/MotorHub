package com.vehicle.controller;

import java.io.IOException;
import java.io.PrintWriter;
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

@WebServlet("/filtercitycar")
public class FilterCityCarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirect GET requests to the car listing page
        response.sendRedirect("/Vehicle/car");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PrintWriter out = response.getWriter();

        String selectedCity = request.getParameter("city");
        System.out.println("City:\t" + selectedCity);

        // Fetch filter lists
        Area a = new Area();
        ArrayList<Area> areaList = a.fetchAreaCar();

        City c = new City();
        ArrayList<City> cityList = c.fetchCityCar();

        State s = new State();
        ArrayList<State> stateList = s.fetchStateCar();

        Zip z = new Zip();
        ArrayList<Zip> zipList = z.fetchZipCar();

        ArrayList<Vehicle> carList = new ArrayList<>();

        try (Connection con = DbConnection.getConnection()) {
            if (con != null) {
                System.out.println("Connection Successful");

                String sql = "SELECT * FROM vehicle WHERE type = ? AND avail = true AND city = ?";
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setInt(1, 4);               // 4 = car type (as per your convention)
                pst.setString(2, selectedCity);

                ResultSet rs = pst.executeQuery();

                if (!rs.isBeforeFirst()) {
                    out.println("No Cars Found");
                } else {
                    while (rs.next()) {
                        Vehicle car = new Vehicle();

                        car.setV_id(rs.getInt("v_id"));
                        car.setOwner_id(rs.getInt("owner_id"));
                        car.setType(rs.getInt("type"));
                        car.setModel(rs.getString("model"));
                        car.setColor(rs.getString("color"));
                        car.setReg_date(rs.getString("reg_date"));
                        car.setImage(rs.getString("image"));
                        car.setPrice(rs.getFloat("price"));
                        car.setArea(rs.getString("area"));
                        car.setCity(rs.getString("city"));
                        car.setState(rs.getString("state"));
                        car.setZip(rs.getString("zip"));
                        car.setFuel_type(rs.getString("fuel_type"));
                        car.setGear(rs.getString("gear"));
                        car.setAvail(rs.getBoolean("avail"));

                        carList.add(car);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            out.println("Error occurred: " + e.getMessage());
        }

        request.setAttribute("areaList", areaList);
        request.setAttribute("cityList", cityList);
        request.setAttribute("stateList", stateList);
        request.setAttribute("zipList", zipList);
        request.setAttribute("carList", carList);

        RequestDispatcher rd = request.getRequestDispatcher("car.jsp");
        rd.forward(request, response);
    }
}
