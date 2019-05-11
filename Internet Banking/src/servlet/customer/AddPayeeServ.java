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
import DAO.PayeeDAO;

/**
 * Servlet implementation class AddPayeeServ
 */
public class AddPayeeServ extends HttpServlet {
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
		
		String addby = request.getParameter("payeeaddby");
		String acno = request.getParameter("payeeacno");
		String bankname = request.getParameter("payeebname");
		String holdername = request.getParameter("payeehname");
		
		AccountsDAO adao = new AccountsDAO();
		int x = adao.searchAccount(acno);
		
		if(x == 1) {
			PayeeDAO pdao = new PayeeDAO();
			pdao.insertData(addby, acno, bankname, holdername);
			
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			out.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"snackbar/snackbar.css\">"
					+ "<script type=\"text/javascript\" src=\"snackbar/snackbar.js\"></script>"
					+ "<div id=\"snackbar\">Payee added.</div>"
					+ "<script type=\"text/javascript\">window.location.href += \"#tf\";</script>"
					+ "<script type=\"text/javascript\">snackbarFun();</script>");
			RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
			rd.include(request, response);
		} else {
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			out.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"snackbar/snackbar.css\">"
					+ "<script type=\"text/javascript\" src=\"snackbar/snackbar.js\"></script>"
					+ "<div id=\"snackbar\">Invalid payee information.</div>"
					+ "<script type=\"text/javascript\">window.location.href += \"#tf\";</script>"
					+ "<script type=\"text/javascript\">snackbarFun();</script>");
			RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
			rd.include(request, response);
		}
	}

}
