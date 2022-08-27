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
import it.unisa.beans.KitAlberi;
import it.unisa.beans.UsoLocale;
import it.unisa.beans.Albero;
import it.unisa.model.CategoriaDAO;
import it.unisa.model.FotoProdottoDAO;
import it.unisa.model.KitAlberiDAO;
import it.unisa.model.AlberoDAO;
import it.unisa.model.UsoLocaleDAO;

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

		String sort = request.getParameter("sort");

		Collection<Albero> prodotti = new ArrayList<Albero>();
		Collection<KitAlberi> kits = new ArrayList<KitAlberi>();
		Collection<Categoria> categorie = new ArrayList<Categoria>();
		Collection<UsoLocale> usiLocali = new ArrayList<UsoLocale>();

		AlberoDAO model = new AlberoDAO();
		CategoriaDAO model2 = new CategoriaDAO();
		KitAlberiDAO model3 = new KitAlberiDAO();
		UsoLocaleDAO model4 = new UsoLocaleDAO();

		try {
			categorie = model2.doRetriveAll(null);
			request.removeAttribute("categorie");
			request.setAttribute("categorie", categorie);
		} catch (SQLException e) {
			e.printStackTrace();
		}

		try {
			usiLocali = model4.doRetriveAll(null);
			request.removeAttribute("usiLocali");
			request.setAttribute("usiLocali", usiLocali);
		} catch (SQLException e2) {
			e2.printStackTrace();
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

		try {
			kits = model3.doRetriveAll(null);
		} catch (SQLException e1) {
			e1.printStackTrace();
		}
		request.removeAttribute("kits");
		request.setAttribute("kits", kits);

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
		String action = request.getParameter("action");
		if (action != null) {
			if (action.equals("saldi")) {
				try {
					prodotti = model.doRetriveBySale();
				} catch (SQLException e) {
					e.printStackTrace();
				}
				request.removeAttribute("prodotti");
				request.setAttribute("prodotti", prodotti);
			}
		}
		String redirectPage = "/pages/catalogo.jsp";
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(redirectPage);
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
