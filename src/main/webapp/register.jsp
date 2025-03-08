<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List, java.sql.*" %>
<% 
String message = (String) request.getAttribute("message");
if (message != null) {
%>
    <p style="color: red;"><%= message %></p>
<% } %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>

<div class="container mt-4">
  <div class="card shadow p-4" style="max-width: 500px; margin: auto;">
    <h3 class="text-center mb-3">Registration</h3>
<form class="was-validated" action="RegistrationServlet" method="post">
      <div class="mb-3">
        <label for="validationText" class="form-label">User Name</label>
        <input name="uname" type="text" class="form-control" id="validationText" placeholder="Enter User Name" required>
        <div class="invalid-feedback">
         	Enter your name
        </div>
</div>
    
    <p>
      <div class="mb-3">
        <label for="validationEmail" class="form-label">Email</label>
        <input name="email" type="email" class="form-control" id="validationEmail" placeholder="Enter Mail ID" required>
        <div class="invalid-feedback">
         	Enter your mail
        </div>
</div>
    
 <div class="mb-3">
        <label for="validationPassword" class="form-label">Password</label>
        <input name="pass" type="password" class="form-control" id="validationPassword" placeholder="Enter password" required>
        <div class="invalid-feedback">
         	Enter your Password
        </div>
      </div>
 <div class="mb-3">
        <label for="validationPassword" class="form-label">Retype Password</label>
        <input name="rpass" type="password" class="form-control" id="validationPassword" placeholder="Enter password" required>
        <div class="invalid-feedback">
         	Retype your Password
        </div>
    </div>
<div class="mb-3">
	Role
	
    <select name="role" class="form-select" required aria-label="select example">
      <option value="">Select</option>
      <option value="member">Member</option>
      <option value="admin">Admin</option>
    </select>
    <div class="invalid-feedback">Select Role</div>
  </div>
     <div class="mb-3">
     <form class="was-validated" action="RegistrationServlet" method="post">
    <button value="Register" class="btn btn-primary" type="submit">Register</button>
  </form>
  </div>
</form>
</div>
</div>
</body>
</html>
