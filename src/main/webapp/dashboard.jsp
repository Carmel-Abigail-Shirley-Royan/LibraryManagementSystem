<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <title>Library Books</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body>
    <div class="container mt-4">
        <h2 class="text-center">Available Books</h2>
        <div class="row">
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Library", "root", "Carmel@13");
                    String sql = "SELECT book_id, title, author, avl_books FROM books WHERE avl_books > 0";
                    PreparedStatement pst = con.prepareStatement(sql);
                    ResultSet rs = pst.executeQuery();

                    while (rs.next()) {
                        int bookId = rs.getInt("book_id");
                        String title = rs.getString("title");
                        String author = rs.getString("author");
                        int available = rs.getInt("avl_books");
            %>
            <div class="col-md-3 mb-3">
                <div class="card" style="width: 201px;">
                    <img src="ImageServlet?book_id=<%= bookId %>" class="card-img-top" alt="Book Image" style="height: auto; width:200px; object-fit: contain;">
                    <div class="card-body">
                        <h5 class="card-title"><%= title %></h5>
                        <p class="card-text">Author: <%= author %></p>
                        <p class="card-text"><%= available %> copies left</p>
                                    <div class="d-flex gap-2">
                        
                        <form action="BorrowServlet" method="post">
                            <input type="hidden" name="book_id" value="<%= bookId %>">
                            <button type="submit" class="btn btn-primary">Borrow</button>
                        </form>
                        <form action="ReturnServlet" method="post">
                            <input type="hidden" name="book_id" value="<%= bookId %>">
                            <button type="submit" class="btn btn-primary">Return</button>
                        </form>
                        </div>
                    </div>
                </div>
            </div>
            <%
                    }
                } catch (Exception e) {
                    e.printStackTrace();
            %>
            <p class="text-danger">Error loading books. Please try again.</p>
            <%
                }
            %>
        </div>
<a href="loginadv.jsp" class="btn btn-primary text-decoration-none text-white">Logout</a>
    </div>
</body>
</html>
