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
import it.unisa.beans.KitAlberi;
import it.unisa.beans.Albero;
import it.unisa.model.Carrello;
import it.unisa.model.CategoriaDAO;
import it.unisa.model.FotoProdottoDAO;
import it.unisa.model.KitAlberiDAO;
import it.unisa.model.AlberoDAO;
import it.unisa.model.UsoLocaleDAO;

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

		AlberoDAO model = new AlberoDAO();
		FotoProdottoDAO model1 = new FotoProdottoDAO();
		KitAlberiDAO model2 = new KitAlberiDAO();
		UsoLocaleDAO model3 = new UsoLocaleDAO();
		CategoriaDAO model4 = new CategoriaDAO();

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
					Albero prod = model.doRetriveByKey(id);
					if (!prod.isDisponibile()) {
						response.sendError(500);
						return;
					}
					carrello.aggiungiProdotto(prod);
					redirectPage = "/pages/cart.jsp";
				} else if (action.equalsIgnoreCase("aggiungiCarrelloKit")) {
					String id = request.getParameter("idKit");
					KitAlberi kit = model2.doRetriveByKey(id);

					Collection<Albero> alberi = kit.getAlberi();
					if (alberi != null && alberi.size() != 0) {
						Iterator<Albero> it = alberi.iterator();
						while (it.hasNext()) {
							Albero albero = it.next();
							albero.setSaldo(kit.getSaldo());
							carrello.aggiungiProdotto(albero);
						}
					}
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
				} else if (action.equalsIgnoreCase("leggiProdotto")) {

					String id = request.getParameter("id");
					request.removeAttribute("prodotto");
					request.setAttribute("prodotto", model.doRetriveByKey(id));

					Collection<FotoProdotto> photo = null;
					try {
						photo = model1.doRetriveAll(id);
					} catch (SQLException e) {
						System.out.println(e);
					}

					FotoProdotto[] ph = photo.toArray(FotoProdotto[]::new);
					request.removeAttribute("prodottoFoto");
					request.getSession().setAttribute("prodottoFoto", ph);

					Collection<Albero> prodotti = new ArrayList<Albero>();
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
							Albero beanProd = (Albero) it.next();
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

					request.setAttribute("usiLocali", model3.doRetriveAll(null));
					request.setAttribute("categorie", model4.doRetriveAll(null));

				} else if (action.equalsIgnoreCase("leggiKit")) {
					String id = request.getParameter("idKit");

					KitAlberi kit = model2.doRetriveByKey(id);
					request.removeAttribute("kit");
					request.setAttribute("kit", kit);

					FotoProdotto[] fotoKit = new FotoProdotto[kit.getAlberi().size()];

					Iterator<?> it1 = kit.getAlberi().iterator();
					int i = 0;
					while (it1.hasNext()) {
						Albero beanProd = (Albero) it1.next();
						int idProdotto = beanProd.getId();
						try {
							FotoProdotto beanPhoto = model1.doRetriveOne(idProdotto);
							fotoKit[i] = beanPhoto;

							i++;

						} catch (SQLException e) {
							System.out.print(e);
						}
					}
					request.removeAttribute("fotoKit");
					request.setAttribute("fotoKit", fotoKit);

					Collection<Albero> prodotti = new ArrayList<Albero>();
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
							Albero beanProd = (Albero) it.next();
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

					redirectPage = "/pages/paginaKit.jsp";
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

					Albero bean = new Albero();
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
		} catch (

		SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}

		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(redirectPage);
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
