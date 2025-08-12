package com.vehicle.model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.vehicle.util.DbConnection;


public class Area {
    private String name;

    public Area() {}

    public Area(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }
    
    public ArrayList<Area> fetchAreaByType(int type) {
        ArrayList<Area> areaList = new ArrayList<>();

        String sql = "SELECT DISTINCT area FROM vehicle WHERE type=" + type;

        try (Connection con = DbConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            if (!rs.isBeforeFirst()) {
                return null;
            } else {
                while (rs.next()) {
                    Area area = new Area();
                    area.setName(rs.getString("area"));
                    areaList.add(area);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return areaList;
    }
    
 // Add this method to use in your servlet
    public ArrayList<Area> fetchAreaBike() {
        return fetchAreaByType(2);  // 2 = bike type
        
    }

	public ArrayList<Area> fetchAreaCar() {
		// TODO Auto-generated method stub
		return fetchAreaByType(4);
	}
    
}