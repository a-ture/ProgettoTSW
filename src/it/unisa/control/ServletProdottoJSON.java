package it.unisa.control;

import java.io.IOException;
import java.sql.SQLException;
import java.util.Collection;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import it.unisa.beans.Albero;
import it.unisa.beans.FotoProdotto;
import it.unisa.model.AlberoDAO;
import it.unisa.model.FotoProdottoDAO;

/**
 * Servlet implementation class ProdottoJSON
 */
@WebServlet("/ProdottoJSON")
public class ServletProdottoJSON extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Gson gson = new Gson();

	public ServletProdottoJSON() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String code = request.getParameter("codice");
		String action = request.getParameter("action");

		response.setContentType("application/json ; charset=UTF-8");

		AlberoDAO dao = new AlberoDAO();
		FotoProdottoDAO dao1 = new FotoProdottoDAO();

		if (action != null) {
			if (action.equals("vista")) {
				try {

					Albero a = dao.doRetriveByKey(code);
					response.setStatus(200);

					// Da vedere come cambiare -> scrivere in cookie
					response.getWriter().write(gson.toJson(a));
					response.getWriter().flush();
					return;
				} catch (SQLException e) {
					e.printStackTrace();
					response.setStatus(500);
					return;
				}
			} else if (action.equals("vediFoto")) {
				Collection<FotoProdotto> f;
				try {
					f = dao1.doRetriveAll(code);
					response.setStatus(200);
					response.getWriter().print(gson.toJson(f));
					response.getWriter().flush();
					return;
				} catch (SQLException e) {
					e.printStackTrace();
					response.setStatus(500);
					return;
				}

			}
		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		doGet(request, response);
	}

}
