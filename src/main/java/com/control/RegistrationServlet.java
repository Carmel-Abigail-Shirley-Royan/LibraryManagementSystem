package com.control;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import com.model.UserData;
import com.model.UserDatabase;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RegistrationServlet
 */
@WebServlet("/RegistrationServlet")

public class RegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegistrationServlet() {
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
		String uname=request.getParameter("uname");
		String email = request.getParameter("email");
		String pass=request.getParameter("pass");
		String rpass=request.getParameter("rpass");
		String role=request.getParameter("role");
		if (!pass.equals(rpass)) {
		    request.setAttribute("message", "Passwords do not match!");
		    request.getRequestDispatcher("register.jsp").forward(request, response);
		    return;
		}
		
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Library", "root", "Carmel@13");
            String sql = "select * from user_details where username=? or email=?";
            PreparedStatement pst=con.prepareStatement(sql);
            pst.setString(1, uname);
            pst.setString(2, email);
            ResultSet rs=pst.executeQuery();
            if(rs.next()) {
            	request.setAttribute("message", "Username or email already exists!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
            
            String sql2="insert into user_details (username,email,password,role) values(?,?,?,?)";
            pst = con.prepareStatement(sql2);
            pst.setString(1, uname);
            pst.setString(2, email);
            pst.setString(3, pass);
            pst.setString(4, role);
            
            int res=pst.executeUpdate();
            if(res>0) {
            	response.sendRedirect("loginadv.jsp?success=registered");
            }
            else {
                request.setAttribute("message", "Registration failed. Try again!");
                request.getRequestDispatcher("register.jsp").forward(request, response);
                return;
            }
            
            String accCreation = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss"));
    		UserData user =new UserData(uname,email,rpass,role,accCreation);
    		UserDatabase ud= new UserDatabase();
    		ud.saveUser(user);
		}
		catch(SQLException ex) {
			ex.printStackTrace();
		}
		catch (ClassNotFoundException e) {
            e.printStackTrace();
            request.setAttribute("message", "Database error!");
            request.getRequestDispatcher("register.jsp").forward(request, response);
            return;
        }
		
		
		
	}

}
