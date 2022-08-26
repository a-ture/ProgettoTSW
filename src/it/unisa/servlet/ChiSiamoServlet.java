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

import it.unisa.beans.ProdottoOrdine;
import it.unisa.beans.Utente;
import it.unisa.model.OrdineDAO;
import it.unisa.model.PaeseDiOrigineDAO;
import it.unisa.model.AlberoDAO;
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
		AlberoDAO dao2 = new AlberoDAO();
		OrdineDAO dao3 = new OrdineDAO();

		int utentiTotali = 0;
		int paesiTotali = 0;
		int prodottiTotali = 0;

		Collection<Utente> utenti = new ArrayList<Utente>();
		Collection<Utente> utentiAcquisti = new ArrayList<Utente>();
		Collection<ProdottoOrdine> prodottiVenduti = new ArrayList<ProdottoOrdine>();

		try {

			utenti = dao.doRetriveAll("");
			utentiTotali = utenti.size();
			request.setAttribute("utentiTotali", utentiTotali);

			paesiTotali = dao1.doRetriveAll("").size();
			request.setAttribute("paesiTotali", paesiTotali);

			prodottiTotali = dao2.doRetriveAll("").size();
			request.setAttribute("prodottiTotali", prodottiTotali);

			prodottiVenduti = dao3.findBestSellingProducts();
			request.setAttribute("prodottiVenduti", prodottiVenduti);

			utenti = dao.doRetriveByOrder();
			Iterator<Utente> it = utenti.iterator();
			while (it.hasNext()) {
				Utente utente = it.next();
				utentiAcquisti.add(dao.doRetriveByKey("" + utente.getId()));
			}
			request.setAttribute("utentiAcquisti", utentiAcquisti);

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
