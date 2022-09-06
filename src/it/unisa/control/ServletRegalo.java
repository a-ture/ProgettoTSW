package it.unisa.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.beans.Ordine;
import it.unisa.model.OrdineDAO;

/**
 * Servlet implementation class Regalo
 */
@WebServlet("/Regalo")
public class ServletRegalo extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ServletRegalo() {
		super();
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String redirectPage = "/pages/treecodeForm.jsp";
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(redirectPage);
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String email = request.getParameter("email");
		String codice = request.getParameter("codice");
		String error = null;

		OrdineDAO dao = new OrdineDAO();

		try {
			if (codice != null && email != null) {
				Ordine ordine = dao.doRetriveByKey(codice);

				if (ordine != null) {
					if ((ordine.isRegalo() == true) && (ordine.getDestinatarioRegalo().equals(email))) {
						error = "Hai riscatto correttamente il tuo regalo! Lo puoi visualizzare nel tuo profilo";
						error.concat("Ecco il messaggio del tuo regalo:" + ordine.getMessaggioRegalo());
						ordine.setMessaggioRegalo("riscattato");
						dao.doUpdateMexGift(ordine);
					} else {
						error = "OPS! Qualcosa è andato storto! Riprova!";
					}
				} else {
					error = "OPS! Qualcosa è andato storto! Riprova!";
				}
			}
		} catch (SQLException e) {
			error = "OPS! Qualcosa è andato storto! Riprova!";
			e.printStackTrace();
		}

		request.setAttribute("error", error);
		String redirectPage = "/pages/treecodeForm.jsp";
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(redirectPage);
		dispatcher.forward(request, response);

	}

}
