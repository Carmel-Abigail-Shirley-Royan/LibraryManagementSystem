
package com.view;
import java.io.IOException;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.sql.Blob;
//import javax.servlet.ServletException;
//import javax.servlet.annotation.WebServlet;
//import javax.servlet.http.HttpServlet;
//import javax.servlet.http.HttpServletRequest;
//import javax.servlet.http.HttpServletResponse;

@WebServlet("/ImageServlet")
public class ImageServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int bookId = Integer.parseInt(request.getParameter("book_id"));
        
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Library", "root", "Carmel@13");

            String sql = "SELECT book_image FROM books WHERE book_id=?";
            PreparedStatement pst = con.prepareStatement(sql);
            pst.setInt(1, bookId);
            ResultSet rs = pst.executeQuery();

            if (rs.next()) {
                Blob blob = rs.getBlob("book_image");
                byte[] imageData = blob.getBytes(1, (int) blob.length());

                response.setContentType("image/jpeg");
                OutputStream os = response.getOutputStream();
                os.write(imageData);
                os.close();
            }
            con.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
