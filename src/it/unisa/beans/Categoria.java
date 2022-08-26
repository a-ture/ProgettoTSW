package it.unisa.beans;

import java.io.Serializable;
import java.util.ArrayList;

public class Categoria implements Serializable {

	private static final long serialVersionUID = 1L;
	private int id;
	private String nome, descrizione;

	private ArrayList<Integer> prodottiId;

	public Categoria() {
		prodottiId = new ArrayList<Integer>();
	}

	public void addProductId(int code) {
		if (prodottiId.contains(code))
			prodottiId.add(code);
	}

	public boolean isProductBelongs(int idProduct) {
		return prodottiId.contains(idProduct) ? true : false;
	}

	public ArrayList<Integer> getProductsId() {
		return prodottiId;
	}

	public void setProductsId(ArrayList<Integer> productsId) {
		this.prodottiId = productsId;
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

	public Categoria(int id, String nome, String descrizione) {
		super();
		this.id = id;
		this.nome = nome;
		this.descrizione = descrizione;

		prodottiId = new ArrayList<Integer>();
	}

	public Categoria(int id) {
		this.setId(id);
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((descrizione == null) ? 0 : descrizione.hashCode());
		result = prime * result + id;
		result = prime * result + ((nome == null) ? 0 : nome.hashCode());
		result = prime * result + ((prodottiId == null) ? 0 : prodottiId.hashCode());
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
		Categoria other = (Categoria) obj;
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
		if (prodottiId == null) {
			if (other.prodottiId != null)
				return false;
		} else if (!prodottiId.equals(other.prodottiId))
			return false;
		return true;
	}

	@Override
	public String toString() {
		return "Categoria [id=" + id + ", nome=" + nome + ", descrizione=" + descrizione + ", prodottiId=" + prodottiId
				+ "]";
	}
}
