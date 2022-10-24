package it.unisa.control;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;

import java.util.Collection;
import java.util.Iterator;

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
			response.sendRedirect("./Login");
			return;
		}

		try {
			Collection<Ordine> ordini = model1.doRetriveByUser(utente);

			request.getSession().removeAttribute("ordiniUtente");
			request.getSession().setAttribute("ordiniUtente", ordini);

			int numeroDiAlberiAcquistati = 0, numeroDiRegali = 0;
			double totaleSpeso = 0;

			if (ordini != null && ordini.size() != 0) {
				Iterator<Ordine> it = ordini.iterator();
				while (it.hasNext()) {
					Ordine o = it.next();
					totaleSpeso += o.getTotalePagato();
					if (o.isRegalo())
						numeroDiRegali++;
					numeroDiAlberiAcquistati += o.getTotaleProdotti();
				}
			}

			request.getSession().setAttribute("numeroDiAlberiAcquistati", numeroDiAlberiAcquistati);
			request.getSession().setAttribute("numeroDiRegali", numeroDiRegali);
			request.getSession().setAttribute("totaleSpeso", totaleSpeso);

			Collection<Ordine> ordiniRegalati = model1.findGiftForUser(utente);
			request.getSession().setAttribute("ordiniRegalati", ordiniRegalati);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		String redirectPage = "/pages/profilo.jsp";
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(redirectPage);
		dispatcher.forward(request, response);

	}

}
