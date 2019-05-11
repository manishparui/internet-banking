package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import nclass.MySQLConnector;

public class AccountsDAO {
	Connection con = null;
	Statement st = null;
	ResultSet rs = null;
	PreparedStatement ps = null;
	
	String accCount_sql = "SELECT *, count(*)'noofac' FROM ib.accounts where type = ? and uname = ?";
	String select_sql = "SELECT * FROM ib.accounts where type = ? and uname = ?";
	String insert_sql = "INSERT INTO `ib`.`accounts` (`uname`, `type`, `rate`, `nomonth`, `installment`, `balance`) VALUES (?, ?, ?, ?, ?, ?)";
	String delete_sql = "DELETE FROM `ib`.`accounts` WHERE (`acno` = ?)";
	String sbac_sql = "select acno from ib.accounts where type = ? and uname = ?";
	String balance_sql = "select balance from ib.accounts where acno = ?";
	String searchAcc_sql = "SELECT count(*)'x' FROM ib.accounts where acno = ?";
	String updateBaance_sql = "UPDATE `ib`.`accounts` SET `balance` = ? WHERE (`acno` = ?)";
	String allAccount_sql = "SELECT * FROM ib.accounts where type = ?";
	String update_sql = "UPDATE `ib`.`accounts` SET `balance` = ?, `rate` = ?, `status` = ? WHERE (`acno` = ?)";
	String insert_sql_adimn = "INSERT INTO `ib`.`accounts` (`uname`, `type`, `balance`, `rate`) VALUES (?, ?, ?, ?)";
	String allAcc_sql = "SELECT `acno`, `type` FROM `ib`.`accounts` WHERE `uname` = ?";
	String count_sql = "SELECT count(*)'total' FROM ib.accounts";
	String countType_sql = "SELECT count(*)'total' FROM ib.accounts WHERE(type = ?)";
	String deactivate_sql = "UPDATE `ib`.`accounts` SET `status` = 'inactive' WHERE (`uname` = ?)";
	String deactivateOne_sql = "UPDATE `ib`.`accounts` SET `status` = 'inactive' WHERE (`acno` = ?)";
	String status_sql = "SELECT `status` FROM `ib`.`accounts` WHERE (`acno` = ?)";
	String createsb_sql = "INSERT INTO `ib`.`accounts` (`uname`, `type`, `balance`) VALUES (?, ?, ?)";
	String latest_sql = "SELECT `acno` FROM ib.accounts WHERE(`uname` = ? AND `type` = ?) ORDER BY `acno` DESC LIMIT 1";
	
	//letest Account number
	public String latestAccNo (String uname, String type) {
		String acno = null;
		con = MySQLConnector.Connector();
		try {
			ps=con.prepareStatement(latest_sql);
			ps.setString(1, uname);
			ps.setString(2, type);
			rs=ps.executeQuery();
			while(rs.next()) {
				acno = rs.getString(1);
			}
		} catch(SQLException se){
			se.printStackTrace();
		}
		return acno;
	}
	
	//isActive
	public String isActive (String acno) {
		String status = null;
		int acn = Integer.parseInt(acno);
		con = MySQLConnector.Connector();
		try {
			con = MySQLConnector.Connector();
			ps=con.prepareStatement(status_sql);
			ps.setInt(1, acn);
			rs=ps.executeQuery();
			while(rs.next()) {
				status = rs.getString("status");
			}
		} catch(SQLException se){
			se.printStackTrace();
		}
		return status;
	}
	
