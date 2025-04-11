<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Enrollment - Smart Daycare System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="css/style.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
        <div class="container">
            <a class="navbar-brand" href="index.jsp">Smart Daycare</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="login.jsp">Login</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-md-8">
                <div class="card">
                    <div class="card-body">
                        <h3 class="card-title text-center mb-4">Child Enrollment Form</h3>
                        
                        <% if (request.getAttribute("error") != null) { %>
                            <div class="alert alert-danger">
                                <%= request.getAttribute("error") %>
                            </div>
                        <% } %>
                        
                        <% if (request.getAttribute("success") != null) { %>
                            <div class="alert alert-success">
                                <%= request.getAttribute("success") %>
                            </div>
                        <% } %>

                        <form action="enroll" method="post" class="needs-validation" novalidate>
                            <!-- Parent Information -->
                            <h5 class="mb-3">Parent Information</h5>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="parentFirstName" class="form-label">First Name</label>
                                    <input type="text" class="form-control" id="parentFirstName" name="parentFirstName" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="parentLastName" class="form-label">Last Name</label>
                                    <input type="text" class="form-control" id="parentLastName" name="parentLastName" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="email" class="form-label">Email</label>
                                    <input type="email" class="form-control" id="email" name="email" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="phone" class="form-label">Phone Number</label>
                                    <input type="tel" class="form-control" id="phone" name="phone" required>
                                </div>
                            </div>

                            <!-- Child Information -->
                            <h5 class="mb-3 mt-4">Child Information</h5>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="childFirstName" class="form-label">First Name</label>
                                    <input type="text" class="form-control" id="childFirstName" name="childFirstName" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="childLastName" class="form-label">Last Name</label>
                                    <input type="text" class="form-control" id="childLastName" name="childLastName" required>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="dateOfBirth" class="form-label">Date of Birth</label>
                                    <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="ageGroup" class="form-label">Age Group</label>
                                    <select class="form-select" id="ageGroup" name="ageGroup" required>
                                        <option value="">Select Age Group</option>
                                        <option value="INFANT">Infant (0-1 years)</option>
                                        <option value="TODDLER">Toddler (1-3 years)</option>
                                        <option value="PRESCHOOL">Preschool (3-5 years)</option>
                                    </select>
                                </div>
                            </div>

                            <!-- Emergency Contact -->
                            <h5 class="mb-3 mt-4">Emergency Contact</h5>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="emergencyContact" class="form-label">Emergency Contact Name</label>
                                    <input type="text" class="form-control" id="emergencyContact" name="emergencyContact" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="emergencyPhone" class="form-label">Emergency Contact Phone</label>
                                    <input type="tel" class="form-control" id="emergencyPhone" name="emergencyPhone" required>
                                </div>
                            </div>

                            <!-- Medical Information -->
                            <div class="mb-3">
                                <label for="medicalInfo" class="form-label">Medical Information (Allergies, Special Needs, etc.)</label>
                                <textarea class="form-control" id="medicalInfo" name="medicalInfo" rows="3"></textarea>
                            </div>

                            <!-- Account Setup -->
                            <h5 class="mb-3 mt-4">Account Setup</h5>
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label for="username" class="form-label">Username</label>
                                    <input type="text" class="form-control" id="username" name="username" required>
                                </div>
                                <div class="col-md-6 mb-3">
                                    <label for="password" class="form-label">Password</label>
                                    <input type="password" class="form-control" id="password" name="password" required>
                                </div>
                            </div>

                            <div class="d-grid gap-2 mt-4">
                                <button type="submit" class="btn btn-primary">Submit Enrollment</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
    <script>
        // Form validation
        (function () {
            'use strict'
            var forms = document.querySelectorAll('.needs-validation')
            Array.prototype.slice.call(forms)
                .forEach(function (form) {
                    form.addEventListener('submit', function (event) {
                        if (!form.checkValidity()) {
                            event.preventDefault()
                            event.stopPropagation()
                        }
                        form.classList.add('was-validated')
                    }, false)
                })
        })()
    </script>
</body>
</html> 