package servlet.customer;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.AccountsDAO;
import DAO.CustomerDAO;
import DAO.LoginDAO;

/**
 * Servlet implementation class RegServ
 */
public class RegServ extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uname = request.getParameter("regUname");
		String pass = request.getParameter("regPass");
		String name = request.getParameter("regName");
		String phno = request.getParameter("regPhno");
		String email = request.getParameter("regEmail");
		String dob = request.getParameter("regDob");
		String address = request.getParameter("regAddress");
		
		LoginDAO ldao = new LoginDAO();
		CustomerDAO cdao = new CustomerDAO();
		AccountsDAO adao = new AccountsDAO();
		
		int count = ldao.countData(uname);
		if(count == 0) {
			ldao.insertData(uname, pass);
			cdao.insertData(uname, name, phno, email, dob, address);
			adao.insertData("sb", uname);
			
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			out.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"snackbar/snackbar.css\">"
					+ "<script type=\"text/javascript\" src=\"snackbar/snackbar.js\"></script>"
					+ "<div id=\"snackbar\">Registration successful.<br>Please proceed to Login.</div>"
					+ "<script type=\"text/javascript\">snackbarFun();</script>");
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
			rd.include(request, response);
		} else {
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			out.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"snackbar/snackbar.css\">"
					+ "<script type=\"text/javascript\" src=\"snackbar/snackbar.js\"></script>"
					+ "<div id=\"snackbar\">User Name is not available.<br>Please try with another.</div>"
					+ "<script type=\"text/javascript\">snackbarFun();</script>");
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
			rd.include(request, response);
		}
	}

}
