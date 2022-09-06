package it.unisa.beans;

import java.io.Serializable;

/**
 * Questa classe rappresenta l'oggetto Beneficio
 * @author raffaella & alessia
 *
 */
public class Beneficio implements Serializable {

	private static final long serialVersionUID = 1L;
	private int id;
	private String nome, descrizione;
	private double percentuale;
	
	/**
	 * Costruttore con i parametri
	 * @param id	codice identificativo
	 * @param nome	nome del beneficio
	 * @param descrizione	descizione del beneficio
	 * @param percentuale	percentuale del beneficio
	 */
	public Beneficio(int id, String nome, String descrizione, double percentuale) {
		super();
		this.id = id;
		this.nome = nome;
		this.descrizione = descrizione;
		this.percentuale = percentuale;
	}
	
	/**
	 * Costruttore senza parametri
	 */
	public Beneficio() {

	}
	
	/**
	 * Costruttore con i parametri
	 * @param id codice identificativo
	 * @param percentuale	percentuale del beneficio
	 */
	public Beneficio(int id, double percentuale) {
		this.id = id;
		this.percentuale = percentuale;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((descrizione == null) ? 0 : descrizione.hashCode());
		result = prime * result + id;
		result = prime * result + ((nome == null) ? 0 : nome.hashCode());
		long temp;
		temp = Double.doubleToLongBits(percentuale);
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
		Beneficio other = (Beneficio) obj;
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
		if (Double.doubleToLongBits(percentuale) != Double.doubleToLongBits(other.percentuale))
			return false;
		return true;
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

	public double getPercentuale() {
		return percentuale;
	}

	public void setPercentuale(double percentuale) {
		this.percentuale = percentuale;
	}

}
