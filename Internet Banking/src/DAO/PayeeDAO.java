package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import com.mysql.jdbc.Statement;

import nclass.MySQLConnector;

public class PayeeDAO {
	Connection con = null;
	Statement st = null;
	ResultSet rs = null;
	PreparedStatement ps = null;
	String select_sql = "SELECT * FROM ib.payee where addby = ?";
	String insert_sql = "INSERT INTO `ib`.`payee` (`addby`, `acno`, `bankname`, `holdername`) VALUES (?,?,?,?)";
	String delete_sql = "";
	String count_sql = "SELECT *, count(*)'count' FROM ib.payee where addby = ?";
	
	//count
	public int countData(String addby) {
		int count = 0;
		try {
			con = MySQLConnector.Connector();
			ps=con.prepareStatement(count_sql);
			ps.setString(1, addby);
			rs=ps.executeQuery();
			while(rs.next()) {
				count = rs.getInt("count");
			}
		} catch(SQLException se){
			se.printStackTrace();
		}
		return count;
	}
	
	//retrieve
	public ResultSet retrieveData(String addby) {
		con = MySQLConnector.Connector();
		try {
			ps = con.prepareStatement(select_sql);
			ps.setString(1, addby);
			rs = ps.executeQuery();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return rs;
	}
	
	//insert
	public void insertData(String addby,String acno,String bankname,String holdername) {
		int acn = Integer.parseInt(acno);
		con = MySQLConnector.Connector();
		try {
			ps = con.prepareStatement(insert_sql);
			ps.setString(1, addby);
			ps.setInt(2, acn);
			ps.setString(3, bankname);
			ps.setString(4, holdername);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
