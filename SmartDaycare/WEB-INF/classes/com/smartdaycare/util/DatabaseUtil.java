package com.smartdaycare.util;

import javax.servlet.ServletContext;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DatabaseUtil {
    private static String dbUrl;
    private static String dbUser;
    private static String dbPassword;

    public static void init(ServletContext context) {
        dbUrl = context.getInitParameter("dbUrl");
        dbUser = context.getInitParameter("dbUser");
        dbPassword = context.getInitParameter("dbPassword");
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Failed to load MySQL driver", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(dbUrl, dbUser, dbPassword);
    }
} 