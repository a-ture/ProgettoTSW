package it.unisa.model;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.LinkedList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import it.unisa.beans.Indirizzo;
import it.unisa.beans.Utente;

public class UtenteDAO implements GenericDAO<Utente> {

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

	private static final String TABLE_NAME = "utente";

	@Override
	public Utente doRetriveByKey(String code) throws SQLException {

		Utente bean = new Utente();

		String selectSQL = "SELECT * FROM " + UtenteDAO.TABLE_NAME + " WHERE id=?";

		try (var conn = ds.getConnection()) {
			try (var stmt = conn.prepareStatement(selectSQL)) {
				stmt.setInt(1, Integer.parseInt(code));
				ResultSet rs = stmt.executeQuery();
				if (rs.next()) {
					bean.setNome(rs.getString("nome"));
					bean.setCognome(rs.getString("cognome"));
					bean.setId(rs.getInt("id"));
					bean.setEmail(rs.getString("email"));
					bean.setPassword(rs.getString("password"));
					bean.setRole(rs.getString("role"));
					bean.setIndirizzi(doRetriveByUser(bean.getId()));
				}

			}
		}
		return bean;
	}

	@Override
	public Collection<Utente> doRetriveAll(String order) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet rs = null;

		Collection<Utente> beans = new LinkedList<Utente>();

		String selectSQL = "SELECT * FROM " + UtenteDAO.TABLE_NAME;

		if (order != null && !order.equals("")) {
			selectSQL += " ORDER BY " + order;
		}

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			rs = preparedStatement.executeQuery();

			while (rs.next()) {
				Utente bean = new Utente();

				bean.setCognome(rs.getString("cognome"));
				bean.setEmail(rs.getString("email"));
				bean.setId(rs.getInt("id"));
				bean.setNome(rs.getString("nome"));
				bean.setPassword(rs.getString("password"));
				bean.setRole(rs.getString("role"));
				bean.setIndirizzi(doRetriveByUser(bean.getId()));
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

	public Collection<Utente> doRetriveByOrder() throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet rs = null;

		Collection<Utente> beans = new LinkedList<Utente>();

		String selectSQL = "SELECT uid, COUNT(*) AS count  FROM ordine  group by uid ORDER BY count DESC";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			rs = preparedStatement.executeQuery();

			while (rs.next()) {
				Utente bean = new Utente();
				bean.setId(rs.getInt("uid"));
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
	public void doSave(Utente item) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO " + UtenteDAO.TABLE_NAME
				+ " (password,email,nome,cognome,role) VALUES (?,?,?,?,?)";

		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setString(1, item.getPassword());
			preparedStatement.setString(2, item.getEmail());
			preparedStatement.setString(3, item.getNome());
			preparedStatement.setString(4, item.getCognome());
			preparedStatement.setString(5, item.getRole());

			preparedStatement.executeUpdate();

			connection.commit();
		} catch (SQLException e) {
			e.printStackTrace();
			connection.rollback();
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

	@Override
	public int doUpdate(Utente item) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "UPDATE " + UtenteDAO.TABLE_NAME + " SET nome = ?, cognome = ?, email = ?"
				+ " WHERE id = ? ";

		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);

			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setString(1, item.getNome());
			preparedStatement.setString(2, item.getCognome());
			preparedStatement.setString(3, item.getEmail());
			preparedStatement.setInt(4, item.getId());
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
		return 0;
	}

	@Override
	public boolean doDelete(Utente item) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		int result = 0;

		String deleteSQL = "DELETE FROM " + UtenteDAO.TABLE_NAME + " WHERE id = ?";

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

	public Utente doRetriveByEmail(String email) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Utente bean = new Utente();

		String selectSQL = "SELECT * FROM " + UtenteDAO.TABLE_NAME + " WHERE email = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, email);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {

				bean.setCognome(rs.getString("cognome"));
				bean.setEmail(rs.getString("email"));
				bean.setId(rs.getInt("id"));
				bean.setNome(rs.getString("nome"));
				bean.setPassword(rs.getString("password"));
				bean.setRole(rs.getString("role"));
				bean.setIndirizzi(doRetriveByUser(bean.getId()));
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
	

	public Collection<Indirizzo> doRetriveByUser(int i) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		Collection<Indirizzo> beans = new ArrayList<Indirizzo>();

		String selectSQL = "SELECT * FROM  indirizzo  WHERE cid = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, i);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				Indirizzo bean = new Indirizzo();
				
				bean.setCAP(rs.getString("cap"));
				bean.setCittà(rs.getString("città"));
				bean.setCognome(rs.getString("cognome"));
				bean.setId(rs.getInt("id"));
				bean.setVia(rs.getString("via"));
				bean.setNome(rs.getString("nome"));
				bean.setPreferred(rs.getBoolean("preferred"));
				bean.setUid(rs.getInt("cid"));
				bean.setCivico(rs.getString("civico"));
				bean.setProvincia(rs.getString("provincia"));
			
				beans.add(bean);
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
		return beans;
	}

	

	

}
