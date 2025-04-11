<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*" %>
<%@ page import="com.smartdaycare.util.DatabaseUtil" %>
<!DOCTYPE html>
<html>
<head>
    <title>Parent Dashboard - Smart Daycare System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.8.1/font/bootstrap-icons.css">
    <link href="../css/style.css" rel="stylesheet">
</head>
<body>
    <% 
    // Check if user is logged in and is a parent
    if (session.getAttribute("userId") == null || !"PARENT".equals(session.getAttribute("userType"))) {
        response.sendRedirect("../login.jsp");
        return;
    }
    
    int userId = (Integer) session.getAttribute("userId");
    String username = (String) session.getAttribute("username");
    %>

    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="#">Smart Daycare</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav">
                    <li class="nav-item">
                        <a class="nav-link active" href="dashboard.jsp">Dashboard</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="activities.jsp">Activities</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="attendance.jsp">Attendance</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="payments.jsp">Payments</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="messages.jsp">Messages</a>
                    </li>
                </ul>
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item dropdown">
                        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-bs-toggle="dropdown">
                            <%= username %>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end">
                            <li><a class="dropdown-item" href="profile.jsp">Profile</a></li>
                            <li><hr class="dropdown-divider"></li>
                            <li><a class="dropdown-item" href="../logout">Logout</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-4">
        <div class="row">
            <div class="col-md-12">
                <h2>Welcome, <%= username %>!</h2>
                <p class="lead">Manage your child's daycare information and activities.</p>
            </div>
        </div>
        
        <div class="row mt-4">
            <div class="col-md-8">
                <div class="card mb-4">
                    <div class="card-header">
                        <h4>My Children</h4>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-hover">
                                <thead>
                                    <tr>
                                        <th>Name</th>
                                        <th>Age Group</th>
                                        <th>Date of Birth</th>
                                        <th>Enrollment Date</th>
                                        <th>Actions</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <% 
                                    try (Connection conn = DatabaseUtil.getConnection()) {
                                        String sql = "SELECT * FROM children WHERE parent_id = ?";
                                        PreparedStatement stmt = conn.prepareStatement(sql);
                                        stmt.setInt(1, userId);
                                        ResultSet rs = stmt.executeQuery();
                                        
                                        boolean hasChildren = false;
                                        while (rs.next()) {
                                            hasChildren = true;
                                            String childName = rs.getString("first_name") + " " + rs.getString("last_name");
                                            String ageGroup = rs.getString("age_group");
                                            Date dob = rs.getDate("date_of_birth");
                                            Date enrollmentDate = rs.getDate("enrollment_date");
                                            int childId = rs.getInt("id");
                                            %>
                                            <tr>
                                                <td><%= childName %></td>
                                                <td><%= ageGroup %></td>
                                                <td><%= dob %></td>
                                                <td><%= enrollmentDate %></td>
                                                <td>
                                                    <a href="child-details.jsp?id=<%= childId %>" class="btn btn-sm btn-primary">
                                                        <i class="bi bi-eye"></i> View
                                                    </a>
                                                </td>
                                            </tr>
                                            <%
                                        }
                                        
                                        if (!hasChildren) {
                                            %>
                                            <tr>
                                                <td colspan="5" class="text-center">No children registered</td>
                                            </tr>
                                            <%
                                        }
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                        %>
                                        <tr>
                                            <td colspan="5" class="text-center text-danger">Error loading children data: <%= e.getMessage() %></td>
                                        </tr>
                                        <%
                                    }
                                    %>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                
                <div class="card mb-4">
                    <div class="card-header">
                        <h4>Recent Activities</h4>
                    </div>
                    <div class="card-body">
                        <div class="list-group">
                            <% 
                            try (Connection conn = DatabaseUtil.getConnection()) {
                                String sql = "SELECT a.name, a.description, a.age_group " +
                                           "FROM activities a " + 
                                           "JOIN children c ON a.age_group = c.age_group " +
                                           "WHERE c.parent_id = ? " +
                                           "GROUP BY a.id " +
                                           "ORDER BY a.created_at DESC LIMIT 5";
                                
                                PreparedStatement stmt = conn.prepareStatement(sql);
                                stmt.setInt(1, userId);
                                ResultSet rs = stmt.executeQuery();
                                
                                boolean hasActivities = false;
                                while (rs.next()) {
                                    hasActivities = true;
                                    String activityName = rs.getString("name");
                                    String description = rs.getString("description");
                                    String ageGroup = rs.getString("age_group");
                                    %>
                                    <div class="list-group-item">
                                        <div class="d-flex w-100 justify-content-between">
                                            <h5 class="mb-1"><%= activityName %></h5>
                                            <small><%= ageGroup %></small>
                                        </div>
                                        <p class="mb-1"><%= description %></p>
                                    </div>
                                    <%
                                }
                                
                                if (!hasActivities) {
                                    %>
                                    <div class="list-group-item text-center">No recent activities</div>
                                    <%
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                                %>
                                <div class="list-group-item text-center text-danger">Error loading activities: <%= e.getMessage() %></div>
                                <%
                            }
                            %>
                        </div>
                    </div>
                    <div class="card-footer">
                        <a href="activities.jsp" class="btn btn-primary">View All Activities</a>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="card mb-4">
                    <div class="card-header">
                        <h4>Upcoming Payments</h4>
                    </div>
                    <div class="card-body">
                        <% 
                        try (Connection conn = DatabaseUtil.getConnection()) {
                            String sql = "SELECT p.amount, p.due_date, p.payment_status, c.first_name, c.last_name " +
                                       "FROM payments p " +
                                       "JOIN children c ON p.child_id = c.id " +
                                       "WHERE p.parent_id = ? AND p.payment_status = 'PENDING' " +
                                       "ORDER BY p.due_date ASC LIMIT 3";
                            
                            PreparedStatement stmt = conn.prepareStatement(sql);
                            stmt.setInt(1, userId);
                            ResultSet rs = stmt.executeQuery();
                            
                            boolean hasPayments = false;
                            while (rs.next()) {
                                hasPayments = true;
                                String childName = rs.getString("first_name") + " " + rs.getString("last_name");
                                double amount = rs.getDouble("amount");
                                Date dueDate = rs.getDate("due_date");
                                String status = rs.getString("payment_status");
                                %>
                                <div class="alert alert-warning">
                                    <h6><%= childName %></h6>
                                    <p>Amount: $<%= String.format("%.2f", amount) %><br>
                                    Due Date: <%= dueDate %><br>
                                    Status: <%= status %></p>
                                </div>
                                <%
                            }
                            
                            if (!hasPayments) {
                                %>
                                <div class="alert alert-success">No pending payments</div>
                                <%
                            }
                        } catch (Exception e) {
                            e.printStackTrace();
                            %>
                            <div class="alert alert-danger">Error loading payment data: <%= e.getMessage() %></div>
                            <%
                        }
                        %>
                        <a href="payments.jsp" class="btn btn-outline-primary">View All Payments</a>
                    </div>
                </div>
                
                <div class="card mb-4">
                    <div class="card-header">
                        <h4>Quick Links</h4>
                    </div>
                    <div class="card-body">
                        <div class="list-group">
                            <a href="messages.jsp?new=true" class="list-group-item list-group-item-action">
                                <i class="bi bi-chat-dots"></i> Send Message to Teacher
                            </a>
                            <a href="attendance.jsp" class="list-group-item list-group-item-action">
                                <i class="bi bi-calendar-check"></i> View Attendance
                            </a>
                            <a href="profile.jsp" class="list-group-item list-group-item-action">
                                <i class="bi bi-person"></i> Update Profile
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <footer class="bg-dark text-white mt-5 py-3">
        <div class="container text-center">
            <p>&copy; 2024 Smart Daycare System. All rights reserved.</p>
        </div>
    </footer>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 