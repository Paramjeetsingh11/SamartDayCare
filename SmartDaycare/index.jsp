<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Smart Daycare System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="#">Smart Daycare</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp">Login</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="enrollment.jsp">Enrollment</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <div class="row">
            <div class="col-md-12 text-center">
                <h1>Welcome to Smart Daycare System</h1>
                <p class="lead">Providing quality childcare with modern technology</p>
            </div>
        </div>

        <div class="row mt-4">
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Parent Portal</h5>
                        <p class="card-text">Access your child's daily activities, schedules, and reports.</p>
                        <a href="login.jsp" class="btn btn-primary">Login as Parent</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">Teacher Portal</h5>
                        <p class="card-text">Manage activities, attendance, and child progress reports.</p>
                        <a href="login.jsp" class="btn btn-primary">Login as Teacher</a>
                    </div>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-body">
                        <h5 class="card-title">New Enrollment</h5>
                        <p class="card-text">Register your child in our daycare program.</p>
                        <a href="enrollment.jsp" class="btn btn-primary">Enroll Now</a>
                    </div>
                </div>
            </div>
        </div>

        <div class="row mt-5">
            <div class="col-md-6">
                <h3>Our Features</h3>
                <ul class="list-group">
                    <li class="list-group-item">Real-time activity tracking</li>
                    <li class="list-group-item">Secure video monitoring</li>
                    <li class="list-group-item">Daily progress reports</li>
                    <li class="list-group-item">Age-appropriate activities</li>
                    <li class="list-group-item">Professional care providers</li>
                </ul>
            </div>
            <div class="col-md-6">
                <h3>Contact Us</h3>
                <form action="contact" method="post">
                    <div class="mb-3">
                        <input type="text" class="form-control" name="name" placeholder="Your Name" required>
                    </div>
                    <div class="mb-3">
                        <input type="email" class="form-control" name="email" placeholder="Your Email" required>
                    </div>
                    <div class="mb-3">
                        <textarea class="form-control" name="message" rows="3" placeholder="Your Message" required></textarea>
                    </div>
                    <button type="submit" class="btn btn-primary">Send Message</button>
                </form>
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