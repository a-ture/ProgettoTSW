package it.unisa.beans;

import java.io.Serializable;

public class PaeseDiOrigine implements Serializable {

	private static final long serialVersionUID = 1L;
	private String nome;
	private String descrizione;

	public PaeseDiOrigine(String nome, String descrizione) {
		super();
		this.nome = nome;
		this.descrizione = descrizione;
	}

	public PaeseDiOrigine() {

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
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((descrizione == null) ? 0 : descrizione.hashCode());
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
		PaeseDiOrigine other = (PaeseDiOrigine) obj;
		if (descrizione == null) {
			if (other.descrizione != null)
				return false;
		} else if (!descrizione.equals(other.descrizione))
			return false;
		if (nome == null) {
			if (other.nome != null)
				return false;
		} else if (!nome.equals(other.nome))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "PaeseDiOrigine [nome=" + nome + ", descrizione=" + descrizione + "]";
	}

}
