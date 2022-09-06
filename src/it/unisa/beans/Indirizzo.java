package it.unisa.beans;

import java.io.Serializable;

/**
 * Questa classe rappresenta l'oggetto Indirizzo
 * @author raffaella & alessia
 *
 */
public class Indirizzo implements Serializable {

	private static final long serialVersionUID = 1L;
	private int id;
	private int uid;
	private String nome;
	private String cognome;
	private String via;
	private String CAP;
	private String città;
	private String provincia;
	private boolean preferred;
	private String civico;
	
	/**
	 * Costruttore senza parametri
	 */
	public Indirizzo() {

	}

	/**
	 * Costruttore con i parametri
	 * @param id	codice identificativo
	 * @param uid	codice identificativo dell'utente
	 * @param nome	nome dell'utente
	 * @param cognome	cognome dell'utente
	 * @param via
	 * @param cAP
	 * @param città
	 * @param provincia
	 * @param preferred	TRUE l'indirizzo è il preferito, FALSE l'indirizzo non è il preferito
	 * @param civico
	 */
	public Indirizzo(int id, int uid, String nome, String cognome, String via, String cAP, String città,
			String provincia, boolean preferred, String civico) {
		super();
		this.id = id;
		this.uid = uid;
		this.nome = nome;
		this.cognome = cognome;
		this.via = via;
		CAP = cAP;
		this.città = città;
		this.provincia = provincia;
		this.preferred = preferred;
		this.civico = civico;
	}

	@Override
	public String toString() {
		return "Indirizzo [id=" + id + ", uid=" + uid + ", nome=" + nome + ", cognome=" + cognome + ", via=" + via
				+ ", CAP=" + CAP + ", città=" + città + ", provincia=" + provincia + ", preferred=" + preferred
				+ ", civico=" + civico + "]";
	}



	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Indirizzo other = (Indirizzo) obj;
		if (CAP == null) {
			if (other.CAP != null)
				return false;
		} else if (!CAP.equals(other.CAP))
			return false;
		if (città == null) {
			if (other.città != null)
				return false;
		} else if (!città.equals(other.città))
			return false;
		if (civico != other.civico)
			return false;
		if (cognome == null) {
			if (other.cognome != null)
				return false;
		} else if (!cognome.equals(other.cognome))
			return false;
		if (id != other.id)
			return false;
		if (via == null) {
			if (other.via != null)
				return false;
		} else if (!via.equals(other.via))
			return false;
		if (nome == null) {
			if (other.nome != null)
				return false;
		} else if (!nome.equals(other.nome))
			return false;
		if (preferred != other.preferred)
			return false;
		if (provincia == null) {
			if (other.provincia != null)
				return false;
		} else if (!provincia.equals(other.provincia))
			return false;
		if (uid != other.uid)
			return false;
		return true;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getUid() {
		return uid;
	}

	public void setUid(int uid) {
		this.uid = uid;
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

	public String getVia() {
		return via;
	}

	public void setVia(String via) {
		this.via = via;
	}

	public String getCAP() {
		return CAP;
	}

	public void setCAP(String cAP) {
		CAP = cAP;
	}

	public String getCittà() {
		return città;
	}

	public void setCittà(String città) {
		this.città = città;
	}

	public String getProvincia() {
		return provincia;
	}

	public void setProvincia(String provincia) {
		this.provincia = provincia;
	}

	public boolean isPreferred() {
		return preferred;
	}

	public void setPreferred(boolean preferred) {
		this.preferred = preferred;
	}

	public String getCivico() {
		return civico;
	}

	public void setCivico(String civico) {
		this.civico = civico;
	}

}
