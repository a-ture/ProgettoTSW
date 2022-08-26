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

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import it.unisa.beans.UsoLocale;

public class UsoLocaleDAO implements GenericDAO<UsoLocale> {

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
	private static final String TABLE_NAME = "usiLocali";

	@Override
	public UsoLocale doRetriveByKey(String code) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		UsoLocale bean = new UsoLocale();

		String selectSQL = "SELECT * FROM " + UsoLocaleDAO.TABLE_NAME + "  WHERE id = ?";

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
	public Collection<UsoLocale> doRetriveAll(String order) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Collection<UsoLocale> beans = new ArrayList<UsoLocale>();
		String selectSQL = "SELECT * FROM " + UsoLocaleDAO.TABLE_NAME;

		if (order != null && !order.equals("")) {
			selectSQL += " ORDER BY " + order;
		}
		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {
				UsoLocale bean = new UsoLocale();

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
				if (connection != null)
					connection.close();
			}
		}
		return beans;

	}

	@Override
	public void doSave(UsoLocale item) throws SQLException {
		// TODO Auto-generated method stub

	}

	@Override
	public int doUpdate(UsoLocale item) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public boolean doDelete(UsoLocale item) throws SQLException {
		// TODO Auto-generated method stub
		return false;
	}

	public synchronized static byte[] load(String id) {

		Connection connection = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		byte[] bt = null;

		try {
			connection = ds.getConnection();
			String sql = "SELECT foto FROM usiLocali  WHERE id = ?";
			stmt = connection.prepareStatement(sql);

			stmt.setInt(1, Integer.parseInt(id));
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
			stmt = con.prepareStatement("UPDATE usiLocali SET foto = ? WHERE id= ?");

			File file = new File(photo);
			try {
				FileInputStream fis = new FileInputStream(file);
				stmt.setBinaryStream(1, fis, fis.available());
				stmt.setInt(2, Integer.parseInt(idA));

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
}
