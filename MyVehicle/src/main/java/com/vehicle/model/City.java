package com.vehicle.model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.vehicle.util.DbConnection;

public class City {
    private String city;

    public City() {}

    public City(String city) {
        this.city = city;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public ArrayList<City> fetchCityByType(int type) {
        ArrayList<City> cityList = new ArrayList<>();

        String sql = "SELECT DISTINCT city FROM vehicle WHERE type=" + type;

        try (Connection con = DbConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            if (!rs.isBeforeFirst()) {
                return null;
            } else {
                while (rs.next()) {
                    City city = new City();
                    city.setCity(rs.getString("city"));
                    cityList.add(city);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cityList;
    }

    public ArrayList<City> fetchCityBike() {
        return fetchCityByType(2); // Assuming 2 is bike type
    }

	public ArrayList<City> fetchCityCar() {
		// TODO Auto-generated method stub
		return fetchCityByType(4);
	}

	}

