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

public class CategoriaDAO implements GenericDAO<Categoria> {

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

	private static final String TABLE_NAME = "categoria";

	@Override
	public Categoria doRetriveByKey(String code) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Categoria bean = new Categoria();

		String selectSQL = "SELECT * FROM " + CategoriaDAO.TABLE_NAME + " WHERE id = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, Integer.parseInt(code));

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				bean.setDescrizione(rs.getString("descrizione"));
				bean.setId(rs.getInt("id"));
				bean.setNome(rs.getString("nome"));
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
	public Collection<Categoria> doRetriveAll(String order) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet rs = null;

		Collection<Categoria> beans = new LinkedList<Categoria>();

		String selectSQL = "SELECT * FROM " + CategoriaDAO.TABLE_NAME;

		if (order != null && !order.equals("")) {
			selectSQL += " ORDER BY " + order;
		}

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			rs = preparedStatement.executeQuery();

			while (rs.next()) {
				Categoria bean = new Categoria();

				bean.setDescrizione(rs.getString("descrizione"));
				bean.setId(rs.getInt("id"));
				bean.setNome(rs.getString("nome"));

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
	public void doSave(Categoria item) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO " + CategoriaDAO.TABLE_NAME + " (nome,descrizione)" + " VALUES (?, ?)";

		try {
			connection = ds.getConnection();

			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setString(1, item.getNome());
			preparedStatement.setString(2, item.getDescrizione());

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
	public int doUpdate(Categoria item) throws SQLException {
		return 0;
	}

	@Override
	public boolean doDelete(Categoria item) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		int result = 0;

		String deleteSQL = "DELETE FROM " + CategoriaDAO.TABLE_NAME + " WHERE id = ?";

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
