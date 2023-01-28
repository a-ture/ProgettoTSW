package it.unisa.model;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
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

import it.unisa.beans.PaeseDiOrigine;

public class PaeseDiOrigineDAO implements GenericDAO<PaeseDiOrigine> {
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
	private static final String TABLE_NAME = "paeseDiOrigine";

	public synchronized static byte[] load(String id) {

		Connection connection = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		byte[] bt = null;

		try {
			connection = ds.getConnection();
			String sql = "SELECT foto FROM paeseDiOrigine WHERE nome = ?";
			stmt = connection.prepareStatement(sql);

			stmt.setString(1, id);
			rs = stmt.executeQuery();

			if (rs.next()) {
				bt = rs.getBytes("foto");
			}

		} catch (SQLException sqlException) {
			System.out.println(sqlException);
		} finally {
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException sqlException) {
				System.out.println(sqlException);
			} finally {
				if (connection != null)
					try {
						connection.close();
					} catch (SQLException e) {
						System.out.println(e);
					}
			}
		}
		return bt;

	}

	public synchronized static void updatePhoto(String idA, String photo) throws SQLException {
		Connection con = null;
		PreparedStatement stmt = null;

		try {
			con = ds.getConnection();
			stmt = con.prepareStatement("UPDATE paeseDiOrigine SET foto = ? WHERE nome = ?");

			File file = new File(photo);
			try {
				FileInputStream fis = new FileInputStream(file);
				stmt.setBinaryStream(1, fis, fis.available());
				stmt.setString(2, idA);

				stmt.executeUpdate();
				con.commit();
			} catch (FileNotFoundException e) {
				System.out.println(e);
			} catch (IOException e) {
				System.out.println(e);
			}
		} finally {
			try {
				if (stmt != null)
					stmt.close();
			} catch (SQLException sqlException) {
				System.out.println(sqlException);
			} finally {
				if (con != null)
					con.close();
			}
		}
	}

	@Override
	public PaeseDiOrigine doRetriveByKey(String code) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		PaeseDiOrigine bean = new PaeseDiOrigine();

		String selectSQL = "SELECT * FROM " + PaeseDiOrigineDAO.TABLE_NAME + " WHERE nome= ?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setString(1, code);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				bean.setDescrizione(rs.getString("descrizione"));
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
	public Collection<PaeseDiOrigine> doRetriveAll(String order) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet rs = null;

		Collection<PaeseDiOrigine> beans = new LinkedList<PaeseDiOrigine>();

		String selectSQL = "SELECT * FROM " + PaeseDiOrigineDAO.TABLE_NAME;

		if (order != null && !order.equals("")) {
			selectSQL += " ORDER BY " + order;
		}

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			rs = preparedStatement.executeQuery();

			while (rs.next()) {
				PaeseDiOrigine bean = new PaeseDiOrigine();
				bean.setDescrizione(rs.getString("descrizione"));
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
	public void doSave(PaeseDiOrigine item) throws SQLException {

	}

	@Override
	public int doUpdate(PaeseDiOrigine item) throws SQLException {

		return 0;
	}

	@Override
	public boolean doDelete(PaeseDiOrigine item) throws SQLException {

		return false;
	}
}