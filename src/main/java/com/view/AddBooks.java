package com.view;


import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

@WebServlet("/AddBooks")
@MultipartConfig(
    maxFileSize = 16177215, // 16MB
    fileSizeThreshold = 1024 * 1024 * 2, // 2MB before writing to disk
    maxRequestSize = 16177215, // 16MB total
    location = "C:/uploads" // Change this path
)
public class AddBooks extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public AddBooks() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        Integer userid = (Integer) session.getAttribute("userId");
        

        if (userid == null) {
            System.out.println("❌ userId is null! Ensure user is logged in.");
            response.sendRedirect("loginadv.jsp"); // Redirect to login page
            return;
        }

        String book = request.getParameter("bookname");
        String author = request.getParameter("author");
        String category = request.getParameter("category");
        Integer count = Integer.parseInt(request.getParameter("count"));
        Part imagePart = request.getPart("book_image");

        boolean success = false; // Track if everything runs successfully

        try (Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Library", "root", "Carmel@13")) {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String sql = "INSERT INTO books (title, author, category, avl_books, book_image) VALUES (?, ?, ?, ?, ?)";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setString(1, book);
            pst.setString(2, author);
            pst.setString(3, category);
            pst.setInt(4, count);

            if (imagePart != null && imagePart.getSize() > 0) {
                InputStream inputStream = imagePart.getInputStream();
                pst.setBlob(5, inputStream);
            } else {
                pst.setNull(5, java.sql.Types.BLOB);
            }

            int rowsInserted = pst.executeUpdate(); // Check if insert is successful

            if (rowsInserted > 0) {
                // Insert into report table
                String sql2 = "INSERT INTO report (user_id, action) VALUES (?, ?)";
                PreparedStatement pst2 = con.prepareStatement(sql2);
                pst2.setInt(1, userid);
                pst2.setString(2, "Added Book");
                pst2.executeUpdate();

                success = true; // Everything ran successfully
            }

        }  catch (ClassNotFoundException e) {
            System.out.println("❌ MySQL JDBC Driver Not Found!");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("❌ Connection Failed!");
            e.printStackTrace();
        }

        if (success) {
            response.sendRedirect("books.jsp"); // Redirect after successful insert
        }
    }
}
