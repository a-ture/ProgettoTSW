package it.unisa.beans;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;

public class Ordine implements Serializable {

	private static final long serialVersionUID = 1L;
	private int id;
	private int totaleProdotti;
	private double totalePagato;
	private boolean regalo;
	private String messaggioRegalo;
	private Collection<ProdottoOrdine> items;
	private Utente utente;
	private LocalDateTime creatoIl;

	public Ordine(int id, int totaleProdotti, double totalPagato, boolean regalo, String messaggioRegalo,
			Collection<ProdottoOrdine> items, Utente user, LocalDateTime createdAt) {
		super();
		this.id = id;
		this.totaleProdotti = totaleProdotti;
		this.totalePagato = totalPagato;
		this.regalo = regalo;
		this.messaggioRegalo = messaggioRegalo;
		this.items = items;
		this.utente = user;
		this.creatoIl = createdAt;
	}

	public Ordine() {
		items = new ArrayList<ProdottoOrdine>();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	@Override
	public String toString() {
		return "Ordine [id=" + id + ", totaleProdotti=" + totaleProdotti + ", totalePagato=" + totalePagato + ", stato="
				+ ", regalo=" + regalo + ", messaggioRegalo=" + messaggioRegalo + ", items=" + items + ", utente="
				+ utente + ", creatoIl=" + creatoIl + "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((creatoIl == null) ? 0 : creatoIl.hashCode());
		result = prime * result + id;
		result = prime * result + ((items == null) ? 0 : items.hashCode());
		result = prime * result + ((messaggioRegalo == null) ? 0 : messaggioRegalo.hashCode());
		result = prime * result + (regalo ? 1231 : 1237);
		long temp;
		temp = Double.doubleToLongBits(totalePagato);
		result = prime * result + (int) (temp ^ (temp >>> 32));
		result = prime * result + totaleProdotti;
		result = prime * result + ((utente == null) ? 0 : utente.hashCode());
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
		Ordine other = (Ordine) obj;
		if (creatoIl == null) {
			if (other.creatoIl != null)
				return false;
		} else if (!creatoIl.equals(other.creatoIl))
			return false;
		if (id != other.id)
			return false;
		if (items == null) {
			if (other.items != null)
				return false;
		} else if (!items.equals(other.items))
			return false;
		if (messaggioRegalo == null) {
			if (other.messaggioRegalo != null)
				return false;
		} else if (!messaggioRegalo.equals(other.messaggioRegalo))
			return false;
		if (regalo != other.regalo)
			return false;
		if (Double.doubleToLongBits(totalePagato) != Double.doubleToLongBits(other.totalePagato))
			return false;
		if (totaleProdotti != other.totaleProdotti)
			return false;
		if (utente == null) {
			if (other.utente != null)
				return false;
		} else if (!utente.equals(other.utente))
			return false;
		return true;
	}

	public int getTotaleProdotti() {
		return totaleProdotti;
	}

	public void setTotaleProdotti(int totaleProdotti) {
		this.totaleProdotti = totaleProdotti;
	}

	public double getTotalePagato() {
		return totalePagato;
	}

	public void setTotalePagato(double totalPagato) {
		this.totalePagato = totalPagato;
	}

	public boolean isRegalo() {
		return regalo;
	}

	public void setRegalo(boolean regalo) {
		this.regalo = regalo;
	}

	public String getMessaggioRegalo() {
		return messaggioRegalo;
	}

	public void setMessaggioRegalo(String messaggioRegalo) {
		this.messaggioRegalo = messaggioRegalo;
	}

	public Collection<ProdottoOrdine> getItems() {
		return items;
	}

	public void setItems(Collection<ProdottoOrdine> items) {
		this.items = items;
	}

	public Utente getUtente() {
		return utente;
	}

	public void setUtente(Utente user) {
		this.utente = user;
	}

	public LocalDateTime getCreatoIl() {
		return creatoIl;
	}

	public void setCreatoIl(LocalDateTime createdAt) {
		this.creatoIl = createdAt;
	}

	public void aggiungiPrdotto(ProdottoOrdine bean) {
		if (this.items == null)
			this.items = new ArrayList<>();
		this.items.add(bean);
	}

}
