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

import it.unisa.beans.Ordine;
import it.unisa.beans.UsoLocale;
import it.unisa.beans.Albero;
import it.unisa.beans.Categoria;
import it.unisa.beans.Utente;
import it.unisa.model.OrdineDAO;
import it.unisa.model.UsoLocaleDAO;
import it.unisa.model.AlberoDAO;
import it.unisa.model.CategoriaDAO;
import it.unisa.model.UtenteDAO;

/**
 * Servlet per la gestione delle immagini degli alberi (utilizzata dagli admin)
 */
@WebServlet("/Admin")
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
		maxFileSize = 1024 * 1024 * 10, // 10MB
		maxRequestSize = 1024 * 1024 * 50) // 50MB
public class ServletAdmin extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ServletAdmin() {
		super();
		
	}
	
	/**
	 * Recupera le informazioni sugli ordini visibili dall'amministratore
	 * @pre devi aver effettuato il Login come amministratore
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		AlberoDAO dao = new AlberoDAO();
		OrdineDAO dao1 = new OrdineDAO();
		UtenteDAO dao2 = new UtenteDAO();
		CategoriaDAO dao4 = new CategoriaDAO();
		UsoLocaleDAO dao5 = new UsoLocaleDAO();

		Utente admin = (Utente) request.getSession().getAttribute("admin");
		if (admin == null) {
			response.sendError(401);
			return;
		}
		try {
			Collection<Albero> prodotti = dao.doRetriveAll("");
			request.getSession().setAttribute("prodotti", prodotti);

			Collection<Ordine> ordini = dao1.doRetriveAll("");
			request.getSession().setAttribute("ordini", ordini);

			double totale = 0;
			if (ordini != null && ordini.size() > 0) {

				Iterator<Ordine> it = ordini.iterator();
				while (it.hasNext()) {
					totale += it.next().getTotalePagato();
				}

			}
			request.setAttribute("totaleIncassi", totale);

			Collection<Utente> utenti = dao2.doRetriveAll("");
			request.getSession().setAttribute("utenti", utenti);


			Collection<Categoria> categorie = dao4.doRetriveAll(null);
			request.getSession().setAttribute("categorie", categorie);

			Collection<UsoLocale> usi = dao5.doRetriveAll(null);
			request.getSession().setAttribute("usi", usi);

		} catch (SQLException e) {
			e.printStackTrace();
		}

		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/pages/admin.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * Aggiorna il prodotto aggiungendo la foto dell'albero e la stato
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		OrdineDAO dao = new OrdineDAO();
		String action = request.getParameter("action");
		if (action != null) {
			if (action.equals("aggiornaProdottoOrdine")) {

				String id = request.getParameter("codice");
				String stato = request.getParameter("stato");
				
				try {
					dao.doUpdateProduct(Integer.parseInt(id), stato);
				} catch (NumberFormatException e) {
					e.printStackTrace();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				salvaFotoProdottoOrdine(request, Integer.parseInt(id));

			}
		}
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/pages/admin.jsp");
		dispatcher.forward(request, response);
	}

	/**
	 * Salva la foto del prodotto
	 * @param request	
	 * @param id	codice identificativo del prodotto
	 * @throws IOException	eccezioni
	 * @throws ServletException	eccezioni
	 */
	private void salvaFotoProdottoOrdine(HttpServletRequest request, int id) throws IOException, ServletException {

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
					OrdineDAO.updatePhoto(id, savePath + File.separator + fileName);
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
