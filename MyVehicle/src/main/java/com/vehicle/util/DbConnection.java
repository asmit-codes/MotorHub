package com.vehicle.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConnection {

    private static final String URL = "jdbc:oracle:thin:@localhost:1521:orcl";
    private static final String USER = "system";
    private static final String PASS = "1234";

    static {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver"); // Load Oracle Driver
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }

    // Optional: test connection
    public static void main(String[] args) {
        try (Connection con = getConnection()) {
            System.out.println("✅ Connected to Oracle DB");
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
