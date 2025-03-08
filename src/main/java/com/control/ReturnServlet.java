package com.control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;

import com.mysql.cj.xdevapi.Result;

/**
 * Servlet implementation class ReturnServlet
 */
@WebServlet("/ReturnServlet")

public class ReturnServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ReturnServlet() {
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
	      if(userid==null){
	    	 response.sendRedirect("login.jsp");
	    	 return;
	      }

	      
	      try {
	    	  Class.forName("com.mysql.cj.jdbc.Driver");
	    	  Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/Library","root","Carmel@13");
//	    	  con.setAutoCommit(false);
//	    	  String sql="select trans_id,due_date from transaction where user_id=? and book_id=? and return_date is null";
//	    	  PreparedStatement pst=con.prepareStatement(sql);
//	    	  pst.setInt(1, userid);
//	    	  pst.setInt(2, bookid);
//	    	  ResultSet rs= pst.executeQuery();
	    	  
	    	  String sql="update transaction set return_date=now() where user_id=? and book_id=? and return_date is null";
    		  PreparedStatement pst=con.prepareStatement(sql);
    		  pst.setInt(1, userid);
    		  pst.setInt(2,bookid);
    		  int row =pst.executeUpdate();
	    	  if(row==0) {
	    		  request.setAttribute("error", "No active borrow record found for this book.");
	                request.getRequestDispatcher("return.jsp").forward(request, response);
	                return;
	    	  }
	    	  String sql2="update books set avl_books=avl_books+1 where book_id=?";
    		  PreparedStatement pst2=con.prepareStatement(sql2);
    		  pst2.setInt(1, bookid);
    		  pst2.executeUpdate();
	    		  
    		  String sql3="insert into report (user_id,action) values(?,?)";
              PreparedStatement pst3=con.prepareStatement(sql3);
              pst3.setInt(1, userid);
              pst3.setString(2, "Returned bookid "+bookid);
              pst3.executeUpdate();  
	                
	    	  String sql4="select trans_id,due_date from transaction where user_id=? and book_id=?";
              PreparedStatement pst4=con.prepareStatement(sql4);
              pst4.setInt(1, userid);
              pst4.setInt(2, bookid);
              ResultSet rs= pst4.executeQuery();
	    	  
//	    	  LocalDate today = LocalDate.now();
//    		  LocalDate duedate = rs.getDate("due_date").toLocalDate();
//    		  if (today.isAfter(duedate)) {
//                    String sql5 = "insert into fines (user_id, trans_id) into (?, ?)";
//                    PreparedStatement pst5 = con.prepareStatement(sql5);
//                    pst5.setInt(1, userid);
//                    pst5.setInt(2, rs.getInt("trans_id"));
//                    pst5.executeUpdate();
//                }

			if (rs.next()) {
			    int transId = rs.getInt("trans_id");
			    LocalDate dueDate = rs.getDate("due_date").toLocalDate();
			    LocalDate today = LocalDate.now();
			
			    if (today.isAfter(dueDate)) {
			        int fineAmount = 1000; // Fixed fine amount
			        String sql5 = "INSERT INTO fines (user_id, trans_id, fine_amount) VALUES (?, ?, ?)";
			        PreparedStatement pst5 = con.prepareStatement(sql5);
			        pst5.setInt(1, userid);
			        pst5.setInt(2, transId);
			        pst5.setInt(3, fineAmount);
			        pst5.executeUpdate();
			    }
			}
	    		  
	    	  
	    	  
              response.sendRedirect("dashboard.jsp");

	      }
	      catch(ClassNotFoundException | SQLException e) {
				e.printStackTrace();

	      } 

	}

}
