package it.unisa.beans;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;

/**
 * Questa classe rappresenta l'oggetto Ordine
 * 
 * @author raffaella & alessia
 *
 */
public class Ordine implements Serializable {

	private static final long serialVersionUID = 1L;
	private int id;
	private int totaleProdotti;
	private double totalePagato;
	private Collection<ProdottoOrdine> items;
	private Utente utente;
	private LocalDateTime creatoIl;

	/**
	 * Costruttore senza parametri
	 */
	public Ordine() {
		items = new ArrayList<ProdottoOrdine>();
	}

	/**
	 * Costruttore con i parametri
	 * 
	 * @param id             codice identificativo
	 * @param totaleProdotti totale dei prodottiche appartengono all'ordine
	 * @param totalePagato   costo totale dell'ordine
	 * @param items          collezione dei prodotti che appartengono a questo
	 *                       ordine
	 * @param utente         l'utente che ha effettuato l'ordine
	 * @param creatoIl       data dell'ordine
	 */
	public Ordine(int id, int totaleProdotti, double totalePagato, Collection<ProdottoOrdine> items, Utente utente,
			LocalDateTime creatoIl) {
		super();
		this.id = id;
		this.totaleProdotti = totaleProdotti;
		this.totalePagato = totalePagato;
		this.items = items;
		this.utente = utente;
		this.creatoIl = creatoIl;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((creatoIl == null) ? 0 : creatoIl.hashCode());
		result = prime * result + id;
		result = prime * result + ((items == null) ? 0 : items.hashCode());
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

	@Override
	public String toString() {
		return "Ordine [id=" + id + ", totaleProdotti=" + totaleProdotti + ", totalePagato=" + totalePagato + ", items="
				+ items + ", utente=" + utente + ", creatoIl=" + creatoIl + "]";
	}

}
