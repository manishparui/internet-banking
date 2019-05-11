package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import nclass.MySQLConnector;

public class AdminDAO {
	Connection con = null;
	Statement st = null;
	ResultSet rs = null;
	PreparedStatement ps = null;
	
	String select_sql = "SELECT * FROM ib.admin;";
	
	String update_sql = "UPDATE `ib`.`admin` SET `name` = ?, `phno` = ?, `email` = ?, `address` = ?, `dob` = ? WHERE (`uname` = ?)";
	
	//retrieve
	public ResultSet retrieveData() {
		con = MySQLConnector.Connector();
		try {
			ps=con.prepareStatement(select_sql);
			rs=ps.executeQuery();
		} catch(SQLException se){
			se.printStackTrace();
		}
		return rs;
	}
	
	//update
	public void updateData (String uname, String name, String phno, String email, String dob, String address) {
		con = MySQLConnector.Connector();
		try {
			ps = con.prepareStatement(update_sql);
			ps.setString(1, name);
			ps.setString(2, phno);
			ps.setString(3, email);
			ps.setString(4, address);
			ps.setString(5, dob);
			ps.setString(6, uname);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
