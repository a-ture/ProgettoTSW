package it.unisa.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.model.FotoPaeseDiOrigineDAO;
import it.unisa.model.FotoProdottoDAO;

/**
 * Servlet implementation class GetFotoProdotto
 */
@WebServlet("/GetFotoProdotto")
public class GetFotoProdotto extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public GetFotoProdotto() {
		super();

	}

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
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
