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

import it.unisa.beans.FotoProdotto;

public class FotoProdottoDAO {
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

	public synchronized void updatePhoto(int idA, String photo) throws SQLException {
		Connection con = null;
		PreparedStatement stmt = null;

		try {
			con = ds.getConnection();
			stmt = con.prepareStatement("UPDATE fotoProdotto SET foto = ? WHERE nomeFoto = ?");

			File file = new File(photo);
			try {
				con.setAutoCommit(false);

				FileInputStream fis = new FileInputStream(file);
				stmt.setBinaryStream(1, fis, fis.available());
				stmt.setInt(2, idA);

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

	private int searchNamePhoto(String idProdotto) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet rs = null;

		String selectSQL = "SELECT nomeFoto FROM fotoProdotto WHERE pid=?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, Integer.parseInt(idProdotto));

			rs = preparedStatement.executeQuery();

			rs.next();

			return (rs.getInt("nomeFoto"));

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

	}

	public Collection<FotoProdotto> doRetriveAll(String code) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet rs = null;

		Collection<FotoProdotto> photos = new ArrayList<FotoProdotto>();

		String selectSQL = "SELECT * FROM fotoProdotto WHERE pid=?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, Integer.parseInt(code));

			rs = preparedStatement.executeQuery();

			while (rs.next()) {
				FotoProdotto bean = new FotoProdotto();
				bean.setIdProdotto(rs.getInt("pid"));
				bean.setNomeFoto(rs.getInt("nomeFoto"));

				photos.add(bean);
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

		return photos;
	}

	public FotoProdotto doRetriveOne(int code) throws SQLException {
		Connection connection = null;
		PreparedStatement preparedStatement = null;
		ResultSet rs = null;

		FotoProdotto bean = new FotoProdotto();

		String selectSQL = "SELECT * FROM fotoProdotto WHERE pid=?";

		try {
			connection = ds.getConnection();
			preparedStatement = connection.prepareStatement(selectSQL);
			preparedStatement.setInt(1, code);

			rs = preparedStatement.executeQuery();

			rs.next();

			bean.setIdProdotto(rs.getInt("pid"));
			bean.setNomeFoto(rs.getInt("nomeFoto"));

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

		return bean;
	}

	public synchronized byte[] load(int id) {
		Connection connection = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		byte[] bt = null;

		try {
			connection = ds.getConnection();
			String sql = "SELECT foto FROM fotoProdotto WHERE nomeFoto = ?";
			stmt = connection.prepareStatement(sql);

			stmt.setInt(1, id);
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
					} finally {
						if (rs != null)
							try {
								rs.close();
							} catch (SQLException e) {
								System.out.println(e);
							}
					}
			}
		}
		return bt;
	}

	public synchronized byte[] loadOnePhoto(String idProdotto) {
		Connection connection = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		byte[] bt = null;

		try {
			int id = searchNamePhoto(idProdotto);
			connection = ds.getConnection();
			String sql = "SELECT foto FROM fotoProdotto WHERE nomeFoto = ?";
			stmt = connection.prepareStatement(sql);

			stmt.setInt(1, id);
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
					} finally {
						if (rs != null)
							try {
								rs.close();
							} catch (SQLException e) {
								System.out.println(e);
							}
					}
			}
		}
		return bt;
	}
}