	//deactivate
		public void deactivate (String uname) {
			con = MySQLConnector.Connector();
			try {
				ps = con.prepareStatement(deactivate_sql);
				ps.setString(1, uname);
				ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
		
		//deactivate
				public void deactivateOne (String acno) {
					int acn = Integer.parseInt(acno);
					con = MySQLConnector.Connector();
					try {
						ps = con.prepareStatement(deactivateOne_sql);
						ps.setInt(1, acn);
						ps.executeUpdate();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
	
	//count
		public int countData(String type, String uname) {
			int noofac = 0;
			try {
				con = MySQLConnector.Connector();
				ps=con.prepareStatement(accCount_sql);
				ps.setString(1, type);
				ps.setString(2, uname);
				rs=ps.executeQuery();
				while(rs.next()) {
					noofac = rs.getInt("noofac");
				}
			} catch(SQLException se){
				se.printStackTrace();
			}
			return noofac;
		}
		
		//count total
		public String countTotal() {
			String x = null;
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
		
		//count total type
				public String countTotal(String type) {
					String x = null;
					con = MySQLConnector.Connector();
					try {
						ps=con.prepareStatement(countType_sql);
						ps.setString(1, type);
						rs=ps.executeQuery();
						while(rs.next()) {
							x = rs.getString("total");
						}
					} catch(SQLException se){
						se.printStackTrace();
					}
					return x;
				}
		
	//search
		public int searchAccount(String acno) {
			int acn = Integer.parseInt(acno);
			int x = 0;
			con = MySQLConnector.Connector();
			try {
				ps=con.prepareStatement(searchAcc_sql);
				ps.setInt(1, acn);
				rs=ps.executeQuery();
				while(rs.next()) {
					x = rs.getInt("x");
				}
			} catch(SQLException se){
				se.printStackTrace();
			}
			return x;
		}
	
	//retrive
	public ResultSet retriveData(String type, String uname) {
		try {
			con = MySQLConnector.Connector();
			ps=con.prepareStatement(select_sql);
			ps.setString(1, type);
			ps.setString(2, uname);
			rs=ps.executeQuery();
		} catch(SQLException se){
			se.printStackTrace();
		}
		return rs;
	}
	
	//retrieve balance
	public float retrieveBalance(String acno) {
		int acn = Integer.parseInt(acno);
		float balance = 0;
		con = MySQLConnector.Connector();
		try {
			ps=con.prepareStatement(balance_sql);
			ps.setInt(1, acn);
			rs=ps.executeQuery();
			while(rs.next()) {
				balance = rs.getFloat("balance");
			}
		} catch(SQLException se){
			se.printStackTrace();
		}
		return balance;
	}
	
	//retrieve all
	public ResultSet retrieveAllAccount(String type) {
		con = MySQLConnector.Connector();
		try {
			ps=con.prepareStatement(allAccount_sql);
			ps.setString(1, type);
			rs=ps.executeQuery();
		} catch(SQLException se){
			se.printStackTrace();
		}
		return rs;
	}
	
	//retrieve sbacno
	public ResultSet retrieveAcno(String uname) {
		con = MySQLConnector.Connector();
		try {
			ps=con.prepareStatement(sbac_sql);
			ps.setString(1, "sb");
			ps.setString(2, uname);
			rs=ps.executeQuery();
		} catch(SQLException se){
			se.printStackTrace();
		}
		return rs;
	}
	
	//insert
	public void insertData (String type, String nomonth, float installment, float balance, String uname) {
		con = MySQLConnector.Connector();
		try {
			ps = con.prepareStatement(insert_sql);
			ps.setString(1, uname);
			ps.setString(2, type);
			ps.setString(3, "5");
			ps.setString(4, nomonth);
			ps.setFloat(5, installment);
			ps.setFloat(6, balance);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//insert
	public void insertData (String type, String uname) {
		con = MySQLConnector.Connector();
		try {
			ps = con.prepareStatement(createsb_sql);
			ps.setString(1, uname);
			ps.setString(2, type);
			ps.setFloat(3, 2000);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//insert admin
		public void insertData (String type, float balance, String rate, String uname) {
			con = MySQLConnector.Connector();
			try {
				ps = con.prepareStatement(insert_sql_adimn);
				ps.setString(1, uname);
				ps.setString(2, type);
				ps.setFloat(3, balance);
				ps.setString(4, rate);
				ps.executeUpdate();
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}
	
	//delete
	public void delData (String acno) {
		int acn = Integer.parseInt(acno);
		con = MySQLConnector.Connector();
		try {
			ps = con.prepareStatement(delete_sql);
			ps.setInt(1, acn);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//update balance
	public void updateBalance (String acno, float amount) {
		int acn = Integer.parseInt(acno);
		con = MySQLConnector.Connector();
		try {
			ps = con.prepareStatement(updateBaance_sql);
			ps.setFloat(1, amount);
			ps.setInt(2, acn);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//update
	public void updateData (String acno, String status, String balance, String rate) {
		int acn = Integer.parseInt(acno);
		con = MySQLConnector.Connector();
		try {
			ps = con.prepareStatement(update_sql);
			ps.setString(1, balance);
			ps.setString(2, rate);
			ps.setString(3, status);
			ps.setInt(4, acn);
			ps.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	//retrieve account number of all types
	public ResultSet retrieveAllAcno(String uname) {
		con = MySQLConnector.Connector();
		try {
			ps=con.prepareStatement(allAcc_sql);
			ps.setString(1, uname);
			rs=ps.executeQuery();
		} catch(SQLException se){
			se.printStackTrace();
		}
		return rs;
	}
}
