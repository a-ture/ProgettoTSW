package it.unisa.servlet;

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
import it.unisa.beans.Albero;

import it.unisa.beans.Utente;
import it.unisa.model.OrdineDAO;
import it.unisa.model.AlberoDAO;
import it.unisa.model.UtenteDAO;

/**
 * Servlet implementation class Admin
 */
@WebServlet("/Admin")
public class Admin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Admin() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		AlberoDAO dao = new AlberoDAO();
		OrdineDAO dao1 = new OrdineDAO();
		UtenteDAO dao2 = new UtenteDAO();

		try {
			Collection<Albero> prodotti = dao.doRetriveAll("");
			request.setAttribute("prodotti", prodotti);

			Collection<Ordine> ordini = dao1.doRetriveAll("");
			request.setAttribute("ordini", ordini);

			double totale = 0;
			if (ordini != null && ordini.size() > 0) {

				Iterator<Ordine> it = ordini.iterator();
				while (it.hasNext()) {
					totale = it.next().getTotalePagato();
				}

			}
			request.setAttribute("totaleIncassi", totale);

			Collection<Utente> utenti = dao2.doRetriveAll("");
			request.setAttribute("utenti", utenti);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/pages/admin.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
