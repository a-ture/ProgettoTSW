package it.unisa.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import it.unisa.beans.Categoria;
import it.unisa.beans.Prodotto;

public class ProdottoDAO implements GenericDAO<Prodotto> {

	private static DataSource ds;

	static {
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context) initCtx.lookup("java:comp/env");

			ds = (DataSource) envCtx.lookup("jdbc/WoodLot");

		} catch (NamingException e) {
			System.out.println("Error:" + e.getMessage());
		}
	}

	private static final String TABLE_NAME = "prodotto";

	@Override
	public synchronized Prodotto doRetriveByKey(String code) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Prodotto bean = new Prodotto();

		String selectSQL = "SELECT * FROM " + ProdottoDAO.TABLE_NAME + " WHERE id = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, Integer.parseInt(code));

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {

				bean.setAltezza(rs.getDouble("altezza"));
				bean.setCo2(rs.getInt("co2"));
				bean.setDescrizione(rs.getString("descrizione"));
				bean.setDescrizioneBreve(rs.getString("descrizioneBreve"));
				bean.setId(rs.getInt("id"));
				bean.setNome(rs.getString("nome"));
				bean.setNomeScientifico(rs.getString("nomeScientifico"));
				bean.setOnSale(rs.getInt("onSale"));
				bean.setPaeseDiOrigine(rs.getString("pid"));
				bean.setPrezzo(rs.getDouble("prezzo"));
				bean.setQuantità(rs.getInt("quantità"));
				bean.setSalvaguardia(rs.getInt("Salvaguardia"));
				bean.setCategories(findProductCategory(bean.getId()));
				bean.setDoveVienePiantato(rs.getString("doveVienePiantato"));
				bean.setSottotitolo(rs.getString("sottotitolo"));
				bean.setSaldo(rs.getDouble("saldo"));
				bean.setTasse(rs.getDouble("tasse"));
				bean.setDisponibile(rs.getBoolean("disponibile"));
			}

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return bean;
	}

	@Override
	public synchronized Collection<Prodotto> doRetriveAll(String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet rs = null;

		Collection<Prodotto> beans = new LinkedList<Prodotto>();

		String selectSQL = "SELECT * FROM " + ProdottoDAO.TABLE_NAME;

		if (order != null && !order.equals("")) {
			selectSQL += " ORDER BY " + order;
		}

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			rs = preparedStatement.executeQuery();

			while (rs.next()) {
				Prodotto bean = new Prodotto();

				bean.setAltezza(rs.getDouble("altezza"));
				bean.setCo2(rs.getInt("co2"));
				bean.setDescrizione(rs.getString("descrizione"));
				bean.setDescrizioneBreve(rs.getString("descrizioneBreve"));
				bean.setId(rs.getInt("id"));
				bean.setNome(rs.getString("nome"));
				bean.setNomeScientifico(rs.getString("nomeScientifico"));
				bean.setOnSale(rs.getInt("onSale"));
				bean.setPaeseDiOrigine(rs.getString("pid"));
				bean.setPrezzo(rs.getDouble("prezzo"));
				bean.setQuantità(rs.getInt("quantità"));
				bean.setSalvaguardia(rs.getInt("Salvaguardia"));
				bean.setCategories(findProductCategory(bean.getId()));
				bean.setDoveVienePiantato(rs.getString("doveVienePiantato"));
				bean.setSottotitolo(rs.getString("sottotitolo"));
				bean.setSaldo(rs.getDouble("saldo"));
				bean.setTasse(rs.getDouble("tasse"));
				bean.setDisponibile(rs.getBoolean("disponibile"));

				beans.add(bean);
			}
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				try {
					if (connection != null) {
						connection.close();
					}
				} finally {
					if (rs != null)
						rs.close();
				}
			}
		}

		return beans;
	}

	@Override
	public synchronized void doSave(Prodotto item) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO " + ProdottoDAO.TABLE_NAME
				+ " (nome, nomeScientifico, descrizione, descrizioneBreve, altezza, prezzo,"
				+ " pid, quantità, co2, salvaguardia, sottotitolo, doveVienePiantato) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?,?,?)";

		try {
			connection = ds.getConnection();

			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setString(1, item.getNome());
			preparedStatement.setString(2, item.getNomeScientifico());
			preparedStatement.setString(3, item.getDescrizione());
			preparedStatement.setString(4, item.getDescrizioneBreve());
			preparedStatement.setDouble(5, item.getAltezza());
			preparedStatement.setDouble(6, item.getPrezzo());
			preparedStatement.setString(7, item.getPaeseDiOrigine());
			preparedStatement.setDouble(8, item.getQuantità());
			preparedStatement.setDouble(9, item.getCo2());
			preparedStatement.setDouble(10, item.getSalvaguardia());
			preparedStatement.setString(11, item.getSottotitolo());
			preparedStatement.setString(12, item.getDoveVienePiantato());

			preparedStatement.executeUpdate();

			connection.commit();
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
	}

	// se serve la faccioo
	@Override
	public int doUpdate(Prodotto item) throws SQLException {
		return 0;

	}

	@Override
	public synchronized boolean doDelete(Prodotto item) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		int result = 0;

		String deleteSQL = "DELETE FROM " + ProdottoDAO.TABLE_NAME + " WHERE id = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(deleteSQL);
			preparedStatement.setInt(1, item.getId());

			result = preparedStatement.executeUpdate();

		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}

		return (result != 0);
	}

	public synchronized Collection<Categoria> findProductCategory(int id) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<Categoria> cats = new LinkedList<Categoria>();
		String selectSQL = "SELECT * FROM categoria WHERE id IN (SELECT cid FROM categorie_prodotti WHERE pid=?) ";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, id);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				Categoria bean = new Categoria();

				bean.setId(rs.getInt("id"));
				bean.setNome(rs.getString("nome"));
				bean.setDescrizione(rs.getString("descrizione"));

				cats.add(bean);
			}
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return cats;
	}

	public synchronized Collection<Prodotto> findProductCountry(String country) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<Prodotto> prods = new LinkedList<Prodotto>();
		String selectSQL = "SELECT * FROM prodotto WHERE pid=?";
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, country);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				Prodotto bean = new Prodotto();

				bean.setAltezza(rs.getDouble("altezza"));
				bean.setCo2(rs.getInt("co2"));
				bean.setDescrizione(rs.getString("descrizione"));
				bean.setDescrizioneBreve(rs.getString("descrizioneBreve"));
				bean.setId(rs.getInt("id"));
				bean.setNome(rs.getString("nome"));
				bean.setNomeScientifico(rs.getString("nomeScientifico"));
				bean.setOnSale(rs.getInt("onSale"));
				bean.setPaeseDiOrigine(rs.getString("pid"));
				bean.setPrezzo(rs.getDouble("prezzo"));
				bean.setQuantità(rs.getInt("quantità"));
				bean.setSalvaguardia(rs.getInt("Salvaguardia"));
				bean.setCategories(findProductCategory(bean.getId()));
				bean.setDoveVienePiantato(rs.getString("doveVienePiantato"));
				bean.setSottotitolo(rs.getString("sottotitolo"));
				bean.setSaldo(rs.getDouble("saldo"));
				bean.setTasse(rs.getDouble("tasse"));
				bean.setDisponibile(rs.getBoolean("disponibile"));

				prods.add(bean);
			}
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return prods;
	}

	public synchronized Collection<Prodotto> findProducbyCategory(int category) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<Prodotto> prods = new LinkedList<Prodotto>();
		String selectSQL = "SELECT * FROM categorie_prodotti AS c, prodotto AS p WHERE cid=? AND (c.pid=p.id)";
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, category);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				Prodotto bean = new Prodotto();

				bean.setAltezza(rs.getDouble("altezza"));
				bean.setCo2(rs.getInt("co2"));
				bean.setDescrizione(rs.getString("descrizione"));
				bean.setDescrizioneBreve(rs.getString("descrizioneBreve"));
				bean.setId(rs.getInt("id"));
				bean.setNome(rs.getString("nome"));
				bean.setNomeScientifico(rs.getString("nomeScientifico"));
				bean.setOnSale(rs.getInt("onSale"));
				bean.setPaeseDiOrigine(rs.getString("pid"));
				bean.setPrezzo(rs.getDouble("prezzo"));
				bean.setQuantità(rs.getInt("quantità"));
				bean.setSalvaguardia(rs.getInt("Salvaguardia"));
				bean.setCategories(findProductCategory(bean.getId()));
				bean.setDoveVienePiantato(rs.getString("doveVienePiantato"));
				bean.setSottotitolo(rs.getString("sottotitolo"));
				bean.setSaldo(rs.getDouble("saldo"));
				bean.setTasse(rs.getDouble("tasse"));
				bean.setDisponibile(rs.getBoolean("disponibile"));

				prods.add(bean);
			}
		} finally {
			try {
				if (preparedStatement != null)
					preparedStatement.close();
			} finally {
				if (connection != null)
					connection.close();
			}
		}
		return prods;
	}

}
