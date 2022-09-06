package it.unisa.beans;

import java.io.Serializable;

/**
 * Questa classe rappresenta l'oggetto UsoLocale
 * @author raffaella & alessia
 *
 */
public class UsoLocale implements Serializable {

	private static final long serialVersionUID = 1L;
	private int id;
	private String nome;
	private String descrizione;

	/**
	 * Costruttore con i parametri
	 * @param id	codice identificatico
	 * @param nome	nome dell'uso
	 * @param descrizione	descrizione dell'uso
	 */
	public UsoLocale(int id, String nome, String descrizione) {
		super();
		this.id = id;
		this.nome = nome;
		this.descrizione = descrizione;
	}
	
	/**
	 * Costruttore senza paramtri
	 */
	public UsoLocale() {
		
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

	@Override
	public String toString() {
		return "UsoLocale [id=" + id + ", nome=" + nome + ", descrizione=" + descrizione + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((descrizione == null) ? 0 : descrizione.hashCode());
		result = prime * result + id;
		result = prime * result + ((nome == null) ? 0 : nome.hashCode());
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
		UsoLocale other = (UsoLocale) obj;
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
		return true;
	}

}
