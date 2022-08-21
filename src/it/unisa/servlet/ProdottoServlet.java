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
import it.unisa.model.Carrello;
import it.unisa.model.FotoProdottoDAO;
import it.unisa.model.ProdottoDAO;

/**
 * Servlet implementation class Prodotto
 */
@WebServlet("/Prodotto")
public class ProdottoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ProdottoServlet() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		ProdottoDAO model = new ProdottoDAO();

		Carrello carrello = (Carrello) request.getSession().getAttribute("carrello");
		if (carrello == null) {
			carrello = new Carrello();
			request.getSession().setAttribute("carrello", carrello);
		}

		String action = request.getParameter("action");
		String redirectPage = "/pages/paginaProdotto.jsp";

		try {
			if (action != null) {
				if (action.equalsIgnoreCase("aggiungiCarrello")) {
					String id = request.getParameter("id");
					carrello.aggiungiProdotto(model.doRetriveByKey(id));
					redirectPage = "/pages/cart.jsp";
				} else if (action.equalsIgnoreCase("eliminaProdottoCarrello")) {
					String id = request.getParameter("id");
					carrello.rimuoviProdotto(model.doRetriveByKey(id));
					redirectPage = "/pages/cart.jsp";
				} else if (action.equalsIgnoreCase("svuotaCarrello")) {
					carrello.rimuoviTutti();
					redirectPage = "/pages/cart.jsp";
				} else if (action.equalsIgnoreCase("aggiornaQuantitàProdotto")) {
					String id = request.getParameter("id");
					int quantità = Integer.parseInt(request.getParameter("quantità"));
					String azione = request.getParameter("azione");
					if (azione.equals("più")) {
						carrello.aggiornaProdotti(model.doRetriveByKey(id), quantità + 1);
					} else if (azione.equals("meno")) {
						carrello.aggiornaProdotti(model.doRetriveByKey(id), quantità - 1);
					}
					redirectPage = "/pages/cart.jsp";
				} else if (action.equalsIgnoreCase("visualizzaCarrello")) {
					redirectPage = "/pages/cart.jsp";
				} else if (action.equalsIgnoreCase("leggi")) {

					String id = request.getParameter("id");
					request.removeAttribute("prodotto");
					request.setAttribute("prodotto", model.doRetriveByKey(id));
					// devo prendere le foto
					FotoProdottoDAO model1 = new FotoProdottoDAO();
					Collection<FotoProdotto> photo = null;
					try {
						photo = model1.doRetriveAll(id);
					} catch (SQLException e) {
						System.out.println(e);
					}

					Collection<Categoria> categorie = new ArrayList<Categoria>();
					categorie = model.findProductCategory(Integer.parseInt(id));
					request.removeAttribute("categorieProdotto");
					request.setAttribute("categorieProdotto", categorie);

					FotoProdotto[] ph = photo.toArray(FotoProdotto[]::new);
					request.removeAttribute("prodottoFoto");
					request.getSession().setAttribute("prodottoFoto", ph);

					Collection<Prodotto> prodotti = new ArrayList<Prodotto>();
					try {
						prodotti = model.doRetriveAll("");
					} catch (SQLException e1) {
						e1.printStackTrace();
					}
					request.setAttribute("prodotti", prodotti);
					if (prodotti != null && prodotti.size() != 0) {

						Collection<FotoProdotto> photos = new ArrayList<FotoProdotto>();
						Iterator<?> it = prodotti.iterator();
						while (it.hasNext()) {
							Prodotto beanProd = (Prodotto) it.next();
							int idProdotto = beanProd.getId();
							try {
								FotoProdotto beanPhoto = model1.doRetriveOne(idProdotto);
								photos.add(beanPhoto);
							} catch (SQLException e) {
								System.out.print(e);
							}
						}
						request.removeAttribute("fotoProdotti");
						request.setAttribute("fotoProdotti", photos);
					}
				} else if (action.equalsIgnoreCase("eliminaProdottoCatalogo")) {
					String id = request.getParameter("id");
					model.doDelete(model.doRetriveByKey(id));
				} else if (action.equalsIgnoreCase("inserisciProdottoCatalogo")) { // MI MANCA LA CATEGORIA

					String nome = request.getParameter("nome");
					String descrizione = request.getParameter("descrizione");
					String descrizioneBreve = request.getParameter("descrizioneBreve");
					String nomeScientifico = request.getParameter("nomeScientifico");
					String paeseDiOrigine = request.getParameter("paeseDiOrigine");
					int prezzo = Integer.parseInt(request.getParameter("prezzo"));
					int quantità = Integer.parseInt(request.getParameter("quantità"));
					int altezza = Integer.parseInt(request.getParameter("altezza"));
					int co2 = Integer.parseInt(request.getParameter("co2"));
					int salvaguardia = Integer.parseInt(request.getParameter("salvaguardia"));

					Prodotto bean = new Prodotto();
					bean.setAltezza(altezza);
					// bean.setCategories();
					bean.setCo2(co2);
					bean.setDescrizione(descrizione);
					bean.setDescrizioneBreve(descrizioneBreve);
					bean.setId(altezza);
					bean.setNome(nome);
					bean.setNomeScientifico(nomeScientifico);
					bean.setOnSale(co2);
					bean.setPaeseDiOrigine(paeseDiOrigine);
					bean.setPrezzo(prezzo);
					bean.setQuantità(quantità);
					bean.setSalvaguardia(salvaguardia);

					model.doSave(bean);
				}
			}
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}
		System.out.println(redirectPage);

		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(redirectPage);
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
