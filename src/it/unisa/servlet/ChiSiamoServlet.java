package it.unisa.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.beans.Ordine;
import it.unisa.beans.ProdottoOrdine;
import it.unisa.beans.Utente;
import it.unisa.model.OrdineDAO;
import it.unisa.model.PaeseDiOrigineDAO;
import it.unisa.model.ProdottoDAO;
import it.unisa.model.UtenteDAO;

/**
 * Servlet implementation class ChiSiamoServlet
 */
@WebServlet("/ChiSiamoServlet")
public class ChiSiamoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ChiSiamoServlet() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		UtenteDAO dao = new UtenteDAO();
		PaeseDiOrigineDAO dao1 = new PaeseDiOrigineDAO();
		ProdottoDAO dao2 = new ProdottoDAO();
		OrdineDAO dao3 = new OrdineDAO();

		int utentiTotali = 0;
		int paesiTotali = 0;
		int prodottiTotali = 0;

		Collection<Utente> utenti = new ArrayList<Utente>();
		Utente[] utentiAcquisti = new Utente[3];
		
		try {
			utenti = dao.doRetriveAll("");
			utentiTotali = utenti.size();
			request.setAttribute("utentiTotali", utentiTotali);
			
			paesiTotali = dao1.doRetriveAll("").size();
			request.setAttribute("paesiTotali", paesiTotali);

			prodottiTotali = dao2.doRetriveAll("").size();
			request.setAttribute("prodottiTotali", prodottiTotali);

		} catch (SQLException e) {

			e.printStackTrace();
		}

		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/pages/chiSiamo.jsp");
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
