package it.unisa.beans;

import java.util.ArrayList;

public class Category {

	private int id;
	private String nome, descrizione;

	private ArrayList<Integer> productsId;

	public Category() {
		productsId = new ArrayList<Integer>();
	}

	public void addProductId(int code) {
		if (productsId.contains(code))
			productsId.add(code);
	}

	public boolean isProductBelongs(int idProduct) {
		return productsId.contains(idProduct) ? true : false;
	}

	public ArrayList<Integer> getProductsId() {
		return productsId;
	}

	public void setProductsId(ArrayList<Integer> productsId) {
		this.productsId = productsId;
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

	public String getDescription() {
		return descrizione;
	}

	public void setDescrizione(String descrizione) {
		this.descrizione = descrizione;
	}

	public Category(int id, String name, String description, String metaKeywords, String metaTitle,
			String metaDescription) {
		super();
		this.id = id;
		this.nome = name;
		this.descrizione = description;

		productsId = new ArrayList<Integer>();
	}

	public Category(int id) {
		this.setId(id);
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
		Category other = (Category) obj;
		if (id != other.id)
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
		return "Category [id=" + id + ", nome=" + nome + ", descrizione=" + descrizione + "]";
	}
}
