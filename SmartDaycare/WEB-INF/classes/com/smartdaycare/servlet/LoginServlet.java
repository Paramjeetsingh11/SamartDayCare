package com.smartdaycare.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.smartdaycare.util.DatabaseUtil;

public class LoginServlet extends HttpServlet {
    
    @Override
    public void init() throws ServletException {
        DatabaseUtil.init(getServletContext());
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String userType = request.getParameter("userType");
        
        try (Connection conn = DatabaseUtil.getConnection()) {
            String sql = "SELECT id, username, role FROM users WHERE username = ? AND password = ? AND role = ?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, username);
                stmt.setString(2, password); // In production, use password hashing
                stmt.setString(3, userType);
                
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        // Login successful
                        HttpSession session = request.getSession();
                        session.setAttribute("userId", rs.getInt("id"));
                        session.setAttribute("username", rs.getString("username"));
                        session.setAttribute("userType", rs.getString("role"));
                        
                        // Redirect based on user type
                        switch (userType) {
                            case "PARENT":
                                response.sendRedirect("parent/dashboard.jsp");
                                break;
                            case "TEACHER":
                                response.sendRedirect("teacher/dashboard.jsp");
                                break;
                            case "ADMIN":
                                response.sendRedirect("admin/dashboard.jsp");
                                break;
                            default:
                                response.sendRedirect("index.jsp");
                        }
                    } else {
                        // Login failed
                        request.setAttribute("error", "Invalid username or password");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    }
                }
            }
        } catch (Exception e) {
            throw new ServletException("Database connection error", e);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }
} 