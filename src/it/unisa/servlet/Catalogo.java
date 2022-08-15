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

import it.unisa.beans.Categoria;
import it.unisa.beans.FotoProdotto;
import it.unisa.beans.Prodotto;
import it.unisa.model.CategoriaDAO;
import it.unisa.model.FotoProdottoDAO;
import it.unisa.model.ProdottoDAO;

/**
 * Servlet implementation class Catalogo
 */
@WebServlet("/Catalogo")
public class Catalogo extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Catalogo() {
		super();

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		ProdottoDAO model = new ProdottoDAO();
		String sort = request.getParameter("sort");
		Collection<Prodotto> prodotti = new ArrayList<Prodotto>();

		Collection<Categoria> categorie = new ArrayList<Categoria>();

		CategoriaDAO model2 = new CategoriaDAO();
		request.removeAttribute("categorie");
		try {
			categorie = model2.doRetriveAll(null);
			request.setAttribute("categorie", categorie);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		try {
			prodotti = model.doRetriveAll(sort);
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		request.removeAttribute("prodotti");
		request.setAttribute("prodotti", prodotti);

		if (prodotti != null && prodotti.size() != 0) {
			FotoProdottoDAO model1 = new FotoProdottoDAO();
			Collection<FotoProdotto> photos = new ArrayList<FotoProdotto>();
			Iterator<?> it = prodotti.iterator();
			while (it.hasNext()) {
				Prodotto beanProd = (Prodotto) it.next();
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
		String paese = request.getParameter("paese");
		if (paese != null) {
			try {
				prodotti = model.findProductCountry(paese);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			request.removeAttribute("prodotti");
			request.setAttribute("prodotti", prodotti);
		}
		String categoria = request.getParameter("categoria");
		if (categoria != null) {
			int id = Integer.parseInt(categoria);
			try {
				prodotti = model.findProducbyCategory(id);
			} catch (SQLException e) {
				e.printStackTrace();
			}
			request.removeAttribute("prodotti");
			request.setAttribute("prodotti", prodotti);
		}
		String redirectPage = "/pages/catalogo.jsp";
		System.out.println(redirectPage);
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(redirectPage);
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
