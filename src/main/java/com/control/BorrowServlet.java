package com.control;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Servlet implementation class BorrowServlet
 */

@WebServlet("/BorrowServlet")

public class BorrowServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public BorrowServlet() {
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
        
        if(userid==null) {
        	response.sendRedirect("login.jsp");
        	return;
        }
        else {

        	try {
        		Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Library", "root", "Carmel@13");
                
                String checkbookcount="select book_id from transaction where user_id=? and return_date is null";
                PreparedStatement check=con.prepareStatement(checkbookcount);
                check.setInt(1, userid);
                ResultSet rs=check.executeQuery();
                int currbook=-1;
                boolean canBorrow=true;
                while(rs.next()) {
                	currbook=rs.getInt("book_id");
                	if(currbook==bookid) {
                		canBorrow=false;
                		break;
                	}
                	
                	
                }
                if (!canBorrow) {
                    response.setContentType("text/html");
                    PrintWriter out = response.getWriter();
                    out.println("<script type='text/javascript'>");
                    out.println("alert('You can only borrow one book at a time.');");
                    out.println("window.history.back();");  // Takes the user back to the previous page
                    out.println("</script>");
                    out.close();
                    return;
                }

                
                
                String sql="insert into transaction(user_id,book_id,borrow_date,due_date) values(?,?,now(),date_add(now(),interval 30 day))";
                PreparedStatement pst = con.prepareStatement(sql);
                pst.setInt(1, userid);
                pst.setInt(2, bookid);
                pst.executeUpdate();
                
                
                String sql2="update books set avl_books=avl_books-1 where book_id=?";
                PreparedStatement pst2=con.prepareStatement(sql2);
                pst2.setInt(1, bookid);
                pst2.executeUpdate();
                
                
                String sql3="insert into report (user_id,action) values(?,?)";
                PreparedStatement pst3=con.prepareStatement(sql3);
                pst3.setInt(1, userid);
                pst3.setString(2, "Borrowed bookid "+bookid);
                pst3.executeUpdate();
                
                
                response.sendRedirect("dashboard.jsp");
        	
        	}
        	catch(ClassNotFoundException | SQLException e) {
                    e.printStackTrace();
                    
        	}
        }
	}

}
