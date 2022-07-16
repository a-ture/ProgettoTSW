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
		request.setAttribute("attivo", "Login");
		Utente user = (Utente) request.getSession().getAttribute("utente");
		String action = request.getParameter("azione");

		if (action != null) {
			if (action.equals("logout")) {
				request.getSession().invalidate();
				response.sendRedirect("Home");
				return;
			}
			if (action.equals("checkout")) {
				// utente non loggato
				if (user == null) {
					request.getSession().setAttribute("provaLoggin", "prova");
					request.removeAttribute(action);

					RequestDispatcher dispatcher = getServletContext()
							.getRequestDispatcher("/WoodLot/WebContent/pages/home.jsp");
					dispatcher.forward(request, response);
					return;
				}
				// utente loggato
				else {
					request.setAttribute("azione", "checkout");
					// DA VEDERE
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Orders");
					dispatcher.forward(request, response);
					return;
				}
			}
			if (action.equals("registrazione")) {
				if (user == null) {
					RequestDispatcher dispatcher = getServletContext()
							.getRequestDispatcher("/WoodLot/WebContent/pages/signUpForm.jsp");
					dispatcher.forward(request, response);
					return;
				}
			}
		}
		if (user == null) {
			RequestDispatcher dispatcher = getServletContext()
					.getRequestDispatcher("/WoodLot/WebContent/pages/formLogin.jsp");
			dispatcher.forward(request, response);
			return;
		} else {
			// DA VEDERE
			response.sendRedirect("User");
			return;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("azione");
		request.setAttribute("attivo", "Login");
		if (action != null) {
			// Try Registering
			if (action.equals("registrazione")) {
				registerUser(request, response);
				return;
			} else if (action.equals("login")) {
				// Try login by login.jsp
				Utente user = null;
				UtenteDAO userDAO = new UtenteDAO();
				try {
					user = userDAO.doRetriveByEmail(request.getParameter("email"));
				} catch (SQLException e) {
					e.printStackTrace();
					response.sendError(500);
					return;
				}
				if (user == null || !user.getPassword().equals(request.getParameter("password"))) {
					request.getSession().removeAttribute("user");
					request.setAttribute("errors", new ArrayList<String>() {
						{
							add("User not found or password error");
						}
					});
					RequestDispatcher dispatcher = getServletContext()
							.getRequestDispatcher("/WEB-INF/views/login/login.jsp");
					dispatcher.forward(request, response);
					return;
				} else {
					request.removeAttribute("errors");
					if (user.getRole().equals("customer")) {
						request.getSession().setAttribute("user", user);
					} else if (user.getRole().equals("administrator")) {
						request.getSession().setAttribute("admin", user);
					}

					String tryLoggin = (String) request.getSession().getAttribute("tryLoggin");
					if (tryLoggin != null && tryLoggin.equals("try")) {

						request.getSession().removeAttribute("tryLoggin");
						response.sendRedirect("Orders?action=checkout");
						return;

					} else
						response.sendRedirect("Home");
				}
			}
		}
	}

	private void registerUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// control same password
		if (validateForm(request)) {
			Utente user = new Utente();
			UtenteDAO dao = new UtenteDAO();

			user.setCognome(request.getParameter("cognome"));
			user.setEmail(request.getParameter("email"));
			user.setNome(request.getParameter("nome"));
			user.setPassword(request.getParameter("password"));

			// user.setActive(true);

			try {
				dao.doSave(user);
				user = dao.doRetriveByEmail(user.getEmail());
				request.getSession().setAttribute("user", user);

				// registered by the buynow button cart
				String tryLoggin = (String) request.getSession().getAttribute("tryLoggin");

				if (tryLoggin != null && tryLoggin.equals("try")) {
					request.getSession().removeAttribute("tryLoggin");
					response.sendRedirect("Orders?action=checkout");
					return;
				}

				else {
					response.sendRedirect("Home");// call servlet get
					return;
				}

			} catch (IOException | SQLException e) {
				e.printStackTrace();
				System.out.println(e.getMessage());
				RequestDispatcher dispatcher = getServletContext()
						.getRequestDispatcher("/WEB-INF/views/login/register.jsp");
				dispatcher.forward(request, response);
			}
		} else {
			RequestDispatcher dispatcher = getServletContext()
					.getRequestDispatcher("/WEB-INF/views/login/register.jsp");
			dispatcher.forward(request, response);
		}

	}

	private boolean validateForm(HttpServletRequest request) {
		ArrayList<String> errors = new ArrayList<String>();
		request.setAttribute("errors", null);
		if (request.getParameter("firstName") == null || request.getParameter("firstName").length() <= 2) {
			errors.add("Enter a valid firstname");
		}
		if (request.getParameter("lastName") == null || request.getParameter("lastName").length() <= 2) {
			errors.add("Enter a valid lastname");
		}

		if (request.getParameter("password") == null
				|| request.getParameter("password") != request.getParameter("confirmpassword")) {
			errors.add("Password doesn't match");
		}

		if (errors.size() > 0)
			request.setAttribute("errors", errors);
		return errors.size() > 0;
	}

}
