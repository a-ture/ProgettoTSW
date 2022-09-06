package it.unisa.beans;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;

/**
 * Questa classe rappresenta l'oggetto KitAlberi
 * @author raffaella & alessia
 *
 */
public class KitAlberi implements Serializable {

	private static final long serialVersionUID = 1L;
	private int id;
	private String nome;
	private String descrizione;
	private double saldo;
	private Collection<Albero> alberi;

	/**
	 * Costruttore con i parametri
	 * @param id	codice identificativo
	 * @param nome	nome del kit
	 * @param descrizione	descrizione del kit
	 * @param tasse	iva del kit
	 * @param prezzo	prezzo del kit
	 * @param saldo	prezzo+iva del kit
	 * @param disponibile	TRUE se è disponibile, FALSE se non è disponibile
	 * @param onSale	percentuale di saldo
	 * @param alberi	collezione di alberi che appartengono a quel kit
	 */
	public KitAlberi(int id, String nome, String descrizione, double tasse, double prezzo, double saldo,
			boolean disponibile, int onSale, Collection<Albero> alberi) {
		super();
		this.id = id;
		this.nome = nome;
		this.descrizione = descrizione;
		this.saldo = saldo;
		this.alberi = alberi;

	}
	
	/**
	 * Costruttore senza parametri
	 */
	public KitAlberi() {
		this.alberi = new ArrayList<Albero>();
	}
	/**
	 * Aggiunge la quantità di CO2 che ogni albero può assorbire
	 * @return quantità di CO2 ( per ogni stella attibuiamo 10 Kg di CO2)
	 */
	public double getCO2() {
		double co2 = 0;
		Iterator<Albero> it = alberi.iterator();
		while (it.hasNext()) {
			Albero albero = it.next();
			co2 += albero.getCo2();
		}
		return co2 * 10 * alberi.size();
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

	public String getDescrizione() {
		return descrizione;
	}

	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}

	public double getPrezzoAlberi() {
		double prezzo = 0;
		Iterator<Albero> it = alberi.iterator();
		while (it.hasNext()) {
			Albero albero = it.next();
			prezzo += albero.getPrezzo();
		}
		return prezzo;
	}

	public double getPrezzoKit() {
		double prezzo = 0;
		Iterator<Albero> it = alberi.iterator();
		while (it.hasNext()) {
			Albero albero = it.next();
			double prezzoScontato = (albero.getPrezzo() * saldo)/100;
			double prezzoScontatoAlbero = albero.getPrezzo() - prezzoScontato;
			if (prezzoScontatoAlbero < 0)
				prezzoScontatoAlbero = 0;
			prezzo += prezzoScontatoAlbero;
			
		}
		return prezzo;
	}

	public double getSaldo() {
		return saldo;
	}

	public void setSaldo(double saldo) {
		this.saldo = saldo;
	}

	public Collection<Albero> getAlberi() {
		return alberi;
	}

	public void setAlberi(Collection<Albero> alberi) {
		this.alberi = alberi;

	}

	public int getNumeroAlberi() {
		return alberi.size();
	}

	public boolean isDisponibile() {
		Iterator<Albero> it = alberi.iterator();
		while (it.hasNext()) {
			Albero albero = it.next();
			if (!albero.isDisponibile()) {
				return false;
			}
		}
		return true;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((alberi == null) ? 0 : alberi.hashCode());
		result = prime * result + ((descrizione == null) ? 0 : descrizione.hashCode());
		result = prime * result + id;
		result = prime * result + ((nome == null) ? 0 : nome.hashCode());
		long temp;
		temp = Double.doubleToLongBits(saldo);
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
		KitAlberi other = (KitAlberi) obj;
		if (alberi == null) {
			if (other.alberi != null)
				return false;
		} else if (!alberi.equals(other.alberi))
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
		if (Double.doubleToLongBits(saldo) != Double.doubleToLongBits(other.saldo))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "KitAlberi [id=" + id + ", nome=" + nome + ", descrizione=" + descrizione + ", saldo=" + saldo
				+ ", alberi=" + alberi + "]";
	}
}
