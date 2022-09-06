package it.unisa.beans;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;

/**
 * Questa classe rappresenta l'oggetto Ordine
 * @author raffaella & alessia
 *
 */
public class Ordine implements Serializable {

	private static final long serialVersionUID = 1L;
	private int id;
	private int totaleProdotti;
	private double totalePagato;
	private boolean regalo;
	private String messaggioRegalo;
	private String destinatarioRegalo;
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
	 * @param id	codice identificativo
	 * @param totaleProdotti	totale dei prodottiche appartengono all'ordine
	 * @param totalePagato	costo totale dell'ordine
	 * @param regalo	TRUE è un regale, FALSE non è un regalo
	 * @param messaggioRegalo	 messaggio del regalo
	 * @param destinatarioRegalo	destinatario del regalo
	 * @param items	collezione dei prodotti che appartengono a questo ordine
	 * @param utente	l'utente che ha effettuato l'ordine
	 * @param creatoIl	data dell'ordine
	 */
	public Ordine(int id, int totaleProdotti, double totalePagato, boolean regalo, String messaggioRegalo,
			String destinatarioRegalo, Collection<ProdottoOrdine> items, Utente utente, LocalDateTime creatoIl) {
		super();
		this.id = id;
		this.totaleProdotti = totaleProdotti;
		this.totalePagato = totalePagato;
		this.regalo = regalo;
		this.messaggioRegalo = messaggioRegalo;
		this.destinatarioRegalo = destinatarioRegalo;
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

	public String getDestinatarioRegalo() {
		return destinatarioRegalo;
	}

	public void setDestinatarioRegalo(String destinatarioRegalo) {
		this.destinatarioRegalo = destinatarioRegalo;
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
		result = prime * result + ((destinatarioRegalo == null) ? 0 : destinatarioRegalo.hashCode());
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
		if (destinatarioRegalo == null) {
			if (other.destinatarioRegalo != null)
				return false;
		} else if (!destinatarioRegalo.equals(other.destinatarioRegalo))
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

	@Override
	public String toString() {
		return "Ordine [id=" + id + ", totaleProdotti=" + totaleProdotti + ", totalePagato=" + totalePagato
				+ ", regalo=" + regalo + ", messaggioRegalo=" + messaggioRegalo + ", destinatarioRegalo="
				+ destinatarioRegalo + ", items=" + items + ", utente=" + utente + ", creatoIl=" + creatoIl + "]";
	}

}
