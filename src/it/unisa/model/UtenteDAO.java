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

		String selectSQL = "SELECT * FROM " + UtenteDAO.TABLE_NAME
				+ "AS u, indirizzo  AS i WHERE u.id = i.cid AND u.id=?";

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
					bean.setActive(rs.getBoolean("active"));
				}
				// in this case there are at least one address
				if (rs.getInt("id") != 0) {
					do {
						Indirizzo addr = new Indirizzo();
						addr.setId(rs.getInt("id"));
						addr.setNome(rs.getString("nome"));
						addr.setCognome(rs.getString("cognome"));
						addr.setVia(rs.getString("via"));
						addr.setCAP(rs.getString("cap"));
						addr.setCittà(rs.getString("città"));
						addr.setProvincia(rs.getString("provincia"));
						addr.setCivico(rs.getString("civico"));
						addr.setPreferred(rs.getBoolean("preferred"));
						bean.aggiungiIndirizzo(addr);
					} while (rs.next());
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
				bean.setActive(rs.getBoolean("active"));
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
				+ " (username,password,email,nome,cognome,role) VALUES (?,?,?,?,?,?)";

		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);
			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setString(1, item.getUsername());
			preparedStatement.setString(2, item.getPassword());
			preparedStatement.setString(3, item.getEmail());
			preparedStatement.setString(4, item.getNome());
			preparedStatement.setString(5, item.getCognome());
			preparedStatement.setString(6, item.getRole());

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

		String insertSQL = "UPDATE " + UtenteDAO.TABLE_NAME + " SET nome = ?, cognome = ?, username = ?, email = ?"
				+ " WHERE id = ? ";

		try {
			connection = ds.getConnection();
			connection.setAutoCommit(false);

			preparedStatement = connection.prepareStatement(insertSQL);
			preparedStatement.setString(1, item.getNome());
			preparedStatement.setString(2, item.getCognome());
			preparedStatement.setString(3, item.getUsername());
			preparedStatement.setString(4, item.getEmail());
			preparedStatement.setInt(5, item.getId());
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
				bean.setUsername(rs.getString("username"));
				bean.setRole(rs.getString("role"));
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

	public int findNumberOfTree(int id) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		int numberOfTree = 0;

		String selectSQL = "SELECT * FROM ordine" + " WHERE uid=?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, id);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {

				numberOfTree += rs.getInt("totaleProdotti");

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
		return numberOfTree;

	}

	public int findNumberOfGift(int id) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		int numberOfGift = 0;

		String selectSQL = "SELECT * FROM ordine AS o" + " WHERE uid=?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, id);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {

				numberOfGift += rs.getInt("regalo");

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
		return numberOfGift;

	}

	public double findAmountSpent(int id) throws SQLException {

		Connection connection = null;
		PreparedStatement preparedStatement = null;

		double amount = 0;

		String selectSQL = "SELECT * FROM ordine AS o" + " WHERE uid=?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, id);

			ResultSet rs = preparedStatement.executeQuery();

			while (rs.next()) {

				amount += rs.getDouble("totalePagato");

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
		return amount;

	}

	public synchronized static byte[] load(int i) {

		Connection connection = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		byte[] bt = null;

		try {
			connection = ds.getConnection();
			String sql = "SELECT foto FROM " + UtenteDAO.TABLE_NAME + " WHERE id = ?";
			stmt = connection.prepareStatement(sql);

			stmt.setInt(1, i);
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

	public synchronized static void updatePhoto(int i, String photo) throws SQLException {
		Connection con = null;
		PreparedStatement stmt = null;

		try {
			con = ds.getConnection();
			stmt = con.prepareStatement("UPDATE " + UtenteDAO.TABLE_NAME + " SET foto = ? WHERE id = ?");

			File file = new File(photo);
			try {
				FileInputStream fis = new FileInputStream(file);
				stmt.setBinaryStream(1, fis, fis.available());
				stmt.setInt(2, i);

				stmt.executeUpdate();

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
