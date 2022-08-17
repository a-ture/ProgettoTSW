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

import it.unisa.beans.CodicePromozionale;
import it.unisa.beans.Indirizzo;
import it.unisa.beans.Utente;
import it.unisa.beans.Ordine;
import it.unisa.beans.ProdottoCarrello;
import it.unisa.beans.ProdottoOrdine;
import it.unisa.model.Carrello;
import it.unisa.model.CodicePromozionaleDAO;
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
		String redirectPage = "/pages/checkout.jsp";
		if (action != null) {

			if (action.equals("vista")) {
				/*OrdineDAO dao = new OrdineDAO();
				Ordine ordine;
				try {
					ordine = dao.doRetriveByLastUserOrder();
					request.setAttribute("ordineUtente", ordine);
					redirectPage = "/pages/ordineEffettuato.jsp";
				} catch (SQLException e) {
					e.printStackTrace();
				}*/

			} else if (action.equals("checkout")) {
				if (carrello == null || ((Carrello) carrello).getQuantitàTotaleProdotti() <= 0) {
					response.sendError(500);
					return;
				}
			}
			RequestDispatcher dispatcher = request.getRequestDispatcher(redirectPage);
			dispatcher.forward(request, response);
			return;
		}
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
				compra(request, response);
				return;
			} else if (action.equals("codicePromozionale")) {
				usaCodicePromozionale(request, response);
				RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/checkout.jsp");
				dispatcher.forward(request, response);
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
		indirizzo.setCittà(request.getParameter("citta"));
		indirizzo.setVia(request.getParameter("via"));
		indirizzo.setProvincia(request.getParameter("provincia"));
		indirizzo.setUid(utente.getId());
		indirizzo.setCivico(request.getParameter("civico"));

		try {
			model.doSave(indirizzo);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		request.getSession().setAttribute("indirizzo", indirizzo);
	}

	private void usaCodicePromozionale(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		CodicePromozionale codice = new CodicePromozionale();
		CodicePromozionaleDAO model = new CodicePromozionaleDAO();

		try {
			if (model.doRetriveByName(request.getParameter("promoCode")) != null) {
				codice = model.doRetriveByName(request.getParameter("promoCode"));
				request.getSession().setAttribute("codice", codice);
			} else {
				request.setAttribute("errori", new ArrayList<String>() {
					{
						add("Riprova! Il codice non esiste");
					}
				});
			}
			if (!codice.checkValidità()) {
				request.setAttribute("errori", new ArrayList<String>() {
					{
						add("Il codice inserito non è valido");
					}
				});
			}

		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	private void compra(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		Carrello carrello = (Carrello) request.getSession().getAttribute("carrello");
		Utente utente = (Utente) (request.getSession().getAttribute("utente"));

		Indirizzo indirizzo = (Indirizzo) request.getSession().getAttribute("indirizzo");
		CodicePromozionale code = (CodicePromozionale) request.getSession().getAttribute("codice");

		if (carrello == null /* || indirizzo == null */) {
			response.sendError(500);
			return;
		}

		Ordine ordine = new Ordine();
		double totaleOrdine = carrello.getPrezzoTotaleProdotti();

		if (code != null) {
			totaleOrdine = totaleOrdine - code.getScontoApplicato();
		}
		ordine.setTotalePagato(totaleOrdine);
		ordine.setTotaleProdotti(carrello.getQuantitàTotaleProdotti());
		ordine.setUtente(utente);

		System.out.print(request.getParameter("regalo"));
		if (request.getParameter("regalo") != null) {
			ordine.setRegalo(true);
			ordine.setMessaggioRegalo(request.getParameter("messaggioRegalo"));
			ordine.setDestinatarioRegalo(request.getParameter("mailRegalo"));
		} else {
			ordine.setRegalo(false);
			ordine.setMessaggioRegalo(null);
			ordine.setDestinatarioRegalo(null);
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
		request.getSession().removeAttribute("codice");
		request.getSession().removeAttribute("ordineUtente");
		request.getSession().setAttribute("ordineUtente", ordine);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/pages/ordineEffettuato.jsp");
		dispatcher.forward(request, response);
		return;
	}

}
