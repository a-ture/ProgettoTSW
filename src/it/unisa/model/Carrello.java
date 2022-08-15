package it.unisa.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import it.unisa.beans.Prodotto;
import it.unisa.beans.ProdottoCarrello;

public class Carrello implements Serializable {
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	
	List<ProdottoCarrello> prodotti;

	public Carrello() {
		prodotti = new ArrayList<>();
	}

	public void aggiungiProdotto(Prodotto product) {
		ProdottoCarrello cartProd = new ProdottoCarrello(product);
		if (prodotti.contains(cartProd)) {
			var prod = prodotti.get(prodotti.indexOf(cartProd));
			prod.setQuantità(prod.getQuantità() + 1);
		} else {

			cartProd.setQuantità(1);
			prodotti.add(cartProd);
		}
	}

	public void rimuoviProdotto(Prodotto product) {
		ProdottoCarrello cartProd = new ProdottoCarrello(product);
		for (ProdottoCarrello prod : prodotti) {
			if (prod.equals(cartProd)) {
				prodotti.remove(prod);
				break;
			}
		}
	}

	public boolean isEmpty() {
		return prodotti.size() > 0 ? false : true;
	}

	public List<ProdottoCarrello> getProdotti() {
		return prodotti;
	}

	public int getQuantitàTotaleProdotti() {
		var sum = 0;
		for (ProdottoCarrello prod : prodotti) {
			sum += prod.getQuantità();
		}
		return sum;
	}

	public double getPrezzoTotaleProdotti() {
		double sum = 0;
		for (ProdottoCarrello prod : prodotti) {
			sum += prod.getPrezzoTotale();
		}
		return sum;
	}

	public void rimuoviTutti() {
		prodotti = new ArrayList<>();

	}

	public void aggiornaProdotti(Prodotto prodotto, int quantità) {
		ProdottoCarrello cartProd = new ProdottoCarrello(prodotto);
		if (prodotti.contains(cartProd)) {
			var prod = prodotti.get(prodotti.indexOf(cartProd));
			prod.setQuantità(quantità);
		}
	}

}
