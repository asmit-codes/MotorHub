package com.vehicle.model;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.ArrayList;

import com.vehicle.util.DbConnection;

public class State {
    private String state;

    public State() {}

    public State(String state) {
        this.state = state;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }
    
    public ArrayList<State> fetchStateByType(int type) {
        ArrayList<State> stateList = new ArrayList<>();
        String sql = "SELECT DISTINCT state FROM vehicle WHERE type=" + type;

        try (Connection con = DbConnection.getConnection();
             Statement st = con.createStatement();
             ResultSet rs = st.executeQuery(sql)) {

            if (!rs.isBeforeFirst()) {
                return null;
            } else {
                while (rs.next()) {
                    State state = new State();
                    state.setState(rs.getString("state"));
                    stateList.add(state);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return stateList;
    }

	public ArrayList<State> fetchStateBike() {
		// TODO Auto-generated method stub
		return fetchStateByType(2); //Assuming 2 is bike type
	}

	public ArrayList<State> fetchStateCar() {
		// TODO Auto-generated method stub
		return fetchStateByType(4);
	}
}
