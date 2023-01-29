package it.unisa.control;


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
 * Servlet che gestisce l'autenticazione
 * 
 * @author raffaella & alessia
 *
 */
@WebServlet("/Login")
public class ServletLogin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ServletLogin() {
		super();
	}

	/**
	 * Metodo gestisce l'autenticazione
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setAttribute("active", "Login");
		Utente utente = (Utente) request.getSession().getAttribute("utente");
		String action = request.getParameter("action");

		if (action != null) {
			if (action.equals("logout")) {
				request.getSession().invalidate();
				response.sendRedirect("Home");
				return;
			}
			if (action.equals("checkout")) {
				// utente che non ha effettuato il login prima di fare il checkout, una volta effettuare il login verrà reindirizzato nella pagine precedente
				if (utente == null) {
					request.getSession().setAttribute("tryLoggin", "try");
					request.removeAttribute(action);
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/pages/login.jsp");
					dispatcher.forward(request, response);
					return;
				} else {
					request.setAttribute("action", "checkout");
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/Ordini");
					dispatcher.forward(request, response);
					return;
				}
			}
			if (action.equals("registrazione")) {
				//l'utente effettuerà la registrazione
				if (utente == null) {
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/pages/signUpForm.jsp");
					dispatcher.forward(request, response);
					return;
				}
			}
		}
		if (utente == null) {
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/pages/login.jsp");
			dispatcher.forward(request, response);
			return;
		} else {
			response.sendRedirect("Utente");
			return;
		}
	}

	/**
	 * Metodo per controllare la password
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");
		
		if (action != null) {
			if (action.equals("registrazione")) {
				registerUser(request, response);
				return;
			} else if (action.equals("login")) {
				Utente utente = null;
				UtenteDAO utenteDAO = new UtenteDAO();
				try {
					utente = utenteDAO.doRetriveByEmail(request.getParameter("email"));
				} catch (SQLException e) {
					e.printStackTrace();
					response.sendError(500);
					return;
				}
				if (utente == null || !utente.getPassword().equals(request.getParameter("password"))) {
					request.getSession().removeAttribute("utente");
					request.setAttribute("errori", new ArrayList<String>() {

						private static final long serialVersionUID = 1L;

						{
							add("L'utente non è stato trovato o la password è errata");
						}
					});
					RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/pages/login.jsp");
					dispatcher.forward(request, response);
					return;
				} else {
					//nel caso di login andato a buon fine assegna il ruolo alla sessione
					request.removeAttribute("errors");
					if (utente.getRole().equals("cliente")) {
						request.getSession().setAttribute("utente", utente);
					} else if (utente.getRole().equals("admin")) {
						request.getSession().setAttribute("admin", utente);
						response.sendRedirect("./Admin");
						return;
					}
					String tryLoggin = (String) request.getSession().getAttribute("tryLoggin");
					if (tryLoggin != null && tryLoggin.equals("try")) {
						request.getSession().removeAttribute("tryLoggin");
						response.sendRedirect("Ordini?action=checkout");
						return;

					} else
						response.sendRedirect("./Utente");
				}
			}
		}
	}

	/**
	 * Metodo che effettua la registrazione
	 */
	private void registerUser(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (validateForm(request)) {
			Utente utente = new Utente();
			UtenteDAO dao = new UtenteDAO();
			utente.setNome(request.getParameter("nome"));
			utente.setCognome(request.getParameter("cognome"));
			utente.setEmail(request.getParameter("email"));
			utente.setPassword(request.getParameter("password"));
			utente.setRole("cliente");
			try {
				dao.doSave(utente);
				utente = dao.doRetriveByEmail(utente.getEmail());
				request.getSession().setAttribute("utente", utente);

				// registered by the buynow button cart
				String tryLoggin = (String) request.getSession().getAttribute("tryLoggin");

				if (tryLoggin != null && tryLoggin.equals("try")) {
					request.getSession().removeAttribute("tryLoggin");
					response.sendRedirect("Ordini?action=checkout");
					return;
				} else {
					response.sendRedirect("Utente");
					return;
				}

			} catch (IOException | SQLException e) {
				e.printStackTrace();
				RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/pages/signUpForm.jsp");
				dispatcher.forward(request, response);
			}
		} else {
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/pages/signUpForm.jsp");
			dispatcher.forward(request, response);
		}

	}

	/**
	 * Metodo per la validazione del form
	 */
	private boolean validateForm(HttpServletRequest request) {
		ArrayList<String> errors = new ArrayList<String>();

		request.setAttribute("errors", null);
		if (request.getParameter("nome") == null || request.getParameter("nome").length() <= 2) {
			errors.add("Inserisci un nome valido");
		}
		if (request.getParameter("cognome") == null || request.getParameter("cognome").length() <= 2) {
			errors.add("Inserisci un cognome valido");
		}

		if (request.getParameter("password") == null
				|| request.getParameter("password") != request.getParameter("passwird1")) {
			errors.add("La password non coincide");
		}

		if (errors.size() > 0)
			request.setAttribute("errors", errors);

		return errors.size() > 0;
	}



}