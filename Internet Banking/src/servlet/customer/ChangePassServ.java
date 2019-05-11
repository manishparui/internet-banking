package servlet.customer;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.LoginDAO;

/**
 * Servlet implementation class ChangePassServ
 */
public class ChangePassServ extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String oldPass = request.getParameter("oldPass");
		String newPass = request.getParameter("newPass");
		String uname = request.getParameter("cphjuname");
		
		LoginDAO ldao = new LoginDAO();
		String dbPass = ldao.retrievePass(uname);
		
		if(dbPass.equals(oldPass)) {
			ldao.updatePassword(uname, newPass);
			
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			out.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"snackbar/snackbar.css\">"
					+ "<script type=\"text/javascript\" src=\"snackbar/snackbar.js\"></script>"
					+ "<div id=\"snackbar\">Password Changed.</div>"
					+ "<script type=\"text/javascript\">window.location.href += \"#snapshot\";</script>"
					+ "<script type=\"text/javascript\">snackbarFun();</script>");
			RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
			rd.include(request, response);
		} else {
			response.setContentType("text/html");
			PrintWriter out = response.getWriter();
			out.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"snackbar/snackbar.css\">"
					+ "<script type=\"text/javascript\" src=\"snackbar/snackbar.js\"></script>"
					+ "<div id=\"snackbar\">Wrong current password.</div>"
					+ "<script type=\"text/javascript\">window.location.href += \"#snapshot\";</script>"
					+ "<script type=\"text/javascript\">snackbarFun();</script>");
			RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
			rd.include(request, response);
		}
	}

}
