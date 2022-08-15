package it.unisa.beans;

import java.io.Serializable;

public class FotoProdotto implements Serializable {
	private static final long serialVersionUID = 1L;
	private int nomeFoto;
	private int idProdotto;

	public FotoProdotto() {
		nomeFoto=-1;
		idProdotto=-1;
	}

	public int getNomeFoto() {
		return nomeFoto;
	}

	public void setNomeFoto(int nomeFoto) {
		this.nomeFoto = nomeFoto;
	}

	public int getIdProdotto() {
		return idProdotto;
	}

	public void setIdProdotto(int idProdotto) {
		this.idProdotto = idProdotto;
	}

	public boolean isEmpty() {
		return nomeFoto == -1;
	}

	@Override
	public boolean equals(Object other) {
		return this.getNomeFoto() == ((FotoProdotto) other).getNomeFoto();
	}

	@Override
	public String toString() {
		return nomeFoto + " " + " " + idProdotto;

	}
}
