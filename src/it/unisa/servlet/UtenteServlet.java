package it.unisa.servlet;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;

import java.util.Collection;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import it.unisa.beans.Indirizzo;
import it.unisa.beans.Ordine;
import it.unisa.beans.ProdottoOrdine;
import it.unisa.beans.Utente;

import it.unisa.model.IndirizzoDAO;
import it.unisa.model.OrdineDAO;
import it.unisa.model.UtenteDAO;

/**
 * Servlet implementation class Utente
 */
@WebServlet("/Utente")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
		maxFileSize = 1024 * 1024 * 10, // 10MB
		maxRequestSize = 1024 * 1024 * 50) // 50MB

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

		String action = request.getParameter("action");

		Utente utente = (Utente) request.getSession().getAttribute("utente");
		if (utente == null) {
			response.sendRedirect("./Login");
			return;
		}

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

		if (action != null) {
			if (action.equals("elimina")) {
				String id = request.getParameter("idIndirizzo");
				if (id != null) {
					try {
						Indirizzo indirizzo = model2.doRetriveByKey(id);
						model2.doDelete(indirizzo);
					} catch (SQLException e) {

						e.printStackTrace();
					}
				}
			}
		}
		String redirectPage = "/pages/profilo.jsp";
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(redirectPage);
		dispatcher.forward(request, response);

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

						request.getSession().removeAttribute("indirizzi");
						Collection<Indirizzo> indirizzi = dao.doRetriveByUser(utente.getId());
						request.getSession().setAttribute("indirizzi", indirizzi);

					} catch (SQLException e) {
						e.printStackTrace();
					}
				}

			} else if (action.equals("modificaInformazioni")) {
				UtenteDAO dao = new UtenteDAO();
				String id = request.getParameter("idUtente");
				if (id != null) {

					utente.setCognome(request.getParameter("cognome"));
					utente.setNome(request.getParameter("nome"));
					utente.setEmail(request.getParameter("email"));
					utente.setUsername(request.getParameter("username"));

				}

				System.out.print("ee");
				salvaFotoProfilo(request, utente);

				try {
					dao.doUpdate(utente);
					utente = dao.doRetriveByKey(id);
					request.getSession().removeAttribute("utente");
					request.getSession().setAttribute("utente", utente);
				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
			String redirectPage = "/pages/profilo.jsp";
			RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(redirectPage);
			dispatcher.forward(request, response);
		}
	}

	private void salvaFotoProfilo(HttpServletRequest request, Utente utente) throws IOException, ServletException {

		String SAVE_DIR = "/uploadTemp";

		String appPath = request.getServletContext().getRealPath("");
		String savePath = appPath + File.separator + SAVE_DIR;

		File fileSaveDir = new File(savePath);
		if (!fileSaveDir.exists()) {
			fileSaveDir.mkdir();
		}

		for (Part part : request.getParts()) {
			String fileName = extractFileName(part);
			if (fileName != null && !fileName.equals("")) {
				part.write(savePath + File.separator + fileName);
				try {
					UtenteDAO.updatePhoto(utente.getId(), savePath + File.separator + fileName);
				} catch (SQLException sqlException) {
					System.out.println(sqlException);
				}
			}
		}
	}

	private String extractFileName(Part part) {
		String contentDisp = part.getHeader("content-disposition");
		String[] items = contentDisp.split(";");
		for (String s : items) {
			if (s.trim().startsWith("filename")) {
				return s.substring(s.indexOf("=") + 2, s.length() - 1);
			}
		}
		return "";
	}
}
