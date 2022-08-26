package it.unisa.beans;

import java.io.Serializable;

public class ProdottoCarrello implements Serializable {
	private static final long serialVersionUID = 1L;
	int quantità;
	private Albero prodotto;
	double sconto;

	public ProdottoCarrello(Albero prodotto) {
		super();
		this.setQuantità(0);
		this.prodotto = prodotto;

		this.sconto = prodotto.getSaldo();

	}

	public Albero getProdotto() {
		return prodotto;
	}

	public int getQuantità() {
		return quantità;
	}

	public void setQuantità(int quantità) {
		this.quantità = quantità;
	}

	public void aggiungiProdotto() {
		this.setQuantità(this.getQuantità() + 1);
	}

	public void rimuoviProdotto() {
		this.setQuantità(this.getQuantità() - 1);
	}

	@Override
	public boolean equals(Object obj) {

		if (obj == this) {
			return true;
		}

		if (!(obj instanceof ProdottoCarrello)) {
			return false;
		}

		ProdottoCarrello prod = (ProdottoCarrello) obj;
		return prod.getId() == this.getId();
	}

	public int getId() {
		return this.prodotto.getId();
	}

	public double getPrezzoTotale() {
		double prezzo;

		if (sconto != 0) {
			double s = (this.prodotto.getPrezzo() * sconto) / 100;
			prezzo = this.prodotto.getPrezzo() - s;
		} else
			prezzo = this.prodotto.getPrezzo();
		return prezzo * this.getQuantità();
	}

	public double getSconto() {
		return sconto;
	}

	public void setSconto(double sconto) {
		this.sconto = sconto;
	}

}
