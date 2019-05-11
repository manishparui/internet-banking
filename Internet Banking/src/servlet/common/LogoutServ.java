package servlet.common;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LogoutServ
 */
public class LogoutServ extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
		session.removeAttribute("uname");
		session.invalidate();
		response.setContentType("text/html");
		PrintWriter out = response.getWriter();
		out.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"snackbar/snackbar.css\">"
				+ "<script type=\"text/javascript\" src=\"snackbar/snackbar.js\"></script>"
				+ "<div id=\"snackbar\">Logout successfully.</div>"
				+ "<script type=\"text/javascript\">snackbarFun();</script>");
		RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
		rd.include(request, response);
	}

}
