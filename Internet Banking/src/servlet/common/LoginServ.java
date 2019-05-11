package servlet.common;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.LoginDAO;

/**
 * Servlet implementation class LoginServ
 */
public class LoginServ extends HttpServlet {
	Connection con = null;
	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.setContentType("text/html");
		
		String uname = request.getParameter("uname");
		String pass = request.getParameter("pass");
		String dbUname = null;
		String dbPass = null;
		String dbtype = null;
		String dbStatus = null;
		
		LoginDAO ldao = new LoginDAO();
		ResultSet rs = ldao.retrieveData(uname);
		
			try {
				while (rs.next()) {
					dbUname = rs.getString("uname");
					dbPass = rs.getString("pass");
					dbtype = rs.getString("type");
					dbStatus = rs.getString("status");
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		
		if(uname.equals(dbUname) && pass.equals(dbPass) && dbStatus.equals("active")) {
			HttpSession session = request.getSession();
			session.setAttribute("uname", uname);
			session.setAttribute("type", dbtype);
			if(dbtype.equals("a")) {
				response.sendRedirect("admin.jsp");
			} else if(dbtype.equals("c")){
				response.sendRedirect("home.jsp");
			}
		} else {
			PrintWriter out = response.getWriter();
			out.print("<link rel=\"stylesheet\" type=\"text/css\" href=\"snackbar/snackbar.css\">"
					+ "<script type=\"text/javascript\" src=\"snackbar/snackbar.js\"></script>"
					+ "<div id=\"snackbar\">Wrong User Name or Password.</div>"
					+ "<script type=\"text/javascript\">snackbarFun();</script>");
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
			rd.include(request, response);
		}
	}

}
