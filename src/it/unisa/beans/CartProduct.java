package it.unisa.beans;

public class CartProduct {
	private static final long serialVersionUID = 1L;
	int quantità;
	private Product prodotto;

	public CartProduct(Product prodotto) {
		super();
		this.setQuantità(0);
		this.prodotto = prodotto;
	}

	public Product getProdotto() {
		return prodotto;
	}

	public int getQuantità() {
		return quantità;
	}

	public void setQuantità(int quantità) {
		this.quantità= quantità;
	}

	public void addProd() {
		this.setQuantità(this.getQuantità() + 1);
	}

	public void delProd() {
		this.setQuantità(this.getQuantità() - 1);
	}

	@Override
	public boolean equals(Object obj) {
		// Se e' lo stesso oggetto ritorna true
		if (obj == this) {
			return true;
		}
		/* Se non e' un istanza di className o obj e' null, ritorna false */
		if (!(obj instanceof CartProduct)) {
			return false;
		}
		// typecast a className in modo da poterli comparare
		CartProduct prod = (CartProduct) obj;
		return prod.getId() == this.getId();
	}

	public int getId() {
		return this.prodotto.getId();
	}

	public String getTotalPriceToString() {
		return String.format("%.0f", getTotalPrice()) + "%";
	}

	public double getTotalPrice() {
		return (double) this.prodotto.getPrezzo() * this.getQuantità();
	}

}
