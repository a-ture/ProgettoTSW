package it.unisa.control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.model.PaeseDiOrigineDAO;


/**
 * Servlet implementation class GetPhoto
 */
@WebServlet("/GetFotoPaeseDiOrigine")
public class GetFotoPaeseDiOrigine extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public GetFotoPaeseDiOrigine() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = (String) request.getParameter("idPaese");
		if (id != null) {
			byte[] bt = PaeseDiOrigineDAO.load(id);

			
			ServletOutputStream out = response.getOutputStream();
			if (bt != null) {
				System.out.print(bt);
				out.write(bt);
				response.setContentType("image/jpeg");
			}
			out.close();
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
