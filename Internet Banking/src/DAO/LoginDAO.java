package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import nclass.MySQLConnector;

public class LoginDAO {
	Connection con = null;
	Statement st = null;
	ResultSet rs = null;
	PreparedStatement ps = null;
	String select_sql = "select * from ib.login where uname = ?";
	String insert_sql = "INSERT INTO `ib`.`login` (`uname`, `pass`, `type`) VALUES (?,?,?)";
	String count_sql = "select count(*)'count' from ib.login where uname = ?";
	String pass_sql = "select pass from ib.login where uname = ?";
	String delete_sql = "DELETE FROM `ib`.`login` WHERE (`uname` = ?)";
	String update_sql = "UPDATE `ib`.`login` SET `pass` = ? WHERE (`uname` = ?)";
	String deactivate_sql = "UPDATE `ib`.`login` SET `status` = 'inactive' WHERE (`uname` = ?)";
	String activeCusUname_sql = "SELECT `uname` FROM ib.login WHERE (`type` = 'c' AND `status` = 'active')";
	
	//retrieve active uname
	public ResultSet activeCusUname() {
		con = MySQLConnector.Connector();
		try {
			ps = con.prepareStatement(activeCusUname_sql);
			rs = ps.executeQuery();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}
	
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
	
	//retrieve
	public ResultSet retrieveData(String uname) {
		try {
			con = MySQLConnector.Connector();
			ps = con.prepareStatement(select_sql);
			ps.setString(1, uname);
			rs = ps.executeQuery();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}
	
	//retrieve password
	public String retrievePass(String uname) {
		String pass = null;
		con = MySQLConnector.Connector();
		try {
			ps = con.prepareStatement(pass_sql);
			ps.setString(1, uname);
			rs = ps.executeQuery();
			while(rs.next()) {
				pass = rs.getString("pass");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return pass;
	}
	
	//count
	public int countData(String uname) {
		con = MySQLConnector.Connector();
		int count = 0;
		try {
			ps = con.prepareStatement(count_sql);
			ps.setString(1, uname);
			rs = ps.executeQuery();
			while(rs.next()) {
				count = rs.getInt("count");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return count;
	}
	
	//insert
	public void insertData(String uname, String pass) {
		con = MySQLConnector.Connector();
		try {
			ps = con.prepareStatement(insert_sql);
			ps.setString(1, uname);
			ps.setString(2, pass);
			ps.setString(3, "c");
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
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
	
	//update
	public void updatePassword(String uname, String pass) {
		con = MySQLConnector.Connector();
		try {
			ps = con.prepareStatement(update_sql);
			ps.setString(1, pass);
			ps.setString(2, uname);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
