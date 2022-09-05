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

import it.unisa.beans.Indirizzo;

public class IndirizzoDAO implements GenericDAO<Indirizzo> {

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

	private static final String TABLE_NAME = "indirizzo";

	@Override
	public Indirizzo doRetriveByKey(String code) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Indirizzo bean = new Indirizzo();

		String selectSQL = "SELECT * FROM " + IndirizzoDAO.TABLE_NAME + " WHERE id = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, Integer.parseInt(code));

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
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
	public Collection<Indirizzo> doRetriveAll(String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet rs = null;

		Collection<Indirizzo> beans = new LinkedList<Indirizzo>();

		String selectSQL = "SELECT * FROM " + IndirizzoDAO.TABLE_NAME;

		if (order != null && !order.equals("")) {
			selectSQL += " ORDER BY " + order;
		}

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			rs = preparedStatement.executeQuery();

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
	public void doSave(Indirizzo item) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO " + IndirizzoDAO.TABLE_NAME
				+ " (cid, nome, cognome, via, cap, città, provincia, civico, preferred)"
				+ " VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";

		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);

			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setInt(1, item.getUid());
			preparedStatement.setString(2, item.getNome());
			preparedStatement.setString(3, item.getCognome());
			preparedStatement.setString(4, item.getVia());
			preparedStatement.setString(5, item.getCAP());
			preparedStatement.setString(6, item.getCittà());
			preparedStatement.setString(7, item.getProvincia());
			preparedStatement.setString(8, item.getCivico());
			preparedStatement.setBoolean(9, item.isPreferred());

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

	@Override
	public int doUpdate(Indirizzo item) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "UPDATE " + IndirizzoDAO.TABLE_NAME
				+ " SET nome = ?, cognome = ?, via = ?, cap = ?, città = ?, provincia = ?,"
				+ " civico = ?, preferred = ?  WHERE id = ? ";

		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);

			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setString(1, item.getNome());
			preparedStatement.setString(2, item.getCognome());
			preparedStatement.setString(3, item.getVia());
			preparedStatement.setString(4, item.getCAP());
			preparedStatement.setString(5, item.getCittà());
			preparedStatement.setString(6, item.getProvincia());
			preparedStatement.setString(7, item.getCivico());
			preparedStatement.setBoolean(8, item.isPreferred());
			preparedStatement.setInt(9, item.getId());

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
	public boolean doDelete(Indirizzo item) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		int result = 0;

		String deleteSQL = "DELETE FROM " + IndirizzoDAO.TABLE_NAME + " WHERE id = ?";

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

}
