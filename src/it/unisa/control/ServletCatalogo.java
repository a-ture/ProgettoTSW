package it.unisa.control;

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
import it.unisa.beans.UsoLocale;
import it.unisa.beans.Albero;
import it.unisa.model.CategoriaDAO;
import it.unisa.model.FotoProdottoDAO;
import it.unisa.model.AlberoDAO;
import it.unisa.model.UsoLocaleDAO;

/**
 * Servlet per gestire la visione del calalogo in base alle sue categorie
 */
@WebServlet("/Catalogo")
public class ServletCatalogo extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ServletCatalogo() {
		super();

	}

	/**
	 * Mostra il catalogo analizzando il paramtro action
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String action = request.getParameter("action");

		Collection<Albero> prodotti = new ArrayList<Albero>();

		Collection<Categoria> categorie = new ArrayList<Categoria>();
		Collection<UsoLocale> usiLocali = new ArrayList<UsoLocale>();

		AlberoDAO model = new AlberoDAO();
		CategoriaDAO model2 = new CategoriaDAO();
		UsoLocaleDAO model4 = new UsoLocaleDAO();

		if (action != null) {
			if (action.equals("prezzo")) {
				String sort = request.getParameter("sort");
			
				try {
					prodotti = model.doRetriveAll(sort);


				} catch (SQLException e1) {
					e1.printStackTrace();

				}
				request.removeAttribute("prodotti");
				request.setAttribute("prodotti", prodotti);

			
			} else if (action.equals("saldi")) {
				// esegue un filtro che restituisce il catalogo ordinato in base ai saldi
				try {
					Iterator<Albero> it = model.doRetriveAll(null).iterator();
					while (it.hasNext()) {
						Albero albero = it.next();
						if (albero.getOnSale() != 0) {
							prodotti.add(albero);
						}
					}
				} catch (SQLException e) {
					e.printStackTrace();
				}
				request.removeAttribute("prodotti");

				request.setAttribute("prodotti", prodotti);

			} else if (action.equals("categoria")) {
				// esegue un filtro che restituisce il catalogo ordinato in base alla categoria
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
			} else if (action.equals("vediAlberi")) {
				// esegue un filtro che restituisce il catalogo ordinato in base agli alberi
				try {
					prodotti = model.doRetriveAll("");
				} catch (SQLException e) {

					e.printStackTrace();
				}
				request.removeAttribute("prodotti");
				request.setAttribute("prodotti", prodotti);
			
			}  else if (action.equals("paese")) {
				// esegue un filtro che restituisce il catalogo ordinato in base al paese
				String paese = request.getParameter("paese");
				if (paese != null) {
					try {
						Iterator<Albero> it = model.doRetriveAll(null).iterator();
						while (it.hasNext()) {
							Albero albero = it.next();
							if (albero.getPaeseDiOrigine().equals(paese)) {
								prodotti.add(albero);
							}
						}

					} catch (SQLException e) {
						e.printStackTrace();
					}
					request.removeAttribute("prodotti");
					request.setAttribute("prodotti", prodotti);
				}
			} else if (action.equals("usoLocale")) {
				// esegue un filtro che restituisce il catalogo ordinato in base all'uso
				String usoLocale = request.getParameter("usoLocale");
				try {
					Iterator<Albero> it = model.doRetriveAll(null).iterator();
					while (it.hasNext()) {
						Albero albero = it.next();
						Collection<UsoLocale> usi = albero.getUsiLocali();
						Iterator<UsoLocale> it1 = usi.iterator();
						while (it1.hasNext()) {
							UsoLocale uso = it1.next();
							if (uso.getNome().equals(usoLocale)) {
								prodotti.add(albero);
							}
						}
					}

				} catch (SQLException e) {
					e.printStackTrace();
				}
				request.removeAttribute("prodotti");
				request.setAttribute("prodotti", prodotti);

			} else if (action.equals("vediAlbero")) {
				// rindirizza alla pagina del prodotto cercato
				String s = request.getParameter("s");
				try {
					Iterator<Albero> it = model.doRetriveAll(null).iterator();
					while (it.hasNext()) {
						Albero albero = it.next();
						if (albero.getSottotitolo().equalsIgnoreCase(s)) {
							response.sendRedirect("Prodotto?action=leggiProdotto&id=" + albero.getId());
							return;
						}
					}

				} catch (SQLException e) {
					e.printStackTrace();
				}
			}
		} else {
			// azione di default: mostra il catalogo senza filtri
			try {
				prodotti = model.doRetriveAll(null);

			} catch (SQLException e) {

				e.printStackTrace();
			}
			request.removeAttribute("prodotti");
			request.setAttribute("prodotti", prodotti);
		}

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

		String redirectPage = "/pages/catalogo.jsp";
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(redirectPage);
		dispatcher.forward(request, response);
	}

	/**
	 * Metodo Post che richiama il doGet
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
