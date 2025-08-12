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

@WebServlet("/filterzipcar")
public class FilterZipCarServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Redirect GET requests to the main car listing page
        response.sendRedirect("/Vehicle/car");
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();

        // Read selected zip from form
        String selectedZip = request.getParameter("zip");
        System.out.println("Selected Zip: " + selectedZip);

        // Fetch filter dropdown lists
        Area a = new Area();
        ArrayList<Area> areaList = a.fetchAreaCar();

        City c = new City();
        ArrayList<City> cityList = c.fetchCityCar();

        State s = new State();
        ArrayList<State> stateList = s.fetchStateCar();

        Zip z = new Zip();
        ArrayList<Zip> zipList = z.fetchZipCar();

        ArrayList<Vehicle> carList = new ArrayList<>();

        try (Connection con = DbConnection.getConnection();
             Statement st = con.createStatement()) {

            if (con != null) {
                System.out.println("Database Connection Successful");

                String sql = "SELECT * FROM vehicle WHERE type=4 AND avail='true' AND zip='" + selectedZip + "'";
                ResultSet rs = st.executeQuery(sql);

                if (!rs.isBeforeFirst()) {
                    out.println("<p>No Cars Found for the selected Zip Code.</p>");
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
            out.println("<p>Error while fetching cars.</p>");
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
