<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login Form</title>
    <!-- Bootstrap CDN -->
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        .card {
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(25, 24, 24, 0.2);
        }
    </style>
</head>

<body>

    <div class="container min-vh-100 py-5">
        <div class="row justify-content-center">
            <div class="col-lg-6 col-md-8 col-sm-12">
                <div class="card p-4">
                    <div class="row g-3 align-items-center">
                        <!-- Image -->
                        <div class="col-md-6 text-center">
                            <img src="<%= request.getContextPath() %>/img/signin-image.jpg" class="img-fluid"
                                alt="Login Image">
                            <div>
                                <a href="registeradv.jsp" class="create-account-link">Create Account</a>
                            </div>

                        </div>
                        <!-- Form -->

                        <div class="col-md-6">
                            <form action="LoginServlet" method="post" class="needs-validation" novalidate>

                                <h4 class="text-center">Login</h4>
                                <div class="mb-3">
                                    <label for="uname">
                                        <img src="<%= request.getContextPath() %>/img/person.png" alt="person icon"
                                            height="10px" width="auto">
                                    </label>

                                    <input type="text" name="uname" id="uname" class="form-control"
                                        placeholder="User Name" required>
                                    <div class="invalid-feedback">
                                        Enter your name
                                    </div>

                                </div>
                                <div class="mb-3">
                                    <label for="ppass">
                                        <img src="<%= request.getContextPath() %>/img/email.jpeg" alt="lock icon"
                                            height="20px" width="auto">
                                    </label>
                                    <input type="email" name="email" id="ppass" class="form-control"
                                        placeholder="Mail Id" required>
                                    <div class="invalid-feedback">
                                        Enter your Mail
                                    </div>
                                </div>

                                <div class="mb-3">
                                    <label for="pass">
                                        <img src="<%= request.getContextPath() %>/img/lock.jpeg" alt="lock icon"
                                            height="20px" width="auto">
                                    </label>
                                    <input type="password" name="pass" id="pass" class="form-control"
                                        placeholder="Password" required>
                                    <div class="invalid-feedback">
                                        Enter your password
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="role">
                                        <i class="bi bi-check2-square"></i>
                                    </label>
                                    <select name="role" id="role" class="form-select" required>
                                        <option value="">Select</option>
                                        <option value="member">Member</option>
                                        <option value="admin">Admin</option>
                                    </select>
                                    <div class="invalid-feedback">
                                        Select a role
                                    </div>
                                </div>

                                <div class="form-check mb-3">
                                    <input type="checkbox" class="form-check-input" id="agree" required>
                                    <label class="form-check-label" for="agree">
                                        I agree to all statements in <a href="">Terms of service</a>
                                    </label>
                                    <div class="invalid-feedback">
                                        You must agree before submitting.
                                    </div>
                                </div>

                                <div>
                                    <button type="submit" class="btn btn-primary w-100">Login</button>

                                </div>
                            </form>
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