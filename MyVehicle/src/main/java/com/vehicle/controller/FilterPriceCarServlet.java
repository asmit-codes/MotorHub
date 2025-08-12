package com.vehicle.controller;

import java.io.IOException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import com.vehicle.model.Area;
import com.vehicle.model.City;
import com.vehicle.model.State;
import com.vehicle.model.Zip;
import com.vehicle.model.Vehicle;
import com.vehicle.util.DbConnection;

@WebServlet("/filterpricecar")
public class FilterPriceCarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Redirect to car page if accessed via GET
        response.sendRedirect("/Vehicle/car");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        int priceRange = Integer.parseInt(request.getParameter("price_range"));
        System.out.println("Price Range: " + priceRange);

        // Prepare filter lists
        Area areaObj = new Area();
        ArrayList<Area> areaList = areaObj.fetchAreaCar();

        City cityObj = new City();
        ArrayList<City> cityList = cityObj.fetchCityCar();

        State stateObj = new State();
        ArrayList<State> stateList = stateObj.fetchStateCar();

        Zip zipObj = new Zip();
        ArrayList<Zip> zipList = zipObj.fetchZipCar();

        ArrayList<Vehicle> carList = new ArrayList<>();

        // Fetch cars matching the price range
        try (Connection con = DbConnection.getConnection();
             Statement st = con.createStatement()) {

            String sql = "SELECT * FROM vehicle WHERE type=4 AND avail='true' AND price <= " + priceRange;
            ResultSet rs = st.executeQuery(sql);

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

        } catch (Exception e) {
            e.printStackTrace();
        }

        // Set attributes for JSP
        request.setAttribute("areaList", areaList);
        request.setAttribute("cityList", cityList);
        request.setAttribute("stateList", stateList);
        request.setAttribute("zipList", zipList);
        request.setAttribute("carList", carList);

        // Forward to JSP
        RequestDispatcher rd = request.getRequestDispatcher("car.jsp");
        rd.forward(request, response);
    }
}
