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

@WebServlet("/car")
public class CarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Fetch filter lists
        Area a = new Area();
        ArrayList<Area> areaList = a.fetchAreaByType(4);  // type 4 = car

        City c = new City();
        ArrayList<City> cityList = c.fetchCityByType(4);

        State s = new State();
        ArrayList<State> stateList = s.fetchStateByType(4);

        Zip z = new Zip();
        ArrayList<Zip> zipList = z.fetchZipByType(4);

        ArrayList<Vehicle> carList = new ArrayList<>();

        String sql = "SELECT * FROM vehicle WHERE type=4 AND avail=true";

        try (Connection con = DbConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            if (!rs.isBeforeFirst()) {
                request.setAttribute("message", "No Cars Found");
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

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("errorMessage", "Unable to retrieve cars data.");
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

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Optional: Implement if you want to handle POST requests here
        doGet(request, response);
    }
}
