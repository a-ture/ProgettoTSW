package it.unisa.beans;

import java.io.Serializable;
import java.util.Date;

public class CodicePromozionale implements Serializable {

	private static final long serialVersionUID = 1L;
	private int id;
	private String codice;
	private Date dataInzioValidità;
	private Date dataFineValidità;
	private double scontoApplicato;
	private String descrizione;

	public CodicePromozionale(int id, String codice, Date dataInzioValità, Date dataFineValidità,
			double scontoApplicato, String descrizione) {
		super();
		this.id = id;
		this.codice = codice;
		this.dataInzioValidità = dataInzioValità;
		this.dataFineValidità = dataFineValidità;
		this.scontoApplicato = scontoApplicato;
		this.descrizione = descrizione;
	}

	public CodicePromozionale() {

	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getCodice() {
		return codice;
	}

	public void setCodice(String codice) {
		this.codice = codice;
	}

	public Date getDataInzioValidità() {
		return dataInzioValidità;
	}

	public void setDataInzioValidità(Date dataInzioValità) {
		this.dataInzioValidità = dataInzioValità;
	}

	public Date getDataFineValidità() {
		return dataFineValidità;
	}

	public void setDataFineValidità(Date dataFineValidità) {
		this.dataFineValidità = dataFineValidità;
	}

	public double getScontoApplicato() {
		return scontoApplicato;
	}

	public void setScontoApplicato(double scontoApplicato) {
		this.scontoApplicato = scontoApplicato;
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
		result = prime * result + ((codice == null) ? 0 : codice.hashCode());
		result = prime * result + ((dataFineValidità == null) ? 0 : dataFineValidità.hashCode());
		result = prime * result + ((dataInzioValidità == null) ? 0 : dataInzioValidità.hashCode());
		result = prime * result + ((descrizione == null) ? 0 : descrizione.hashCode());
		result = prime * result + id;
		long temp;
		temp = Double.doubleToLongBits(scontoApplicato);
		result = prime * result + (int) (temp ^ (temp >>> 32));
		return result;
	}

	@Override
	public String toString() {
		return "CodicePromozionale [id=" + id + ", codice=" + codice + ", dataInzioValità=" + dataInzioValidità
				+ ", dataFineValidità=" + dataFineValidità + ", scontoApplicato=" + scontoApplicato + ", descrizione="
				+ descrizione + "]";
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CodicePromozionale other = (CodicePromozionale) obj;
		if (codice == null) {
			if (other.codice != null)
				return false;
		} else if (!codice.equals(other.codice))
			return false;
		if (dataFineValidità == null) {
			if (other.dataFineValidità != null)
				return false;
		} else if (!dataFineValidità.equals(other.dataFineValidità))
			return false;
		if (dataInzioValidità == null) {
			if (other.dataInzioValidità != null)
				return false;
		} else if (!dataInzioValidità.equals(other.dataInzioValidità))
			return false;
		if (descrizione == null) {
			if (other.descrizione != null)
				return false;
		} else if (!descrizione.equals(other.descrizione))
			return false;
		if (id != other.id)
			return false;
		if (Double.doubleToLongBits(scontoApplicato) != Double.doubleToLongBits(other.scontoApplicato))
			return false;
		return true;
	}

}
