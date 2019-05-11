package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import nclass.MySQLConnector;

public class TransactionDAO {
	Connection con = null;
	Statement st = null;
	PreparedStatement ps = null;
	PreparedStatement ps0 = null;
	ResultSet rs = null;
	ResultSet rs0 = null;
	
	String insert_sql = "INSERT INTO `ib`.`transaction` (`from`, `to`, `amount`) VALUES (?,?,?)";
	String select_sql = "SELECT * FROM `ib`.`transaction` where (`from` = ? or `to` = ?) ORDER BY `datetime` DESC";
	String count_sql = "SELECT count(*)\"not\" FROM `ib`.`transaction` where `from` = ? or `to` = ?";
	String select5_sql = "SELECT * FROM `ib`.`transaction` WHERE (`from` = ? or `to` = ?) ORDER BY `datetime` DESC LIMIT 5";
	String selectAll_sql = "SELECT * FROM `ib`.`transaction` ORDER BY `datetime` DESC";
	
	//insert
	public void insertData (String form, String to, float amount) {
		int frm = Integer.parseInt(form);
		int too = Integer.parseInt(to);
		con = MySQLConnector.Connector();
		try {
			ps = con.prepareStatement(insert_sql);
			ps.setInt(1, frm);
			ps.setInt(2, too);
			ps.setFloat(3, amount);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//retrieve
	public ResultSet retriveData(String acno) {
		int acn = Integer.parseInt(acno);
		con = MySQLConnector.Connector();
		try {
			ps0=con.prepareStatement(select_sql);
			ps0.setInt(1, acn);
			ps0.setInt(2, acn);
			rs0=ps0.executeQuery();
		} catch(SQLException se){
			se.printStackTrace();
		}
		return rs0;
	}
	
	//count
	public int countData(String acno) {
		int acn = Integer.parseInt(acno);
		int x = 0;
		con = MySQLConnector.Connector();
		try {
			ps=con.prepareStatement(count_sql);
			ps.setInt(1, acn);
			ps.setInt(2, acn);
			rs=ps.executeQuery();
			while(rs.next()) {
				x = rs.getInt("not");
			}
		} catch(SQLException se){
			se.printStackTrace();
		}
		return x;
	}
	
	//retrieve5
		public ResultSet retrive5Data(String acno) {
			int acn = Integer.parseInt(acno);
			con = MySQLConnector.Connector();
			try {
				ps0=con.prepareStatement(select5_sql);
				ps0.setInt(1, acn);
				ps0.setInt(2, acn);
				rs0=ps0.executeQuery();
			} catch(SQLException se){
				se.printStackTrace();
			}
			return rs0;
		}
		
	//retrieve
		public ResultSet retriveAllData() {
			con = MySQLConnector.Connector();
			try {
				ps0=con.prepareStatement(selectAll_sql);
				rs0=ps0.executeQuery();
			} catch(SQLException se){
				se.printStackTrace();
			}
			return rs0;
		}
}
