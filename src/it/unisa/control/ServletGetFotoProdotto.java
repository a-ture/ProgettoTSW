package it.unisa.control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.model.FotoProdottoDAO;

/**
 * Servlet per recuperare delle foto
 */
@WebServlet("/GetFotoProdotto")
public class ServletGetFotoProdotto extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ServletGetFotoProdotto() {
		super();
	}

	/**
	 * Metodo recupera le foto del prodotto dal database
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int id = Integer.parseInt(request.getParameter("idFoto"));

		FotoProdottoDAO model = new FotoProdottoDAO();

		byte[] bt = model.load(id);
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
