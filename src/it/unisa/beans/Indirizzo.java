package it.unisa.beans;

import java.io.Serializable;

public class Indirizzo implements Serializable {

	private static final long serialVersionUID = 1L;
	private int id;
	private int uid;
	private String nome;
	private String cognome;
	private String indirizzo;
	private String CAP;
	private String città;
	private String provincia;
	private boolean preferred;

	public Indirizzo(int id, int uid, String nome, String cognome, String indirizzo, String cAP, String città,
			String provincia, boolean preferred) {
		super();
		this.id = id;
		this.uid = uid;
		this.nome = nome;
		this.cognome = cognome;
		this.indirizzo = indirizzo;
		CAP = cAP;
		this.città = città;
		this.provincia = provincia;
		this.preferred = preferred;
	}

	public Indirizzo() {

	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((CAP == null) ? 0 : CAP.hashCode());

		result = prime * result + ((città == null) ? 0 : città.hashCode());
		result = prime * result + ((cognome == null) ? 0 : cognome.hashCode());
		result = prime * result + id;
		result = prime * result + ((indirizzo == null) ? 0 : indirizzo.hashCode());

		result = prime * result + ((nome == null) ? 0 : nome.hashCode());
		result = prime * result + (preferred ? 1231 : 1237);
		result = prime * result + ((provincia == null) ? 0 : provincia.hashCode());

		result = prime * result + uid;
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
		if (cognome == null) {
			if (other.cognome != null)
				return false;
		} else if (!cognome.equals(other.cognome))
			return false;
		if (id != other.id)
			return false;
		if (indirizzo == null) {
			if (other.indirizzo != null)
				return false;
		} else if (!indirizzo.equals(other.indirizzo))
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

	@Override
	public String toString() {
		return "Address [id=" + id + ", uid=" + uid + ", nome=" + nome + ", cognome=" + cognome + ", indirizzo="
				+ indirizzo + ", CAP=" + CAP + ", città=" + città + ", provincia=" + provincia + ", preferred="
				+ preferred + "]";
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

	public String getIndirizzo() {
		return indirizzo;
	}

	public void setIndirizzo(String indirizzo) {
		this.indirizzo = indirizzo;
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

}
