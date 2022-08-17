package it.unisa.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.model.UtenteDAO;

/**
 * Servlet implementation class GetFotoUtente
 */
@WebServlet("/GetFotoUtente")
public class GetFotoUtente extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public GetFotoUtente() {
		super();
		// TODO Auto-generated constructor stub
	}

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

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
