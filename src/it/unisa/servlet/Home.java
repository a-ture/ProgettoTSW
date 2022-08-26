package it.unisa.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.beans.FotoProdotto;
import it.unisa.beans.Albero;
import it.unisa.model.FotoProdottoDAO;
import it.unisa.model.AlberoDAO;

/**
 * Servlet implementation class Home
 */
@WebServlet("/Home")
public class Home extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * Default constructor.
	 */
	public Home() {
		// TODO Auto-generated constructor stub
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		AlberoDAO model = new AlberoDAO();
		Collection<Albero> prodotti = new ArrayList<Albero>();

		try {
			prodotti = model.doRetriveAll("");
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		request.setAttribute("prodotti", prodotti);
		
		if (prodotti != null && prodotti.size() != 0) {
			FotoProdottoDAO model1 = new FotoProdottoDAO();
			Collection<FotoProdotto> photos = new ArrayList<FotoProdotto>();
			Iterator<?> it = prodotti.iterator();
			while (it.hasNext()) {
				Albero beanProd = (Albero) it.next();
				int id = beanProd.getId();
				try {
					FotoProdotto beanPhoto = model1.doRetriveOne(id);
					photos.add(beanPhoto);
				} catch (SQLException e) {
					System.out.print(e);
				}
			}
			request.removeAttribute("fotoProdotti");
			request.setAttribute("fotoProdotti", photos);
		}

		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher("/pages/home.jsp");
		dispatcher.forward(request, response);
	}

}
