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
 * Servlet implementation class KitJSON
 */
@WebServlet("/KitJSON")
public class ServletKitJSON extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Gson gson = new Gson();

	public ServletKitJSON() {
		super();
		
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String code = request.getParameter("codice");
		response.setContentType("application/json");
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

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
