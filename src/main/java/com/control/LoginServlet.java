package com.control;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import com.model.UserDatabase;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginSevlet
 */

@WebServlet("/LoginServlet")

public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
				
//				System.out.println("fname");
//				if(fname.length()!=0) {
//					response.sendRedirect("success.html");
//					return;
//				}
//				response.sendRedirect("index.html");
				
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String uname=request.getParameter("uname");
		String password=request.getParameter("pass");
        String role = request.getParameter("role");
		//to store dynnamic error
        
		List<String> errors=new ArrayList<>();
		if(uname.length()==0) {
			errors.add("enter username");
		}
		if(password.length()==0) {
			errors.add("Enter passowrd");
		}
		if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
		
		
		
		String fname;
		
				try {
					fname = new UserDatabase().checkUser(uname,password);
					if (fname == null) {
		                 errors.add("Incorrect username or password");
		                request.setAttribute("errors", errors);
		                request.getRequestDispatcher("login.jsp").forward(request, response);
		                return;
		            }

					
					
		            try {
		                Class.forName("com.mysql.cj.jdbc.Driver");
		                Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Library", "root", "Carmel@13");

		                String query = "SELECT id, role FROM user_details WHERE username = ? AND password = ? AND role = ?";
		                PreparedStatement pst = con.prepareStatement(query);
		                pst.setString(1, uname);
		                pst.setString(2, password);
		                pst.setString(3, role);

		                ResultSet rs = pst.executeQuery();

		                if (rs.next()) {
		                    int userId = rs.getInt("id");
		                    String userRole = rs.getString("role");

		                    HttpSession session = request.getSession();
		                    session.setAttribute("userId", userId);
		                    session.setAttribute("role", userRole);

		                    if ("admin".equals(userRole)) {
		                        response.sendRedirect("admin.jsp");
		                    } else {
		                        response.sendRedirect("dashboard.jsp");
		                    }
		                } else {
		                    request.setAttribute("errors", List.of("Invalid credentials or role selection."));
		                    request.getRequestDispatcher("login.jsp").forward(request, response);
		                }
		            }
		            catch(SQLException ex) {
		            	ex.printStackTrace();
		            }
				}
				catch (Exception e) {
				    e.printStackTrace();
				    request.setAttribute("errors", List.of("Database error: " + e.getMessage()));
				    request.getRequestDispatcher("login.jsp").forward(request, response);
				}
					
					}
}
