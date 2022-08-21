package it.unisa.beans;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Collection;

public class Utente implements Cloneable, Serializable {

	private static final long serialVersionUID = 1L;
	private int id;
	private String nome;
	private String cognome;
	private Collection<Indirizzo> indirizzi;
	private String email;
	private String password;
	private String role;
	private String username;
	private boolean active;

	public Utente() {
	}

	public Utente(int id, String nome, String cognome, Collection<Indirizzo> indirizzi, String email, String password,
			String role, String username, boolean active) {
		super();
		this.id = id;
		this.nome = nome;
		this.cognome = cognome;
		this.indirizzi = indirizzi;
		this.email = email;
		this.password = password;
		this.role = role;
		this.username = username;
		this.active = active;
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

	public String getCognome() {
		return cognome;
	}

	public void setCognome(String cognome) {
		this.cognome = cognome;
	}

	public Collection<Indirizzo> getIndirizzi() {
		return indirizzi;
	}

	public void setIndirizzi(Collection<Indirizzo> indirizzi) {
		this.indirizzi = indirizzi;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public String toString() {
		return "Utente [id=" + id + ", nome=" + nome + ", cognome=" + cognome + ", indirizzi=" + indirizzi + ", email="
				+ email + ", password=" + password + ", role=" + role + ", username=" + username + ", active=" + active
				+ "]";
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + (active ? 1231 : 1237);
		result = prime * result + ((cognome == null) ? 0 : cognome.hashCode());
		result = prime * result + ((email == null) ? 0 : email.hashCode());
		result = prime * result + id;
		result = prime * result + ((indirizzi == null) ? 0 : indirizzi.hashCode());
		result = prime * result + ((nome == null) ? 0 : nome.hashCode());
		result = prime * result + ((password == null) ? 0 : password.hashCode());
		result = prime * result + ((role == null) ? 0 : role.hashCode());
		result = prime * result + ((username == null) ? 0 : username.hashCode());
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
		Utente other = (Utente) obj;
		if (active != other.active)
			return false;
		if (cognome == null) {
			if (other.cognome != null)
				return false;
		} else if (!cognome.equals(other.cognome))
			return false;
		if (email == null) {
			if (other.email != null)
				return false;
		} else if (!email.equals(other.email))
			return false;
		if (id != other.id)
			return false;
		if (indirizzi == null) {
			if (other.indirizzi != null)
				return false;
		} else if (!indirizzi.equals(other.indirizzi))
			return false;
		if (nome == null) {
			if (other.nome != null)
				return false;
		} else if (!nome.equals(other.nome))
			return false;
		if (password == null) {
			if (other.password != null)
				return false;
		} else if (!password.equals(other.password))
			return false;
		if (role == null) {
			if (other.role != null)
				return false;
		} else if (!role.equals(other.role))
			return false;
		if (username == null) {
			if (other.username != null)
				return false;
		} else if (!username.equals(other.username))
			return false;
		return true;
	}

	public boolean isActive() {
		return active;
	}

	public void setActive(boolean active) {
		this.active = active;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public Indirizzo getPreferredAddress() {
		if (this.indirizzi == null)
			return null;
		for (Indirizzo a : this.indirizzi) {
			if (a.isPreferred())
				return a;
		}
		return null;
	}

	public void aggiungiIndirizzo(Indirizzo addr) {
		if (this.indirizzi == null)
			this.indirizzi = new ArrayList<Indirizzo>();
		this.indirizzi.add(addr);
	}
}
