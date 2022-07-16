package it.unisa.beans;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Collection;

public class Order {

	private int id;
	private String destinazione;
	private int totaleProdotti;
	private double totalPagato;
	private String stato;
	private boolean regalo;
	private String messaggioRegalo;
	private Collection<OrderItem> items;
	private Utente utente;
	private LocalDateTime createdAt;

	public Order(int id, String destinazione, int totaleProdotti, double totalPagato, String stato, boolean regalo,
			String messaggioRegalo, Collection<OrderItem> items, Utente user, LocalDateTime createdAt) {
		super();
		this.id = id;
		this.destinazione = destinazione;
		this.totaleProdotti = totaleProdotti;
		this.totalPagato = totalPagato;
		this.stato = stato;
		this.regalo = regalo;
		this.messaggioRegalo = messaggioRegalo;
		this.items = items;
		this.utente = user;
		this.createdAt = createdAt;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getDestinazione() {
		return destinazione;
	}

	public void setDestinazione(String destinazione) {
		this.destinazione = destinazione;
	}

	public int getTotaleProdotti() {
		return totaleProdotti;
	}

	public void setTotaleProdotti(int totaleProdotti) {
		this.totaleProdotti = totaleProdotti;
	}

	public double getTotalPagato() {
		return totalPagato;
	}

	public void setTotalPagato(double totalPagato) {
		this.totalPagato = totalPagato;
	}

	public String getStato() {
		return stato;
	}

	public void setStato(String stato) {
		this.stato = stato;
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

	public Collection<OrderItem> getItems() {
		return items;
	}

	public void setItems(Collection<OrderItem> items) {
		this.items = items;
	}

	public Utente getUser() {
		return utente;
	}

	public void setUser(Utente user) {
		this.utente = user;
	}

	public LocalDateTime getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(LocalDateTime createdAt) {
		this.createdAt = createdAt;
	}

	public void addItem(OrderItem bean) {
		if (this.items == null)
			this.items = new ArrayList<>();
		this.items.add(bean);
	}

}
