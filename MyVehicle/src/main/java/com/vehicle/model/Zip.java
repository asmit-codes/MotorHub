package com.vehicle.model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.vehicle.util.DbConnection;

public class Zip {
    private String zip;

    public Zip() {}

    public Zip(String zip) {
        this.zip = zip;
    }

    public String getZip() {
        return zip;
    }

    public void setZip(String zip) {
        this.zip = zip;
    }
    
    public ArrayList<Zip> fetchZipByType(int type) {
        ArrayList<Zip> zipList = new ArrayList<>();
        String sql = "SELECT DISTINCT zip FROM vehicle WHERE type=" + type;

        try (Connection con = DbConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            if (!rs.isBeforeFirst()) {
                return null;
            } else {
                while (rs.next()) {
                    Zip zip = new Zip();
                    zip.setZip(rs.getString("zip"));
                    zipList.add(zip);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return zipList;
    }

	public ArrayList<Zip> fetchZipBike() {
		// TODO Auto-generated method stub
		return fetchZipByType(2);
	}

	public ArrayList<Zip> fetchZipCar() {
		// TODO Auto-generated method stub
		return fetchZipByType(4);
	}
}
