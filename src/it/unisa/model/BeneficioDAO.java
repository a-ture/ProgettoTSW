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

import it.unisa.beans.Beneficio;

public class BeneficioDAO implements GenericDAO<Beneficio> {

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

	private static final String TABLE_NAME = "benefici";

	@Override
	public Beneficio doRetriveByKey(String code) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		Beneficio bean = new Beneficio();

		String selectSQL = "SELECT * FROM " + BeneficioDAO.TABLE_NAME + " WHERE id = ?";

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
	public Collection<Beneficio> doRetriveAll(String order) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet rs = null;

		Collection<Beneficio> beans = new LinkedList<Beneficio>();

		String selectSQL = "SELECT * FROM " + BeneficioDAO.TABLE_NAME;

		if (order != null && !order.equals("")) {
			selectSQL += " ORDER BY " + order;
		}

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);

			rs = preparedStatement.executeQuery();

			while (rs.next()) {
				Beneficio bean = new Beneficio();

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
	public void doSave(Beneficio item) throws SQLException {
		// TODO Auto-generated method stub

	}

	@Override
	public int doUpdate(Beneficio item) throws SQLException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public boolean doDelete(Beneficio item) throws SQLException {
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
			String sql = "SELECT foto FROM benefici WHERE id = ?";
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
			stmt = con.prepareStatement("UPDATE benefici SET foto = ? WHERE id = ?");

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
