package it.unisa.servlet;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.beans.Indirizzo;
import it.unisa.beans.Utente;
import it.unisa.beans.Ordine;
import it.unisa.beans.ProdottoCarrello;
import it.unisa.beans.ProdottoOrdine;
import it.unisa.model.Carrello;
import it.unisa.model.IndirizzoDAO;
import it.unisa.model.OrdineDAO;

/**
 * Servlet implementation class Ordine
 */
@WebServlet("/Ordini")
public class Ordini extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Ordini() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		var action = request.getParameter("action");
		Utente utente = (Utente) request.getSession().getAttribute("utente");
		Carrello carrello = (Carrello) request.getSession().getAttribute("carrello");

		if (action != null) {
			if (action.equals("vista")) {
				// view detail order
			} else if (action.equals("checkout")) {
				if (carrello == null || ((Carrello) carrello).getQuantitàTotaleProdotti() <= 0) {
					response.sendError(500);
					return;
				}
				RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/checkout.jsp");
				dispatcher.forward(request, response);
				return;
			} /*
				 * else if (action.equals("details")) { // penso che non mi serve a niente a me
				 * 
				 * 
				 * try { OrdineDAO o = new OrdineDAO(); int idOrder =
				 * Integer.parseInt(request.getParameter("id")); Ordine order =
				 * o.doRetriveByKey(idOrder); if (o == null) response.sendRedirect("Utente");
				 * 
				 * request.getSession().setAttribute("orderToShow", order); RequestDispatcher
				 * dispatcher =
				 * request.getRequestDispatcher("/WEB-INF/views/users/viewDetail.jsp");
				 * dispatcher.forward(request, response); } catch (Exception e) {
				 * response.sendRedirect("User"); return; }
				 * 
				 * }
				 */

		} /*
			 * else { response.sendRedirect("User"); return; }
			 */
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String action = request.getParameter("action");
		Utente utente = (Utente) request.getSession().getAttribute("utente");
		if (action != null) {
			if (action.equals("crea")) { // non so a che merda serve
				RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/orders/summary.jsp");
				dispatcher.forward(request, response);
				return;
			} else if (action.equals("compra")) {
				if (request.getParameter("preferredAddress") != null) {
					salvaIndirizzo(request, response);
				}
				doBuy(request, response);
				return;
			}

		}

	}

	private void salvaIndirizzo(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		Utente utente = (Utente) (request.getSession().getAttribute("utente"));
		Indirizzo indirizzo = new Indirizzo();
		IndirizzoDAO model = new IndirizzoDAO();

		indirizzo.setNome(request.getParameter("nome"));
		indirizzo.setCognome(request.getParameter("cognome"));
		indirizzo.setCAP(request.getParameter("cap"));
		indirizzo.setCittà(request.getParameter("città"));
		indirizzo.setIndirizzo(request.getParameter("via"));
		indirizzo.setProvincia(request.getParameter("provincia"));
		indirizzo.setUid(utente.getId());

		try {
			model.doSave(indirizzo);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		request.getSession().setAttribute("indirizzo", indirizzo);
	}

	private void doBuy(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		/***
		 * TODO Redirect to a page where the user can select if is a gift, the address
		 * of the shipment, payment method and gift message
		 */
		Carrello carrello = (Carrello) request.getSession().getAttribute("carrello");
		Utente utente = (Utente) (request.getSession().getAttribute("utente"));

		Indirizzo indirizzo = (Indirizzo) request.getSession().getAttribute("indirizzo");

		if (carrello == null /* || indirizzo == null */) {
			response.sendError(500);
			return;
		}

		Ordine ordine = new Ordine();

		ordine.setTotalePagato(carrello.getPrezzoTotaleProdotti());
		ordine.setTotaleProdotti(carrello.getQuantitàTotaleProdotti());
		ordine.setUtente(utente);

		System.out.print(request.getParameter("regalo"));
		if (request.getParameter("regalo") != null) {

			ordine.setRegalo(true);
			ordine.setMessaggioRegalo(request.getParameter("messaggioRegalo"));
		} else {
			ordine.setRegalo(false);
		}
		for (ProdottoCarrello prod : carrello.getProdotti()) {
			ProdottoOrdine bean = new ProdottoOrdine();
			bean.setDescrizione(prod.getProdotto().getDescrizione());
			bean.setSaldo(prod.getProdotto().getSaldo());
			bean.setNome(prod.getProdotto().getNome());
			bean.setPrezzo(prod.getPrezzoTotale());
			bean.setQuantità(prod.getQuantità());
			bean.setBreveDescrizione(prod.getProdotto().getDescrizione());
			bean.setTasse(prod.getProdotto().getTasse());
			ordine.aggiungiPrdotto(bean);
		}

		OrdineDAO dao = new OrdineDAO();
		try {
			dao.doSave(ordine);
		} catch (SQLException e) {
			e.printStackTrace();
			response.sendError(500);
			return;
		}

		request.getSession().setAttribute("carrello", new Carrello());
		RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/ordineEffettuato.jsp");
		dispatcher.forward(request, response);
		return;
	}

}
