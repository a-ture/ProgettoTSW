package it.unisa.beans;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;

public class Prodotto implements Serializable {
	private static final long serialVersionUID = 1L;

	// DA VEDERE SE MI SERVE
	public static int NO_ITEM = -1;

	static boolean isProductInizialize(Prodotto b) {
		return b.getId() != NO_ITEM;
	}

	private int id;
	private String nome;
	private String nomeScientifico;
	private String paeseDiOrigine;
	private String descrizione;
	private String descrizioneBreve;

	// NON SO A CHE MERDA SERVEEEE
	private String imagePath;

	private double prezzo;
	private double altezza;
	private double co2;
	private double salvaguardia;

	private int quantità;
	private int onSale;

	public String getPaeseDiOrigine() {
		return paeseDiOrigine;
	}

	public void setPaeseDiOrigine(String paeseDiOrigine) {
		this.paeseDiOrigine = paeseDiOrigine;
	}

	private Collection<Categoria> categorie;

	public Prodotto(int id, String nome, String nomeScientifico, String descrizione, String descrizioneBreve,
			String paeseDiOrigine, String imagePath, double prezzo, double altezza, double co2, double salvaguardia,
			int quantità, int onSale, Collection<Categoria> categorie) {
		super();
		this.id = id;
		this.nome = nome;
		this.nomeScientifico = nomeScientifico;
		this.descrizione = descrizione;
		this.descrizioneBreve = descrizioneBreve;
		this.imagePath = imagePath;
		this.prezzo = prezzo;
		this.altezza = altezza;
		this.co2 = co2;
		this.salvaguardia = salvaguardia;
		this.quantità = quantità;
		this.onSale = onSale;
		this.categorie = categorie;
		this.paeseDiOrigine = paeseDiOrigine;
	}

	public Prodotto() {
		this.id = NO_ITEM;
	}

	@Override
	public String toString() {
		return "Product [id=" + id + ", nome=" + nome + ", nomeScientifico=" + nomeScientifico + ", descrizione="
				+ descrizione + ", descrizioneBreve=" + descrizioneBreve + ", imagePath=" + imagePath + ", prezzo="
				+ prezzo + ", altezza=" + altezza + ", co2=" + co2 + ", salvaguardia=" + salvaguardia + ", quantità="
				+ quantità + ", onSale=" + onSale + ", categories=" + categorie + "]";
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getNomeScientifico() {
		return nomeScientifico;
	}

	public void setNomeScientifico(String nomeScientifico) {
		this.nomeScientifico = nomeScientifico;
	}

	public String getDescrizione() {
		return descrizione;
	}

	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}

	public String getDescrizioneBreve() {
		return descrizioneBreve;
	}

	public void setDescrizioneBreve(String descrizioneBreve) {
		this.descrizioneBreve = descrizioneBreve;
	}

	public String getImagePath() {
		return imagePath;
	}

	public void setImagePath(String imagePath) {
		this.imagePath = imagePath;
	}

	public double getPrezzo() {
		return prezzo;
	}

	public void setPrezzo(double prezzo) {
		this.prezzo = prezzo;
	}

	public double getAltezza() {
		return altezza;
	}

	public void setAltezza(double altezza) {
		this.altezza = altezza;
	}

	public double getCo2() {
		return co2;
	}

	public void setCo2(double co2) {
		this.co2 = co2;
	}

	public double getSalvaguardia() {
		return salvaguardia;
	}

	public void setSalvaguardia(double salvaguardia) {
		this.salvaguardia = salvaguardia;
	}

	public int getQuantità() {
		return quantità;
	}

	public void setQuantità(int quantità) {
		this.quantità = quantità;
	}

	public int getOnSale() {
		return onSale;
	}

	public void setOnSale(int onSale) {
		this.onSale = onSale;
	}

	public Collection<Categoria> getCategories() {
		if (categorie == null)
			categorie = new ArrayList<Categoria>();
		return categorie;
	}

	public void setCategories(Collection<Categoria> categories) {
		this.categorie = categories;
	}

	public void addCategory(Categoria category) {
		if (categorie == null)
			categorie = new ArrayList<Categoria>();
		if (!categorie.contains(category))
			categorie.add(category);
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		long temp;
		temp = Double.doubleToLongBits(altezza);
		result = prime * result + (int) (temp ^ (temp >>> 32));
		result = prime * result + ((categorie == null) ? 0 : categorie.hashCode());
		temp = Double.doubleToLongBits(co2);
		result = prime * result + (int) (temp ^ (temp >>> 32));
		result = prime * result + ((descrizione == null) ? 0 : descrizione.hashCode());
		result = prime * result + ((descrizioneBreve == null) ? 0 : descrizioneBreve.hashCode());
		result = prime * result + id;
		result = prime * result + ((imagePath == null) ? 0 : imagePath.hashCode());
		result = prime * result + ((nome == null) ? 0 : nome.hashCode());
		result = prime * result + ((nomeScientifico == null) ? 0 : nomeScientifico.hashCode());
		result = prime * result + onSale;
		temp = Double.doubleToLongBits(prezzo);
		result = prime * result + (int) (temp ^ (temp >>> 32));
		result = prime * result + quantità;
		temp = Double.doubleToLongBits(salvaguardia);
		result = prime * result + (int) (temp ^ (temp >>> 32));
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
		Prodotto other = (Prodotto) obj;
		if (Double.doubleToLongBits(altezza) != Double.doubleToLongBits(other.altezza))
			return false;
		if (categorie == null) {
			if (other.categorie != null)
				return false;
		} else if (!categorie.equals(other.categorie))
			return false;
		if (Double.doubleToLongBits(co2) != Double.doubleToLongBits(other.co2))
			return false;
		if (descrizione == null) {
			if (other.descrizione != null)
				return false;
		} else if (!descrizione.equals(other.descrizione))
			return false;
		if (descrizioneBreve == null) {
			if (other.descrizioneBreve != null)
				return false;
		} else if (!descrizioneBreve.equals(other.descrizioneBreve))
			return false;
		if (id != other.id)
			return false;
		if (imagePath == null) {
			if (other.imagePath != null)
				return false;
		} else if (!imagePath.equals(other.imagePath))
			return false;
		if (nome == null) {
			if (other.nome != null)
				return false;
		} else if (!nome.equals(other.nome))
			return false;
		if (nomeScientifico == null) {
			if (other.nomeScientifico != null)
				return false;
		} else if (!nomeScientifico.equals(other.nomeScientifico))
			return false;
		if (onSale != other.onSale)
			return false;
		if (Double.doubleToLongBits(prezzo) != Double.doubleToLongBits(other.prezzo))
			return false;
		if (quantità != other.quantità)
			return false;
		if (Double.doubleToLongBits(salvaguardia) != Double.doubleToLongBits(other.salvaguardia))
			return false;
		return true;
	}
}
