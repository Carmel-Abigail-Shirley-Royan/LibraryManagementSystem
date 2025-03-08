<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="java.sql.*" %>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Return Books</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">

</head>
<body>
<body class="container mt-4">

    <h2 class="text-center">Borrowed Books</h2>

    <table class="table table-bordered">
        <thead class="table-dark">
            <tr>
                <th>Book ID</th>
                <th>Title</th>
                <th>Author</th>
                <th>Borrow Date</th>
                <th>Due Date</th>
                <th>Fine</th>
                <th>Return</th>
                
            </tr>
        </thead>
        <tbody>
            <% 
            HttpSession session1 = request.getSession();
            Integer userId = (Integer) session1.getAttribute("userId");

            if (userId != null) {
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Library", "root", "Carmel@13");

                    // Fetch books borrowed by the user
				String sql = "SELECT t.book_id, b.title, b.author, t.borrow_date, t.due_date, " +
		             "(SELECT fine_amt FROM fines f WHERE f.trans_id = t.trans_id) AS fine " +
		             "FROM transaction t " +
		             "JOIN books b ON t.book_id = b.book_id " +
		             "WHERE t.user_id = ? AND t.return_date IS NULL";
                    PreparedStatement pst = con.prepareStatement(sql);
                    pst.setInt(1, userId);
                    ResultSet rs = pst.executeQuery();
				if(rs.next()){
                    while (rs.next()) { 
                    	boolean hasRows=true;
            %>
          <tr>
                <td><%= rs.getInt("book_id") %></td>
                <td><%= rs.getString("title") %></td>
                <td><%= rs.getString("author") %></td>
                <td><%= rs.getDate("borrow_date") %></td>
                <td><%= rs.getDate("due_date") %></td>
                <td><%= (rs.getFloat("fine") > 0) ? "₹" + rs.getFloat("fine") : "No Fine" %></td>
                
                <td>
                    <form action="ReturnServlet" method="post">
                        <input type="hidden" name="book_id" value="<%= rs.getInt("book_id") %>">
                        <button type="submit" class="btn btn-danger">Return</button>
                    </form>
                </td>
            </tr>
            <% 
                    }
                    
				} else {
                out.println("<tr><td colspan='7' class='text-center'>No borrowed books found</td></tr>");
            }
                    
                    
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else {
                response.sendRedirect("login.jsp"); // Redirect to login if not logged in
            }
            %>
        </tbody>
    </table>

    <a href="dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>


</body>
</html>