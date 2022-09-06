package it.unisa.control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.model.BeneficioDAO;


/**
 * Servlet implementation class GetFotoBeneficio
 */
@WebServlet("/GetFotoBeneficio")
public class ServletGetFotoBeneficio extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ServletGetFotoBeneficio() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String id = (String) request.getParameter("idBeneficio");
		if (id != null) {
			byte[] bt = BeneficioDAO.load(id);

			ServletOutputStream out = response.getOutputStream();
			if (bt != null) {
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
