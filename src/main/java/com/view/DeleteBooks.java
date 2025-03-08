package com.view;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

/**
 * Servlet implementation class DeleteBooks
 */

@WebServlet("/DeleteBooks")

public class DeleteBooks extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DeleteBooks() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session = request.getSession();
        Integer userid = (Integer) session.getAttribute("userId"); 
        int bookid = Integer.parseInt(request.getParameter("book_id"));

        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Library", "root", "Carmel@13");
            String sql="delete from books where book_id=?";
            PreparedStatement pst=con.prepareStatement(sql);
            pst.setInt(1, bookid);
            pst.executeUpdate();
            
            String sql2="insert into report(user_id,action) values(?,?)";
            PreparedStatement pst2=con.prepareStatement(sql2);
            pst2.setInt(1, userid);
            pst2.setString(2, "Deleted Book");
            pst2.executeUpdate();

            response.sendRedirect("admin.jsp");

            
        
        }
        catch(Exception e) {
        	e.printStackTrace();
        }
	}

}
