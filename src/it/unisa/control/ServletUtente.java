package it.unisa.control;

import java.io.IOException;
import java.sql.SQLException;

import java.util.Collection;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.beans.Ordine;
import it.unisa.beans.Utente;

import it.unisa.model.OrdineDAO;

/**
 * Servlet implementation class Utente
 */
@WebServlet("/Utente")
public class ServletUtente extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ServletUtente() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// UtenteDAO model = new UtenteDAO();
		OrdineDAO model1 = new OrdineDAO();

		Utente utente = (Utente) request.getSession().getAttribute("utente");

		if (utente == null) {
			response.sendError(401);
			return;
		}

		try {
			Collection<Ordine> ordini = model1.doRetriveByUser(utente);

			request.getSession().removeAttribute("ordiniUtente");
			request.getSession().setAttribute("ordiniUtente", ordini);

			int numeroDiAlberiAcquistati = 0;
			double totaleSpeso = 0;

			if (ordini != null && ordini.size() != 0) {
				Iterator<Ordine> it = ordini.iterator();
				while (it.hasNext()) {
					Ordine o = it.next();
					totaleSpeso += o.getTotalePagato();
					numeroDiAlberiAcquistati += o.getTotaleProdotti();
				}
			}

			request.getSession().setAttribute("numeroDiAlberiAcquistati", numeroDiAlberiAcquistati);

			request.getSession().setAttribute("totaleSpeso", totaleSpeso);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		String redirectPage = "/pages/profilo.jsp";
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(redirectPage);
		dispatcher.forward(request, response);

	}

	/**
	 * Metodo Post che richiama il doGet
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
