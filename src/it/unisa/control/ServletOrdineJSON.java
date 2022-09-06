package it.unisa.control;

import java.io.IOException;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Collection;
import java.util.Date;

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
public class ServletOrdineJSON extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private Gson gson = new Gson();

	public ServletOrdineJSON() {
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

				} else if (action.equals("data")) {
					String date = request.getParameter("date");
					String data1 = date.substring(0, 8);
					String data2 = date.substring(11, 19);

					System.out.println("1:" + data1);
					System.out.println("2:" + data2);

					System.out.println(convertStringToTimestamp(data1));
					System.out.println(convertStringToTimestamp(data2));

					Collection<Ordine> c = dao.doRetrieveOrdersBetween(convertStringToTimestamp(data1),
							convertStringToTimestamp(data2));

					System.out.println(c);
					response.getWriter().write(gson.toJson(c));
					response.getWriter().flush();

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

	public static Timestamp convertStringToTimestamp(String strDate) {
		try {
			DateFormat formatter = new SimpleDateFormat("dd/MM/yy");

			Date date = formatter.parse(strDate);
			Timestamp timeStampDate = new Timestamp(date.getTime());

			return timeStampDate;
		} catch (ParseException e) {
			System.out.println("Exception :" + e);
			return null;
		}
	}
}
