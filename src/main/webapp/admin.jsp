<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">
    
</head>
<body class="container mt-4">
<nav class="navbar navbar-expand-lg" style="background-color: #FFF0F5;">
    <div class="container-fluid">
        <a class="navbar-brand" href="addbooks.jsp"><i class="bi bi-book"></i> Add Books</a>
        <a class="navbar-brand" href="user.jsp"><i class="bi bi-people"></i> Manage Users</a>
        <a class="navbar-brand" href="books.jsp"><i class="bi bi-collection"></i> Books</a>
        <a class="navbar-brand" href="admin.jsp"><i class="bi bi-receipt"></i> Transaction History</a>
    </div>
</nav>
    <h2 class="text-center">Transaction History</h2>
    
    <table class="table table-bordered">
        <thead class="table-dark">
        <tr>
            <th>Report ID</th>
            <th>Username</th>
            <th>Action</th>
            <th>Action time</th>
            <th>Due Date</th>
            <th>Return Date</th>
            <th>Status</th>
        </tr>
        </thead>
        <tbody>
        <%
            
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Library", "root", "Carmel@13");
                String sql = "select distinct r.report_id,u.username, r.action,"+
                	   " r.action_time, t.due_date, t.return_date, t.status"+
                	" from report r join transaction t on r.user_id = t.user_id"+
                	" join user_details u on r.user_id = u.id";
                PreparedStatement pst = con.prepareStatement(sql);
                ResultSet rs = pst.executeQuery();
                while (rs.next()) {
        %>
        <tr>
            <td><%= rs.getInt("report_id") %></td>
            <td><%= rs.getString("username") %></td>
            <td><%= rs.getString("action") %></td>
            <td><%= rs.getTimestamp("action_time") %></td>
             <td><%= rs.getDate("due_date") %></td>
             <td><%= rs.getDate("return_date") %></td>
             <td><%= rs.getString("status") %></td>
            
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
            } 
        %>
        </tbody>
    </table>
<a href="loginadv.jsp" class="btn btn-primary text-decoration-none text-white">Logout</a>

</body>
</html>
