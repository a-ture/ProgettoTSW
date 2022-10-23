package it.unisa.control;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import it.unisa.beans.Utente;
import it.unisa.model.UtenteDAO;

/**
 * Servlet implementation class UserApiServlet
 */
@WebServlet("/Api/Utente")
public class UtenteApiServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String contentType = "application/json; charset=UTF-8";
	private String action;
	private Gson gson = new Gson();

	@Override
	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		if (request.getHeader("x-requested-with") == null) {
			response.sendError(500);
			return;
		}
		this.action = request.getParameter("action");
		response.setContentType(contentType);
		super.service(request, response);
	}

	/**
	   * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	   */
	  protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	    if(action.equals("checkEmail")) {
	      UtenteDAO dao = new UtenteDAO();
	      try {
	        Utente u = dao.doRetriveByEmail(request.getParameter("email"));
	        response.setStatus(200);
	        response.getWriter().print(gson.toJson(u.getEmail() == null ? "ok" : "no"));
	        response.getWriter().flush();
	        return;
	      } catch (SQLException e) {
	        response.setStatus(500);
	        response.getWriter().print(gson.toJson( "error"));
	        response.getWriter().flush();
	        return;
	      }
	    }
	    if(action.equals("checkUsername")) {
	    	 UtenteDAO dao = new UtenteDAO();
	    	 try {
	    		 Utente u = dao.doRetriveByUsername(request.getParameter("username"));
	 	        response.setStatus(200);
	 	        response.getWriter().print(gson.toJson(u.getUsername() == null ? "ok" : "no"));
	 	        response.getWriter().flush();
		        return;
		      } catch (SQLException e) {
		        response.setStatus(500);
		        response.getWriter().print(gson.toJson( "error"));
		        response.getWriter().flush();
		        return;
		      }
	    }
	   
	    
	    
	  }

}
