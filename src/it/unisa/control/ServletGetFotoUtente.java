package it.unisa.control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.model.UtenteDAO;

/**
 * Servlet per recuperare una foto
 */
@WebServlet("/GetFotoUtente")
public class ServletGetFotoUtente extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ServletGetFotoUtente() {
		super();
	}

	/**
	 * Metodo recupera la foto dell'utente dal database
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = (String) request.getParameter("idUtente");
		byte[] bt = UtenteDAO.load(Integer.parseInt(id));
		ServletOutputStream out = response.getOutputStream();
		if (bt != null) {
			out.write(bt);
			response.setContentType("image/jpeg");
		}
		out.close();
	}

	/**
	 * Metodo Post che richiama il metodo doGet
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
