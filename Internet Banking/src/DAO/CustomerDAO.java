package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import nclass.MySQLConnector;

public class CustomerDAO {
	Connection con = null;
	Statement st = null;
	ResultSet rs = null;
	PreparedStatement ps = null;
	String insert_sql = "INSERT INTO `ib`.`customar` (`uname`, `holdername`, `dob`, `address`, `phno`, `email`) VALUES (?,?,?,?,?,?)";
	String select_sql = "SELECT * FROM ib.customar";
	String delete_sql = "DELETE FROM `ib`.`customar` WHERE (`uname` = ?)";
	String update_sql = "UPDATE `ib`.`customar` SET `holdername` = ?, `dob` = ?, `address` = ?, `phno` = ?, `email` = ? WHERE (`uname` = ?)";
	String selectOne_sql = "SELECT * FROM `ib`.`customar` WHERE (`uname` = ?)";
	String count_sql = "SELECT count(*)'total' FROM ib.customar;";
	String deactivate_sql = "UPDATE `ib`.`customar` SET `status` = 'inactive' WHERE (`uname` = ?)";
	
	//deactivate
		public void deactivate(String uname) {
			con = MySQLConnector.Connector();
			try {
				ps = con.prepareStatement(deactivate_sql);
				ps.setString(1, uname);
				ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	
	//insert
	public void insertData(String uname, String name, String phno, String email, String dob, String address) {
		con = MySQLConnector.Connector();
		try {
			ps = con.prepareStatement(insert_sql);
			ps.setString(1, uname);
			ps.setString(2, name);
			ps.setString(3, dob);
			ps.setString(4, address);
			ps.setString(5, phno);
			ps.setString(6, email);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//count
	public String countData() {
		String x = "";
		con = MySQLConnector.Connector();
		try {
			ps=con.prepareStatement(count_sql);
			rs=ps.executeQuery();
			while(rs.next()) {
				x = rs.getString("total");
			}
		} catch(SQLException se){
			se.printStackTrace();
		}
		return x;
	}
	
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
	
	//retrieve one
		public ResultSet retrieveData(String uname) {
			con = MySQLConnector.Connector();
			try {
				ps=con.prepareStatement(selectOne_sql);
				ps.setString(1, uname);
				rs=ps.executeQuery();
			} catch(SQLException se){
				se.printStackTrace();
			}
			return rs;
		}
	
	//delete
	public void delData (String uname) {
		con = MySQLConnector.Connector();
		try {
			ps = con.prepareStatement(delete_sql);
			ps.setString(1, uname);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//"UPDATE `ib`.`customar` SET `holdername` = ?, `dob` = ?, `address` = ?, `phno` = ?, `email` = ? WHERE (`uname` = ?)";
	//update
	public void updateData (String uname, String name, String phno, String email, String dob, String address) {
		con = MySQLConnector.Connector();
		try {
			ps = con.prepareStatement(update_sql);
			ps.setString(1, name);
			ps.setString(2, dob);
			ps.setString(3, address);
			ps.setString(4, phno);
			ps.setString(5, email);
			ps.setString(6, uname);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
