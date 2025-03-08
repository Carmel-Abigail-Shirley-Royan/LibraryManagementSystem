<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Users</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
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
    <h2 class="text-center">Manage Users</h2>
    
    <table class="table table-bordered">
        <thead class="table-dark">
            <tr>
                <th>User ID</th>
                <th>User Name</th>
                <th>Email</th>
                <th>Role</th>
                <th>Account Creation Date</th>
                <th>Books Borrowed</th>
                <th>Books Returned</th>
                <th>Total Fines</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <% 
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                int curr_user= (Integer) session.getAttribute("userId");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Library", "root", "Carmel@13");
                String sql = "SELECT u.id, u.username, u.email, u.role, u.acc_creation, " +
                             "(SELECT COUNT(*) FROM transaction t WHERE t.user_id = u.id AND t.status = 'borrowed') AS books_borrowed, " +
                             "(SELECT COUNT(*) FROM transaction t WHERE t.user_id = u.id AND t.status = 'returned') AS books_returned, " +
                             "(SELECT SUM(f.fine_amt) FROM fines f WHERE f.user_id = u.id) AS total_fines " +
                             "FROM user_details u where id!=?";
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setInt(1,curr_user);
                ResultSet rs = pst.executeQuery();
                while (rs.next()) { 
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("username") %></td>
                <td><%= rs.getString("email") %></td>
                <td><%= rs.getString("role") %></td>
                <td><%= rs.getTimestamp("acc_creation") %></td>
                <td><%= rs.getInt("books_borrowed") %></td>
                <td><%= rs.getInt("books_returned") %></td>
                <td><%= rs.getFloat("total_fines") %></td>
                <td>
                    <form action="DeleteUser" method="post">
                        <input type="hidden" name="user_id" value="<%= rs.getInt("id") %>">
                        <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this user?');">Delete</button>
                    </form>
                </td>
            </tr>
            <% 
                }
                con.close();
            } catch (Exception e) {
                e.printStackTrace();
            } 
            %>
        </tbody>
    </table>

    <form action="admin.jsp" method="get">
        <button type="submit" class="btn btn-warning">Return To Dashboard</button>
    </form>

</body>
</html>
