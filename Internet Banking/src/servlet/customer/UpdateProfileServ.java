package servlet.customer;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.CustomerDAO;

/**
 * Servlet implementation class UpdateProfileServ
 */
public class UpdateProfileServ extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String uname = request.getParameter("uprrrUname");
		String name = request.getParameter("uprrrName");
		String phno = request.getParameter("uprrrPhno");
		String email = request.getParameter("uprrrEmail");
		String dob = request.getParameter("uprrrDob");
		String address = request.getParameter("uprrrAddress");
		
		CustomerDAO cdao = new CustomerDAO();
		cdao.updateData(uname, name, phno, email, dob, address);
		
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"snackbar/snackbar.css\">"
				+ "<script type=\"text/javascript\" src=\"snackbar/snackbar.js\"></script>"
				+ "<div id=\"snackbar\">Profile Updated.</div>"
				+ "<script type=\"text/javascript\">window.location.href += \"#snapshot\";</script>"
				+ "<script type=\"text/javascript\">snackbarFun();</script>");
		RequestDispatcher rd = request.getRequestDispatcher("home.jsp");
		rd.include(request, response);
	}

}
