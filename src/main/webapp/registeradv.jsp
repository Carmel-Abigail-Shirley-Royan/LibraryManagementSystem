<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Register</title>
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    <style>
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(25, 24, 24, 0.2);
            padding: 20px;
            height: 100%;
        }
        .signup-image {
            max-width: 100%;
            height: auto;
        }
    </style>
</head>
<body>

<div class="container d-flex justify-content-center align-items-center min-vh-100 py-3">
    <div class="row w-100 justify-content-center">
        <div class="col-lg-8 col-md-10 col-sm-12">
            <div class="card p-4">
                <h1 class="text-center mb-4"><strong>Register</strong></h1>
                <div class="row g-3">
                    <!-- Form Section -->
                    <div class="col-md-6">
                        <form action="RegistrationServlet" method="post" class="needs-validation" novalidate>
                            <div class="mb-3">
                                <label for="uname" class="form-label">
                                    <img src="<%= request.getContextPath() %>/img/person.png" alt="Person Icon" height="20px">
                                    Your Name
                                </label>
                                <input type="text" id="uname" name="uname" class="form-control" placeholder="Enter your name" required>
                                <div class="invalid-feedback">Please enter your name.</div>
                            </div>
                            <div class="mb-3">
                                <label for="email" class="form-label">
                                    <img src="<%= request.getContextPath() %>/img/email.jpeg" alt="Email Icon" height="20px">
                                    Email
                                </label>
                                <input type="email" id="email" name="email" class="form-control" placeholder="Enter your email" required>
                                <div class="invalid-feedback">Please enter a valid email.</div>
                            </div>
                            <div class="mb-3">
                                <label for="pass" class="form-label">
                                    <img src="<%= request.getContextPath() %>/img/lock.jpeg" alt="Lock Icon" height="20px">
                                    Password
                                </label>
                                <input type="password" id="pass" name="pass" class="form-control" placeholder="Password" required>
                                <div class="invalid-feedback">Please enter a password.</div>
                            </div>
                            <div class="mb-3">
                                <label for="rpass" class="form-label">
                                    <img src="<%= request.getContextPath() %>/img/lock.jpeg" alt="Lock Icon" height="20px">
                                    Confirm Password
                                </label>
                                <input type="password" id="rpass" name="rpass" class="form-control" placeholder="Confirm Password" required>
                                <div class="invalid-feedback">Passwords must match.</div>
                            </div>
                            <div class="mb-3">
                                <label for="role" class="form-label">
                                    <i class="bi bi-check2-square"></i> Role
                                </label>
                                <select id="role" name="role" class="form-select" required>
                                    <option value="">Select</option>
                                    <option value="member">Member</option>
                                    <option value="admin">Admin</option>
                                </select>
                                <div class="invalid-feedback">Please select a role.</div>
                            </div>
                            <div class="form-check mb-3">
                                <input type="checkbox" id="agree" name="agree" class="form-check-input" required>
                                <label class="form-check-label" for="agree">
                                    I agree to all statements in <a href="#">Terms of Service</a>
                                </label>
                                <div class="invalid-feedback">You must agree before submitting.</div>
                            </div>
                            <button type="submit" class="btn btn-primary w-100">Register</button>
                        </form>
                    </div>

                    <!-- Image Section -->
                    <div class="col-md-6 text-center">
                        <img src="<%= request.getContextPath() %>/img/signup-image.jpg" alt="Sign Up Image" class="signup-image rounded mb-3">
                        <div><a href="loginadv.jsp" class="create-account-link">Already a member? Log in</a></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</body>
</html>
