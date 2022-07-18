package it.unisa.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.beans.Utente;
import it.unisa.model.UtenteDAO;

/**
 * Servlet implementation class Login
 */
@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Login() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		String redirectedPage;

		try {
			checkLogin(username, password);
			request.getSession().setAttribute("adminRoles", Boolean.TRUE);
			redirectedPage = "/protected.jsp";
		} catch (Exception e) {
			request.getSession().setAttribute("adminRoles", Boolean.FALSE);
			redirectedPage = "/login-form.jsp";
		}
		response.sendRedirect(request.getContextPath() + redirectedPage);
	}

	private void checkLogin(String username, String password) throws Exception {
		if ("root".equals(username) && "admin".equals(password)) {
			//
		} else
			throw new Exception("Invalid login and password");
	}
}
