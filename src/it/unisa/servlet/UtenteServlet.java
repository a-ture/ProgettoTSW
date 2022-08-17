package it.unisa.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.beans.Indirizzo;
import it.unisa.beans.Ordine;
import it.unisa.beans.ProdottoOrdine;
import it.unisa.beans.Utente;
import it.unisa.model.IndirizzoDAO;
import it.unisa.model.OrdineDAO;
import it.unisa.model.ProdottoDAO;
import it.unisa.model.UtenteDAO;

/**
 * Servlet implementation class Utente
 */
@WebServlet("/Utente")
public class UtenteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public UtenteServlet() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		UtenteDAO model = new UtenteDAO();
		OrdineDAO model1 = new OrdineDAO();
		IndirizzoDAO model2 = new IndirizzoDAO();
		
		Utente utente = (Utente) request.getSession().getAttribute("utente");
		// devo mettere il redirect al login se utente ==null?

		try {
			int numeroDiAlberiAcquistati = model.findNumberOfTree(utente.getId());
			request.getSession().setAttribute("numeroDiAlberiAcquistati", numeroDiAlberiAcquistati);

			int numeroDiRegali = model.findNumberOfGift(utente.getId());
			request.getSession().setAttribute("numeroDiRegali", numeroDiRegali);

			double totaleSpeso = model.findAmountSpent(utente.getId());
			request.getSession().setAttribute("totaleSpeso", totaleSpeso);

			Collection<Ordine> ordini = model1.doRetriveByUser(utente);
			request.getSession().setAttribute("ordiniUtente", ordini);

			int numeroDiOrdini = ordini.size();
			request.getSession().setAttribute("numeroDiOrdini", numeroDiOrdini);

			Collection<ProdottoOrdine> prodottiOrdini = model1.findProductBuyByUser(utente);
			request.getSession().setAttribute("prodottiOrdini", prodottiOrdini);
			
			Collection<Indirizzo> indirizzi = model2.doRetriveByUser(utente.getId());
			request.getSession().setAttribute("indirizzi", indirizzi);

		} catch (SQLException e) {
			e.printStackTrace();
		}
		String redirectPage = "/pages/profilo.jsp";
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(redirectPage);
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

	}

}
