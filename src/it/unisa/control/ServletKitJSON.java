package it.unisa.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import it.unisa.beans.KitAlberi;
import it.unisa.model.KitAlberiDAO;

/**
 * Servlet che fa visualizza il contenuto dei kit in formato JSON
 */
@WebServlet("/KitJSON")
public class ServletKitJSON extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Gson gson = new Gson();

	public ServletKitJSON() {
		super();

	}
	
	/**
	 * Metodo Get per vedere tutti i prodotti alberi che fanno parte del kit avente il codice passato come paramtro
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String code = request.getParameter("codice");
		response.setContentType("application/json ; charset=UTF-8");
		KitAlberiDAO dao = new KitAlberiDAO();
		try {
			KitAlberi o = dao.doRetriveByKey(code);

			response.setStatus(200);
			response.getWriter().print(gson.toJson(o));
			response.getWriter().flush();
			return;
		} catch (SQLException e) {
			e.printStackTrace();
			response.setStatus(500);

			return;
		}
	}
	
	/**
	 * Metodo Post che richiama il doGet
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
