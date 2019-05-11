package servlet.customer;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.AccountsDAO;
import DAO.LoginDAO;
import DAO.TransactionDAO;

/**
 * Servlet implementation class FundTransferServ
 */
public class FundTransferServ extends HttpServlet {
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
		
		String acno = request.getParameter("pacno"); //payee account number/to account nnumber
		//String hname = request.getParameter("phname");
		//String bname = request.getParameter("pbname");
		String amountStr = request.getParameter("pamount");
		String pass = request.getParameter("ppass"); //logged in user pass
		String uname = request.getParameter("puname"); //logged in user uname
		String sbacno = request.getParameter("hsbacno"); //logged in user account number/from account number
		float amount = Float.parseFloat(amountStr);
		
		LoginDAO ldao = new LoginDAO();
		String dbpass = ldao.retrievePass(uname);
		
		if(pass.equals(dbpass)) {
			AccountsDAO adao = new AccountsDAO();
			float balance = adao.retrieveBalance(sbacno);
			float remBalance = balance - amount;
			float payeeBalance = adao.retrieveBalance(acno);
			float updateBalance = payeeBalance + amount;
			
			if(remBalance > 2000) {
				adao.updateBalance(sbacno, remBalance);
				adao.updateBalance(acno, updateBalance);
				TransactionDAO tdao = new TransactionDAO();
				tdao.insertData(sbacno, acno, amount);
				
				response.setContentType("text/html");
				PrintWriter out = response.getWriter();
				out.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"snackbar/snackbar.css\">"
						+ "<script type=\"text/javascript\" src=\"snackbar/snackbar.js\"></script>"
						+ "<div id=\"snackbar\">Payment successfull.</div>"
						+ "<script type=\"text/javascript\">window.location.href += \"#tf\";</script>"
						+ "<script type=\"text/javascript\">snackbarFun();</script>");
				RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
				rd.include(request, response);
			} else {
				response.setContentType("text/html");
				PrintWriter out = response.getWriter();
				out.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"snackbar/snackbar.css\">"
						+ "<script type=\"text/javascript\" src=\"snackbar/snackbar.js\"></script>"
						+ "<div id=\"snackbar\">Insufficient balance.</div>"
						+ "<script type=\"text/javascript\">window.location.href += \"#tf\";</script>"
						+ "<script type=\"text/javascript\">snackbarFun();</script>");
				RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
				rd.include(request, response);
			}
		} else {
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			out.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"snackbar/snackbar.css\">"
					+ "<script type=\"text/javascript\" src=\"snackbar/snackbar.js\"></script>"
					+ "<div id=\"snackbar\">Wrong password.</div>"
					+ "<script type=\"text/javascript\">window.location.href += \"#tf\";</script>"
					+ "<script type=\"text/javascript\">snackbarFun();</script>");
			RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
			rd.include(request, response);
		}
	}
}
