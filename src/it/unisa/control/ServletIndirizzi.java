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

import it.unisa.beans.Indirizzo;
import it.unisa.beans.Utente;
import it.unisa.model.IndirizzoDAO;
import it.unisa.model.UtenteDAO;

/**
 * Servlet implementation class ServletIndirizzi
 */
@WebServlet("/Indirizzi")
public class ServletIndirizzi extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		IndirizzoDAO model2 = new IndirizzoDAO();
		UtenteDAO model3 = new UtenteDAO();

		String action = request.getParameter("action");
		Utente utente = (Utente) request.getSession().getAttribute("utente");

		if (utente == null) {
			response.sendRedirect("./Login");
			return;
		}
		
		if (action != null) {
			if (action.equals("elimina")) {
				String id = request.getParameter("idIndirizzo");
				if (id != null) {
					try {
						Indirizzo indirizzo = model2.doRetriveByKey(id);

						model2.doDelete(indirizzo);
						utente.setIndirizzi(model3.doRetriveByUser(utente.getId()));
					} catch (SQLException e) {

						e.printStackTrace();
					}
				}
			}
			request.removeAttribute(action);
			response.sendRedirect("/WoodLot/Utente#indirizzo");
		}
		
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		
		String action = request.getParameter("action");
		Utente utente = (Utente) request.getSession().getAttribute("utente");
		
		if (action != null) {
			if (action.equals("preferred")) {
				IndirizzoDAO dao = new IndirizzoDAO();
				String id = request.getParameter("idIndirizzo");
				if (id != null) {

					try {
						Indirizzo indirizzo = dao.doRetriveByKey(id);
						indirizzo.setPreferred(true);
						dao.doUpdate(indirizzo);
						ArrayList<Indirizzo> listIndirizzi = (ArrayList<Indirizzo>) utente.getIndirizzi();
						for(Indirizzo i: listIndirizzi) {
							if(i.getId() == Integer.parseInt(id)) {
								i.setPreferred(true);
							}
							else {
								i.setPreferred(false);
								dao.doUpdate(i);
							}
						}

					} catch (SQLException e) {
						e.printStackTrace();
					}
				}

			} else if (action.equals("salvaIndirizzo")) {

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
				indirizzo.setPreferred(false);

				try {
					model.doSave(indirizzo);
					utente.getIndirizzi().add(indirizzo);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			request.removeAttribute(action);
			response.sendRedirect("/WoodLot/Utente#indirizzo");
		
		}
	}

}
