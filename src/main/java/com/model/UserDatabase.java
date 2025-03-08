package com.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDatabase {
	public static String url = "jdbc:mysql://localhost:3306/UserDetails"; // Change "Student" if needed
	public static String user = "root"; // Your MySQL username
	public static String password = "Carmel@13";

	String fname="";
	public UserDatabase() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection con=DriverManager.getConnection(url,user,password);
		}
		catch(ClassNotFoundException e) {
			e.printStackTrace();
		}
		catch(SQLException ex) {
			ex.printStackTrace();
		}
	}
	public String checkUser(String uname,String password) throws SQLException {
		
		String sql="select username from user_details where username=? and password=?";
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Library", "root", "Carmel@13");

		PreparedStatement pst=con.prepareStatement(sql);
		pst.setString(1, uname);
		pst.setString(2, password);
		ResultSet rs=pst.executeQuery();
		if(rs.next()) {
			fname=rs.getString(1);
			return fname;

		}
		return null;
	}
	public void saveUser(UserData user) {
		String sql = "insert into userdata(usernmae,email,password,role,acc_creation) values(?,?,?,?,?)";
		try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/Library", "root", "Carmel@13");

			PreparedStatement pst=con.prepareStatement(sql);
			pst.setString(1, user.getUsername());
			pst.setString(2,user.getEmail());
			pst.setString(3, user.getPassword());
			pst.setString(4, user.getRole());
			pst.setString(5, user.getAccCreation());
			
			int result = pst.executeUpdate();
			if(result>0) {
				System.out.println("Data Stored");
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
	}

//	public ResultSet listUser() {
//		return rs;
//	}
}
