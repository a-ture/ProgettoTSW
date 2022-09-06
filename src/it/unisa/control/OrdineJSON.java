package it.unisa.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import it.unisa.beans.Ordine;
import it.unisa.model.OrdineDAO;

/**
 * Servlet implementation class OrdineJSON
 */
@WebServlet("/OrdineJSON")
public class OrdineJSON extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Gson gson = new Gson();

	public OrdineJSON() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String code = request.getParameter("codice");
		response.setContentType("application/json");
		OrdineDAO dao = new OrdineDAO();
		String action = request.getParameter("action");
		try {
			if (action != null) {
				if (action.equals("vedi")) {
					Ordine o = dao.doRetriveByKey(code);
					response.setStatus(200);
					response.getWriter().write(gson.toJson(o));
					response.getWriter().flush();
					return;
				} else if (action.equals("vediFoto")) {

				}
			}
		} catch (SQLException e) {
			e.printStackTrace();
			response.setStatus(500);

			return;
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
