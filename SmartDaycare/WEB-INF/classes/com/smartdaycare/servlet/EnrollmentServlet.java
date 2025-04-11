package com.smartdaycare.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.smartdaycare.util.DatabaseUtil;
import java.sql.Date;

public class EnrollmentServlet extends HttpServlet {
    
    @Override
    public void init() throws ServletException {
        DatabaseUtil.init(getServletContext());
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        Connection conn = null;
        try {
            conn = DatabaseUtil.getConnection();
            conn.setAutoCommit(false); // Start transaction
            
            // Insert parent user
            String insertUserSql = "INSERT INTO users (username, password, role, first_name, last_name, email, phone) " +
                                 "VALUES (?, ?, 'PARENT', ?, ?, ?, ?)";
            
            PreparedStatement userStmt = conn.prepareStatement(insertUserSql, Statement.RETURN_GENERATED_KEYS);
            userStmt.setString(1, request.getParameter("username"));
            userStmt.setString(2, request.getParameter("password"));
            userStmt.setString(3, request.getParameter("parentFirstName"));
            userStmt.setString(4, request.getParameter("parentLastName"));
            userStmt.setString(5, request.getParameter("email"));
            userStmt.setString(6, request.getParameter("phone"));
            
            int affectedRows = userStmt.executeUpdate();
            
            if (affectedRows == 0) {
                throw new ServletException("Creating user failed, no rows affected.");
            }
            
            ResultSet generatedKeys = userStmt.getGeneratedKeys();
            int parentId;
            if (generatedKeys.next()) {
                parentId = generatedKeys.getInt(1);
            } else {
                throw new ServletException("Creating user failed, no ID obtained.");
            }
            
            // Insert child
            String insertChildSql = "INSERT INTO children (first_name, last_name, date_of_birth, parent_id, " +
                                  "enrollment_date, age_group, medical_info, emergency_contact) " +
                                  "VALUES (?, ?, ?, ?, CURDATE(), ?, ?, ?)";
            
            PreparedStatement childStmt = conn.prepareStatement(insertChildSql);
            childStmt.setString(1, request.getParameter("childFirstName"));
            childStmt.setString(2, request.getParameter("childLastName"));
            childStmt.setDate(3, Date.valueOf(request.getParameter("dateOfBirth")));
            childStmt.setInt(4, parentId);
            childStmt.setString(5, request.getParameter("ageGroup"));
            childStmt.setString(6, request.getParameter("medicalInfo"));
            childStmt.setString(7, request.getParameter("emergencyContact") + " - " + 
                                 request.getParameter("emergencyPhone"));
            
            childStmt.executeUpdate();
            
            // Commit transaction
            conn.commit();
            
            // Set success message and redirect
            request.setAttribute("success", "Enrollment successful! Please login to access your account.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            
        } catch (Exception e) {
            // Rollback transaction on error
            if (conn != null) {
                try {
                    conn.rollback();
                } catch (Exception ex) {
                    throw new ServletException("Rollback failed", ex);
                }
            }
            
            request.setAttribute("error", "Enrollment failed: " + e.getMessage());
            request.getRequestDispatcher("enrollment.jsp").forward(request, response);
            
        } finally {
            if (conn != null) {
                try {
                    conn.close();
                } catch (Exception e) {
                    // Log the error but don't throw it
                    e.printStackTrace();
                }
            }
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect("enrollment.jsp");
    }
} 