package it.unisa.control;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import it.unisa.model.BeneficioDAO;
import it.unisa.model.CategoriaDAO;
import it.unisa.model.FotoProdottoDAO;
import it.unisa.model.KitAlberiDAO;
import it.unisa.model.OrdineDAO;
import it.unisa.model.PaeseDiOrigineDAO;
import it.unisa.model.UsoLocaleDAO;
import it.unisa.model.UtenteDAO;

/**
 * Servlet per recuperare di foto dal database
 */
@WebServlet("/ServletResources")
public class ServletResources extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ServletResources() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		//prendo il parametro che mi indica quale azione richiamare
		String codiceAzione = request.getParameter("codiceAzione");
		
		switch (codiceAzione) {
		case "fotoBeneficio": {
			String id = request.getParameter("idBeneficio");
			if (id == null) return;
			recuperoFotoBeneficio(id,response);
			break;
		}
		case "fotoCategoria": {
			String id = request.getParameter("idCategoria");
			if(id == null) return;
			recuperoFotoCategoria(id,response);
			break;
		}
		case "fotoKit": {
			String id = request.getParameter("idKit");
			if(id == null) return;
			recuperoFotoKit(id,response);
			break;
		}
		case "fotoPaeseDiOrigine": {
			String id = request.getParameter("idPaese");
			if(id == null) return;
			recuperoFotoPaeseDiOrigine(id,response);
			break;
		}
		case "fotoProdotto": {
			int id = Integer.parseInt(request.getParameter("idFoto"));
			recuperoFotoProdotto(id,response);
			break;
		}
		case "fotoProdottoOrdine": {
			String id = (String) request.getParameter("idProdottoOrdine");
			if(id == null) return;
			recuperoFotoProdottoOrdine(id,response);
			break;
		}
		case "fotoUsoLocale": {
			String id = (String) request.getParameter("idUsoLocale");
			if(id == null) return;
			recuperoFotoUsoLocale(id,response);
			break;
		}
		default:
			return;
		}
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException {
		doGet(request, response);
	}
	
	private void recuperoFotoBeneficio(String idBeneficio, HttpServletResponse response) 
			throws ServletException, IOException {
		byte[] bt = BeneficioDAO.load(idBeneficio);

		ServletOutputStream out = response.getOutputStream();
		if (bt != null) {
			out.write(bt);
			response.setContentType("image/jpeg");
		}
		out.close();
	}
	
	private void recuperoFotoCategoria(String idCategoria, HttpServletResponse response) 
			throws ServletException, IOException {
		byte[] bt = CategoriaDAO.load(idCategoria);

		ServletOutputStream out = response.getOutputStream();
		if (bt != null) {
			out.write(bt);
			response.setContentType("image/jpeg");
		}
		out.close();
	}

	private void recuperoFotoKit(String idKit, HttpServletResponse response) 
			throws ServletException, IOException {
		byte[] bt = KitAlberiDAO.load(idKit);
		
		ServletOutputStream out = response.getOutputStream();
		if (bt != null) {
			System.out.print(bt);
			out.write(bt);
			response.setContentType("image/jpeg");
		}
		out.close();
	}
	
	private void recuperoFotoPaeseDiOrigine(String idPaese, HttpServletResponse response)
			throws ServletException, IOException {
		byte[] bt = PaeseDiOrigineDAO.load(idPaese);

		ServletOutputStream out = response.getOutputStream();
		if (bt != null) {
			System.out.print(bt);
			out.write(bt);
			response.setContentType("image/jpeg");
		}
		out.close();
	}
	
	private void recuperoFotoProdotto(int idFoto, HttpServletResponse response) 
			throws ServletException, IOException {
		FotoProdottoDAO model = new FotoProdottoDAO();
		byte[] bt = model.load(idFoto);
		
		ServletOutputStream out = response.getOutputStream();
		if (bt != null) {
			out.write(bt);
			response.setContentType("image/jpeg");
		}
		out.close();
	}
	
	private void recuperoFotoProdottoOrdine(String idProdottoOrdine,HttpServletResponse response) 
			throws ServletException, IOException {
		byte[] bt = OrdineDAO.load(idProdottoOrdine);

		ServletOutputStream out = response.getOutputStream();
		if (bt != null) {
			out.write(bt);
			response.setContentType("image/jpeg");
		}
		out.close();
	}
	
	private void recuperoFotoUsoLocale(String idUsoLocale,HttpServletResponse response)
			throws ServletException, IOException {
		byte[] bt = UsoLocaleDAO.load(idUsoLocale);

		ServletOutputStream out = response.getOutputStream();
		if (bt != null) {
			out.write(bt);
			response.setContentType("image/jpeg");
		}
		out.close();
	}
	

}
