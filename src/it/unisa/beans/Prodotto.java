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
	private String sottotitolo;
	private String doveVienePiantato;

	private double prezzo;
	private double altezza;
	private double co2;
	private double salvaguardia;
	private double tasse;
	private double saldo;

	private int quantità;
	private int onSale;

	private boolean disponibile;

	public Prodotto(int id, String nome, String nomeScientifico, String paeseDiOrigine, String descrizione,
			String descrizioneBreve, String sottotitolo, String doveVienePiantato, double prezzo, double altezza,
			double co2, double salvaguardia, double tasse, double saldo, int quantità, int onSale, boolean disponibile,
			Collection<Categoria> categorie) {
		super();
		this.id = id;
		this.nome = nome;
		this.nomeScientifico = nomeScientifico;
		this.paeseDiOrigine = paeseDiOrigine;
		this.descrizione = descrizione;
		this.descrizioneBreve = descrizioneBreve;
		this.sottotitolo = sottotitolo;
		this.doveVienePiantato = doveVienePiantato;
		this.prezzo = prezzo;
		this.altezza = altezza;
		this.co2 = co2;
		this.salvaguardia = salvaguardia;
		this.tasse = tasse;
		this.saldo = saldo;
		this.quantità = quantità;
		this.onSale = onSale;
		this.disponibile = disponibile;
		this.categorie = categorie;
	}

	public double getTasse() {
		return tasse;
	}

	public void setTasse(double tasse) {
		this.tasse = tasse;
	}

	public double getSaldo() {
		return saldo;
	}

	public void setSaldo(double saldo) {
		this.saldo = saldo;
	}

	public boolean isDisponibile() {
		return disponibile;
	}

	public void setDisponibile(boolean disponibile) {
		this.disponibile = disponibile;
	}

	public String getPaeseDiOrigine() {
		return paeseDiOrigine;
	}

	public void setPaeseDiOrigine(String paeseDiOrigine) {
		this.paeseDiOrigine = paeseDiOrigine;
	}

	private Collection<Categoria> categorie;

	public Prodotto() {
		this.id = NO_ITEM;
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

	public String getSottotitolo() {
		return sottotitolo;
	}

	public void setSottotitolo(String sottotitolo) {
		this.sottotitolo = sottotitolo;
	}

	public String getDoveVienePiantato() {
		return doveVienePiantato;
	}

	public void setDoveVienePiantato(String doveVienePiantato) {
		this.doveVienePiantato = doveVienePiantato;
	}

	public Collection<Categoria> getCategorie() {
		return categorie;
	}

	public void setCategorie(Collection<Categoria> categorie) {
		this.categorie = categorie;
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
		result = prime * result + (disponibile ? 1231 : 1237);
		result = prime * result + ((doveVienePiantato == null) ? 0 : doveVienePiantato.hashCode());
		result = prime * result + id;
		result = prime * result + ((nome == null) ? 0 : nome.hashCode());
		result = prime * result + ((nomeScientifico == null) ? 0 : nomeScientifico.hashCode());
		result = prime * result + onSale;
		result = prime * result + ((paeseDiOrigine == null) ? 0 : paeseDiOrigine.hashCode());
		temp = Double.doubleToLongBits(prezzo);
		result = prime * result + (int) (temp ^ (temp >>> 32));
		result = prime * result + quantità;
		temp = Double.doubleToLongBits(saldo);
		result = prime * result + (int) (temp ^ (temp >>> 32));
		temp = Double.doubleToLongBits(salvaguardia);
		result = prime * result + (int) (temp ^ (temp >>> 32));
		result = prime * result + ((sottotitolo == null) ? 0 : sottotitolo.hashCode());
		temp = Double.doubleToLongBits(tasse);
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
		if (disponibile != other.disponibile)
			return false;
		if (doveVienePiantato == null) {
			if (other.doveVienePiantato != null)
				return false;
		} else if (!doveVienePiantato.equals(other.doveVienePiantato))
			return false;
		if (id != other.id)
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
		if (paeseDiOrigine == null) {
			if (other.paeseDiOrigine != null)
				return false;
		} else if (!paeseDiOrigine.equals(other.paeseDiOrigine))
			return false;
		if (Double.doubleToLongBits(prezzo) != Double.doubleToLongBits(other.prezzo))
			return false;
		if (quantità != other.quantità)
			return false;
		if (Double.doubleToLongBits(saldo) != Double.doubleToLongBits(other.saldo))
			return false;
		if (Double.doubleToLongBits(salvaguardia) != Double.doubleToLongBits(other.salvaguardia))
			return false;
		if (sottotitolo == null) {
			if (other.sottotitolo != null)
				return false;
		} else if (!sottotitolo.equals(other.sottotitolo))
			return false;
		if (Double.doubleToLongBits(tasse) != Double.doubleToLongBits(other.tasse))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Prodotto [id=" + id + ", nome=" + nome + ", nomeScientifico=" + nomeScientifico + ", paeseDiOrigine="
				+ paeseDiOrigine + ", descrizione=" + descrizione + ", descrizioneBreve=" + descrizioneBreve
				+ ", sottotitolo=" + sottotitolo + ", doveVienePiantato=" + doveVienePiantato + ", prezzo=" + prezzo
				+ ", altezza=" + altezza + ", co2=" + co2 + ", salvaguardia=" + salvaguardia + ", tasse=" + tasse
				+ ", saldo=" + saldo + ", quantità=" + quantità + ", onSale=" + onSale + ", disponibile=" + disponibile
				+ ", categorie=" + categorie + "]";
	}

}
