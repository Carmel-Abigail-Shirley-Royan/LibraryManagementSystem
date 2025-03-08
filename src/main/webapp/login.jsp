<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.util.List" %> <!-- Import List -->
    <%@ page import="com.model.UserDatabase" %>

<%
    if (session.getAttribute("user") != null) {
        String role = (String) session.getAttribute("role");
        session.invalidate();
        if(role!=null){
        if ("admin".equals(role)) {
            response.sendRedirect("admin.jsp");
        } else {
            response.sendRedirect("dashboard.jsp");
        }}
    }
%>
    <%
    String successMessage = request.getParameter("success");
    if ("registered".equals(successMessage)) {
%>
    <p style="color: green;">Registration successful! Please log in.</p>
<%
    }
%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

</head>
<body>
<%
 List<String> errors = (List<String>) request.getAttribute("errors");
if(errors!=null){
  %>
        <h2>Errors</h2>
        <font color='red'> 
	        <ul>
	        <%for (String error : errors) {
	        %>
	        <li><%= error %></li>
	        <% } %>
        </ul>
        </font>
        <% } %>
        
<div class="container mt-4">
  <div class="card shadow p-4" style="max-width: 500px; margin: auto;">
    <h3 class="text-center mb-3">User Login</h3>
<form class="was-validated" action="LoginServlet" method="post">
      <div class="mb-3">
        <label for="validationText" class="form-label">User Name</label>
        <input name="uname" type="text" class="form-control" id="validationText" placeholder="Enter User Name" required>
        <div class="invalid-feedback">
         	Enter your name
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
	Role
	
    <select name="role" class="form-select" required aria-label="select example">
      <option value="">Select</option>
      <option value="member">Member</option>
      <option value="admin">Admin</option>
    </select>
    <div class="invalid-feedback">Select Role</div>
  </div>
  <div class="mb-3">
    <button value="Sign in" class="btn btn-primary" type="submit">Login</button>
  </div>
</form>
<form>Click Here for 
<a href="register.jsp">Registration</a>
    
</form>
</div>
</div>


</body>
</html>