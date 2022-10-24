package it.unisa.control;

import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import it.unisa.beans.FotoProdotto;
import it.unisa.beans.KitAlberi;
import it.unisa.beans.UsoLocale;
import it.unisa.beans.Albero;
import it.unisa.beans.Beneficio;
import it.unisa.beans.Categoria;
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
@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2MB
		maxFileSize = 1024 * 1024 * 10, // 10MB
		maxRequestSize = 1024 * 1024 * 50) // 50MB
public class ServletProdotto extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public ServletProdotto() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
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
						Albero a = model.doRetriveByKey(id);
						if (a.getQuantità() < quantità + 1) {
							response.sendError(500);
							return;
						}
						carrello.aggiornaProdotti(a, quantità + 1);
					} else if (azione.equals("meno")) {
						if((quantità-1) == 0) {
							carrello.rimuoviProdotto(model.doRetriveByKey(id));
						} else {
							carrello.aggiornaProdotti(model.doRetriveByKey(id), quantità - 1);
						}
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
				} else if (action.equalsIgnoreCase("eliminaAlberoCatalogo")) {
					String id = request.getParameter("id");
					model.doDelete(model.doRetriveByKey(id));
					redirectPage = "/pages/admin.jsp";
				} else if (action.equalsIgnoreCase("eliminaKitCatalogo")) {
					String id = request.getParameter("id");
					model2.doDelete(model2.doRetriveByKey(id));
					redirectPage = "/pages/admin.jsp";
				}
			}
		} catch (SQLException e) {
			System.out.println("Error:" + e.getMessage());
		}

		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(redirectPage);
		dispatcher.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		AlberoDAO model = new AlberoDAO();
		FotoProdottoDAO model1 = new FotoProdottoDAO();
		KitAlberiDAO model2 = new KitAlberiDAO();
		UsoLocaleDAO model3 = new UsoLocaleDAO();
		CategoriaDAO model4 = new CategoriaDAO();
		String action = request.getParameter("action");
		String redirectPage;

		try {
			if (action.equalsIgnoreCase("inserisciKit")) {

				KitAlberi kit = new KitAlberi();

				kit.setNome(request.getParameter("nomeKit"));
				kit.setDescrizione(request.getParameter("descrizioneKit"));

				kit.setSaldo(Double.parseDouble(request.getParameter("saldoKit")));
				String[] alberiId = request.getParameterValues("alberiKit");
				Collection<Albero> alberi = new ArrayList<Albero>();
				for (String i : alberiId) {
					String id = i.substring(3);
					alberi.add(model.doRetriveByKey(id));
				}
				kit.setAlberi(alberi);
				model2.doSave(kit);

				Iterator<KitAlberi> it = model2.doRetriveAll("id DESC").iterator();
				kit = it.next();

				salvaFotoKit(request, kit);
			} else if (action.equalsIgnoreCase("aggiornaKit")) {
				KitAlberi kit = new KitAlberi();

				kit.setNome(request.getParameter("nomeKit"));
				kit.setDescrizione(request.getParameter("descrizioneKit"));
				kit.setId(Integer.parseInt(request.getParameter("idKit")));
				kit.setSaldo(Double.parseDouble(request.getParameter("saldoKit")));
				String[] alberiId = request.getParameterValues("alberiKit");
				Collection<Albero> alberi = new ArrayList<Albero>();
				for (String i : alberiId) {
					String id = i.substring(3);
					alberi.add(model.doRetriveByKey(id));
				}
				kit.setAlberi(alberi);
				model2.doUpdate(kit);

				salvaFotoKit(request, kit);
			} else if (action.equalsIgnoreCase("aggiornaAlbero")) {
				String id = request.getParameter("codiceProdotto");

				String nome = request.getParameter("nome");
				String nomeScientifico = request.getParameter("nomeScientifico");
				double prezzo = Double.parseDouble(request.getParameter("prezzo"));
				String sottotitolo = request.getParameter("sottotitolo");
				String descrizioneBreve = request.getParameter("descrizioneBreve");
				String descrizione = request.getParameter("descrizione");
				int co2 = Integer.parseInt(request.getParameter("co2"));
				int salvaguardia = Integer.parseInt(request.getParameter("salvaguardia"));
				double altezza = Double.parseDouble(request.getParameter("altezza"));
				int onSale = Integer.parseInt(request.getParameter("onSale"));
				double saldo = Double.parseDouble(request.getParameter("saldo"));
				int quantità = Integer.parseInt(request.getParameter("quantità"));
				double tasse = Double.parseDouble(request.getParameter("tasse"));
				String paeseDiOrigine = request.getParameter("paese");
				
				if (paeseDiOrigine.equals("Perù"))
					paeseDiOrigine = "Perù";
			
				int disponibile = Integer.parseInt(request.getParameter("disponibile"));
				String doveVienePiantato = request.getParameter("doveVienePiantato");

				Albero bean = new Albero();
				bean.setAltezza(altezza);
				bean.setCo2(co2);
				bean.setDescrizione(descrizione);
				bean.setDescrizioneBreve(descrizioneBreve);
				bean.setAltezza(altezza);
				bean.setNome(nome);
				bean.setNomeScientifico(nomeScientifico);
				bean.setOnSale(co2);
				bean.setPaeseDiOrigine(paeseDiOrigine);
				bean.setPrezzo(prezzo);
				bean.setQuantità(quantità);
				bean.setSalvaguardia(salvaguardia);
				bean.setSottotitolo(sottotitolo);
				bean.setDoveVienePiantato(doveVienePiantato);
				bean.setOnSale(onSale);
				bean.setSaldo(saldo);
				bean.setTasse(tasse);

				if (disponibile == 0)
					bean.setDisponibile(false);
				else
					bean.setDisponibile(true);

				int sicAlimentare = Integer.parseInt(request.getParameter("ben1"));
				int sviSoste = Integer.parseInt(request.getParameter("ben2"));
				int assCO2 = Integer.parseInt(request.getParameter("ben3"));
				int sviEconomico = Integer.parseInt(request.getParameter("ben4"));

				Collection<Beneficio> benefits = new ArrayList<Beneficio>();
				benefits.add(new Beneficio(1, sicAlimentare));
				benefits.add(new Beneficio(2, sviSoste));
				benefits.add(new Beneficio(4, assCO2));
				benefits.add(new Beneficio(3, sviEconomico));

				String[] catId = request.getParameterValues("categorie");
				Collection<Categoria> categorie = new ArrayList<Categoria>();
				for (String i : catId) {
					String idC = i.substring(3);
					categorie.add(model4.doRetriveByKey(idC));
				}

				String[] usiId = request.getParameterValues("usi");
				Collection<UsoLocale> usi = new ArrayList<UsoLocale>();
				for (String i : usiId) {
					String idU = i.substring(3);
					usi.add(model3.doRetriveByKey(idU));
				}
				bean.setCategorie(categorie);
				bean.setUsiLocali(usi);
				bean.setBenefici(benefits);
				bean.setId(Integer.parseInt(id));

				System.out.println(bean);
				model.doUpdate(bean);

			} else if (action.equalsIgnoreCase("inserisciAlbero")) {
				String nome = request.getParameter("nome");
				String nomeScientifico = request.getParameter("nomeScientifico");
				double prezzo = Double.parseDouble(request.getParameter("prezzo"));
				String sottotitolo = request.getParameter("sottotitolo");
				String descrizioneBreve = request.getParameter("descrizioneBreve");
				String descrizione = request.getParameter("descrizione");
				int co2 = Integer.parseInt(request.getParameter("co2"));
				int salvaguardia = Integer.parseInt(request.getParameter("salvaguardia"));
				double altezza = Double.parseDouble(request.getParameter("altezza"));
				int onSale = Integer.parseInt(request.getParameter("onSale"));
				double saldo = Double.parseDouble(request.getParameter("saldo"));
				int quantità = Integer.parseInt(request.getParameter("quantità"));
				double tasse = Double.parseDouble(request.getParameter("tasse"));
				String paeseDiOrigine = request.getParameter("paese");
				int disponibile = Integer.parseInt(request.getParameter("disponibile"));
				String doveVienePiantato = request.getParameter("doveVienePiantato");

				Albero bean = new Albero();
				bean.setAltezza(altezza);
				bean.setCo2(co2);
				bean.setDescrizione(descrizione);
				bean.setDescrizioneBreve(descrizioneBreve);
				bean.setAltezza(altezza);
				bean.setNome(nome);
				bean.setNomeScientifico(nomeScientifico);
				bean.setOnSale(co2);
				bean.setPaeseDiOrigine(paeseDiOrigine);
				bean.setPrezzo(prezzo);
				bean.setQuantità(quantità);
				bean.setSalvaguardia(salvaguardia);
				bean.setSottotitolo(sottotitolo);
				bean.setDoveVienePiantato(doveVienePiantato);
				bean.setOnSale(onSale);
				bean.setSaldo(saldo);
				bean.setTasse(tasse);

				if (disponibile == 0)
					bean.setDisponibile(false);
				else
					bean.setDisponibile(true);

				int sicAlimentare = Integer.parseInt(request.getParameter("ben1"));
				int sviSoste = Integer.parseInt(request.getParameter("ben2"));
				int assCO2 = Integer.parseInt(request.getParameter("ben3"));
				int sviEconomico = Integer.parseInt(request.getParameter("ben4"));

				Collection<Beneficio> benefits = new ArrayList<Beneficio>();
				benefits.add(new Beneficio(1, sicAlimentare));
				benefits.add(new Beneficio(2, sviSoste));
				benefits.add(new Beneficio(4, assCO2));
				benefits.add(new Beneficio(3, sviEconomico));

				String[] catId = request.getParameterValues("categorie");
				Collection<Categoria> categorie = new ArrayList<Categoria>();
				for (String i : catId) {
					String id = i.substring(3);
					categorie.add(model4.doRetriveByKey(id));
				}

				String[] usiId = request.getParameterValues("usi");
				Collection<UsoLocale> usi = new ArrayList<UsoLocale>();
				for (String i : usiId) {
					String id = i.substring(3);
					usi.add(model3.doRetriveByKey(id));
				}
				bean.setCategorie(categorie);
				bean.setUsiLocali(usi);
				bean.setBenefici(benefits);

				model.doSave(bean);

				Iterator<Albero> it = model.doRetriveAll("id DESC").iterator();
				Collection<FotoProdotto> fotos = model1.doRetriveAll(it.next().getId() + "");
				Iterator<FotoProdotto> it1 = fotos.iterator();
				while (it1.hasNext()) {
					salvaFotoProdotto(request, it1.next().getNomeFoto());
				}
			} else if (action.equalsIgnoreCase("aggiornaFotoAlbero")) {
				String id = request.getParameter("codice");

				salvaFotoProdotto(request, Integer.parseInt(id));

			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		redirectPage = "/pages/admin.jsp";
		RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(redirectPage);
		dispatcher.forward(request, response);
	}

	private void salvaFotoKit(HttpServletRequest request, KitAlberi kit) throws IOException, ServletException {

		String SAVE_DIR = "/uploadTemp";

		String appPath = request.getServletContext().getRealPath("");
		String savePath = appPath + File.separator + SAVE_DIR;

		File fileSaveDir = new File(savePath);
		if (!fileSaveDir.exists()) {
			fileSaveDir.mkdir();
		}

		for (Part part : request.getParts()) {
			String fileName = extractFileName(part);
			if (fileName != null && !fileName.equals("")) {
				part.write(savePath + File.separator + fileName);
				try {
					KitAlberiDAO.updatePhoto(kit.getId(), savePath + File.separator + fileName);
				} catch (SQLException sqlException) {
					System.out.println(sqlException);
				}
			}
		}
	}

	private void salvaFotoProdotto(HttpServletRequest request, int pid) throws IOException, ServletException {

		String SAVE_DIR = "/uploadTemp";

		String appPath = request.getServletContext().getRealPath("");
		String savePath = appPath + File.separator + SAVE_DIR;

		File fileSaveDir = new File(savePath);
		if (!fileSaveDir.exists()) {
			fileSaveDir.mkdir();
		}

		for (Part part : request.getParts()) {
			String fileName = extractFileName(part);
			if (fileName != null && !fileName.equals("")) {
				part.write(savePath + File.separator + fileName);
				try {
					FotoProdottoDAO.updatePhoto(pid, savePath + File.separator + fileName);
				} catch (SQLException sqlException) {
					System.out.println(sqlException);
				}
			}
		}
	}

	private String extractFileName(Part part) {
		String contentDisp = part.getHeader("content-disposition");
		String[] items = contentDisp.split(";");
		for (String s : items) {
			if (s.trim().startsWith("filename")) {
				return s.substring(s.indexOf("=") + 2, s.length() - 1);
			}
		}
		return "";
	}
}
