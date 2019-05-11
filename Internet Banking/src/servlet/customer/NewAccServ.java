package servlet.customer;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.AccountsDAO;
import DAO.TransactionDAO;

/**
 * Servlet implementation class NewAccServ
 */
public class NewAccServ extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
		response.setHeader("Pragma", "no-cache");
		response.setHeader("Expires", "0");
		
		HttpSession session = request.getSession(false);
		String check = session.getAttribute("uname").toString();
		if(check.equals(null)) {
			response.sendRedirect("index.jsp");
		}
		
		String uname = request.getParameter("uname");
		String type = request.getParameter("type");
		String nomonth = request.getParameter("newacnomonth");
		float amount = Float.parseFloat(request.getParameter("newacamt"));
		AccountsDAO adao = new AccountsDAO();
		
		ResultSet sbacnotrrs = adao.retrieveAcno(uname);
		String sbacno = null;
		try {
			while(sbacnotrrs.next()){
				sbacno = sbacnotrrs.getString(1);
				break;
			}
			sbacnotrrs.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		float balance = adao.retrieveBalance(sbacno);
		float remBalance = balance - amount;
		
		if(remBalance > 2000) {
			adao.updateBalance(sbacno, remBalance);
			adao.insertData(type, nomonth, amount, amount, uname);
			String newacno = adao.latestAccNo(uname, type);
			TransactionDAO tdao = new TransactionDAO();
			tdao.insertData(sbacno, newacno, amount);
			
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			out.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"snackbar/snackbar.css\">"
					+ "<script type=\"text/javascript\" src=\"snackbar/snackbar.js\"></script>"
					+ "<div id=\"snackbar\">New account created.</div>"
					+ "<script type=\"text/javascript\">window.location.href += \"#account\";</script>"
					+ "<script type=\"text/javascript\">snackbarFun();</script>");
			RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
			rd.include(request, response);
		} else {
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			out.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"snackbar/snackbar.css\">"
					+ "<script type=\"text/javascript\" src=\"snackbar/snackbar.js\"></script>"
					+ "<div id=\"snackbar\">Insufficient balance.</div>"
					+ "<script type=\"text/javascript\">window.location.href += \"#account\";</script>"
					+ "<script type=\"text/javascript\">snackbarFun();</script>");
			RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
			rd.include(request, response);
		}
		
		
		
	}

}
