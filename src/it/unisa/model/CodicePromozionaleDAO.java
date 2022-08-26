package it.unisa.model;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Collection;
import java.util.LinkedList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import it.unisa.beans.CodicePromozionale;

public class CodicePromozionaleDAO implements GenericDAO<CodicePromozionale> {

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
	private static final String TABLE_NAME = "codicePromozionale";

	@Override
	public CodicePromozionale doRetriveByKey(String code) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		CodicePromozionale bean = new CodicePromozionale();

		String selectSQL = "SELECT * FROM " + CodicePromozionaleDAO.TABLE_NAME + " WHERE id = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, Integer.parseInt(code));

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				bean.setDescrizione(rs.getString("descrizione"));
				bean.setId(rs.getInt("id"));
				bean.setCodice(rs.getString("codice"));
				bean.setDataFineValidità(rs.getDate("dataFineValidità"));
				bean.setDataInzioValidità(rs.getDate("dataInizioValidità"));
				bean.setScontoApplicato(rs.getDouble("scontoApplicato"));
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
	public Collection<CodicePromozionale> doRetriveAll(String order) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet rs = null;

		Collection<CodicePromozionale> beans = new LinkedList<CodicePromozionale>();

		String selectSQL = "SELECT * FROM " + CodicePromozionaleDAO.TABLE_NAME;

		if (order != null && !order.equals("")) {
			selectSQL += " ORDER BY " + order;
		}

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			rs = preparedStatement.executeQuery();

			while (rs.next()) {
				CodicePromozionale bean = new CodicePromozionale();

				bean.setDescrizione(rs.getString("descrizione"));
				bean.setId(rs.getInt("id"));
				bean.setCodice(rs.getString("codice"));
				bean.setDataFineValidità(rs.getDate("dataFineValidità"));
				bean.setDataInzioValidità(rs.getDate("dataInizioValidità"));
				bean.setScontoApplicato(rs.getDouble("scontoApplicato"));

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
	public void doSave(CodicePromozionale item) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		String insertSQL = "INSERT INTO " + CodicePromozionaleDAO.TABLE_NAME
				+ " (codice,dataInizioValidità,dataFineValidità,scontoApplicato,descrizione)"
				+ " VALUES (?, ?, ?, ?, ?)";

		try {
			connection = ds.getConnection();

			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setString(1, item.getCodice());
			preparedStatement.setDate(2, (Date) item.getDataInzioValidità());
			preparedStatement.setDate(3, (Date) item.getDataFineValidità());
			preparedStatement.setDouble(4, item.getScontoApplicato());
			preparedStatement.setString(5, item.getDescrizione());

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
	public int doUpdate(CodicePromozionale item) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public boolean doDelete(CodicePromozionale item) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		int result = 0;

		String deleteSQL = "DELETE FROM " + CodicePromozionaleDAO.TABLE_NAME + " WHERE id = ?";

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

	public CodicePromozionale doRetriveByName(String codice) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		CodicePromozionale bean = new CodicePromozionale();

		String selectSQL = "SELECT * FROM " + CodicePromozionaleDAO.TABLE_NAME + " WHERE codice = ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, codice);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				bean.setDescrizione(rs.getString("descrizione"));
				bean.setId(rs.getInt("id"));
				bean.setCodice(rs.getString("codice"));
				bean.setDataFineValidità(rs.getDate("dataFineValidità"));
				bean.setDataInzioValidità(rs.getDate("dataInizioValidità"));
				bean.setScontoApplicato(rs.getDouble("scontoApplicato"));
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

}
