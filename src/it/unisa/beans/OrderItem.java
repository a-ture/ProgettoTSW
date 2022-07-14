package it.unisa.beans;

public class OrderItem {

	private int id;
	private int oid;
	private String nome;
	private String descrizione;
	private String breveDescrizione;
	private int tasse;
	private double prezzo;
	private double saldo;
	private int quantità;

	public OrderItem(int id, int oid, String nome, String descrizione, String breveDescrizione, int tasse,
			double prezzo, double saldo, int quantità) {
		super();
		this.id = id;
		this.oid = oid;
		this.nome = nome;
		this.descrizione = descrizione;
		this.breveDescrizione = breveDescrizione;
		this.tasse = tasse;
		this.prezzo = prezzo;
		this.saldo = saldo;
		this.quantità = quantità;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getOid() {
		return oid;
	}

	public void setOid(int oid) {
		this.oid = oid;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getDescrizione() {
		return descrizione;
	}

	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}

	public String getBreveDescrizione() {
		return breveDescrizione;
	}

	public void setBreveDescrizione(String breveDescrizione) {
		this.breveDescrizione = breveDescrizione;
	}

	public int getTasse() {
		return tasse;
	}

	public void setTasse(int tasse) {
		this.tasse = tasse;
	}

	public double getPrezzo() {
		return prezzo;
	}

	public void setPrezzo(double prezzo) {
		this.prezzo = prezzo;
	}

	public double getSaldo() {
		return saldo;
	}

	public void setSaldo(double saldo) {
		this.saldo = saldo;
	}

	public int getQuantità() {
		return quantità;
	}

	public void setQuantità(int quantità) {
		this.quantità = quantità;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((breveDescrizione == null) ? 0 : breveDescrizione.hashCode());
		result = prime * result + ((descrizione == null) ? 0 : descrizione.hashCode());
		result = prime * result + id;
		result = prime * result + ((nome == null) ? 0 : nome.hashCode());
		result = prime * result + oid;
		long temp;
		temp = Double.doubleToLongBits(prezzo);
		result = prime * result + (int) (temp ^ (temp >>> 32));
		result = prime * result + quantità;
		temp = Double.doubleToLongBits(saldo);
		result = prime * result + (int) (temp ^ (temp >>> 32));
		result = prime * result + tasse;
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		OrderItem other = (OrderItem) obj;
		if (breveDescrizione == null) {
			if (other.breveDescrizione != null)
				return false;
		} else if (!breveDescrizione.equals(other.breveDescrizione))
			return false;
		if (descrizione == null) {
			if (other.descrizione != null)
				return false;
		} else if (!descrizione.equals(other.descrizione))
			return false;
		if (id != other.id)
			return false;
		if (nome == null) {
			if (other.nome != null)
				return false;
		} else if (!nome.equals(other.nome))
			return false;
		if (oid != other.oid)
			return false;
		if (Double.doubleToLongBits(prezzo) != Double.doubleToLongBits(other.prezzo))
			return false;
		if (quantità != other.quantità)
			return false;
		if (Double.doubleToLongBits(saldo) != Double.doubleToLongBits(other.saldo))
			return false;
		if (tasse != other.tasse)
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "OrderItem [id=" + id + ", oid=" + oid + ", nome=" + nome + ", descrizione=" + descrizione
				+ ", breveDescrizione=" + breveDescrizione + ", tasse=" + tasse + ", prezzo=" + prezzo + ", saldo="
				+ saldo + ", quantità=" + quantità + "]";
	}

}
