package it.unisa.model;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.Collection;
import java.util.LinkedList;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

import it.unisa.beans.Ordine;
import it.unisa.beans.ProdottoOrdine;
import it.unisa.beans.Utente;

public class OrdineDAO implements GenericDAO<Ordine> {

	private static DataSource ds;
	private static final String TABLE_NAME = "ordine";

	static {
		try {
			Context initCtx = new InitialContext();
			Context envCtx = (Context) initCtx.lookup("java:comp/env");

			ds = (DataSource) envCtx.lookup("jdbc/WoodLot");

		} catch (NamingException e) {
			System.out.println("Error:" + e.getMessage());
		}
	}

	@Override
	public Ordine doRetriveByKey(String code) throws SQLException {

		String selectSQL = "SELECT * FROM ordine WHERE id=?";
		Ordine ordine = new Ordine();
		UtenteDAO dao = new UtenteDAO();
		try (var conn = ds.getConnection()) {
			try (var stmt = conn.prepareStatement(selectSQL)) {
				stmt.setInt(1, Integer.parseInt(code));
				ResultSet rs = stmt.executeQuery();
				if (rs.next()) {
					ordine.setId(rs.getInt("id"));
					ordine.setTotaleProdotti(rs.getInt("totaleProdotti"));
					ordine.setTotalePagato(rs.getDouble("totalePagato"));
					ordine.setRegalo(rs.getBoolean("regalo"));
					ordine.setMessaggioRegalo(rs.getString("messaggioRegalo"));
					ordine.setCreatoIl(rs.getTimestamp("creatoIl").toLocalDateTime());
					ordine.setDestinatarioRegalo(rs.getString("destinatarioRegalo"));
					ordine.setUtente(dao.doRetriveByKey(rs.getInt("uid") + ""));
					ordine.setItems(findProductOrder(ordine.getId()));
				}
			}
		}
		return ordine;
	}

	@Override
	public Collection<Ordine> doRetriveAll(String order) throws SQLException {
		Collection<Ordine> ordini = new LinkedList<>();
		String selectSQL = "SELECT * FROM ordine AS o";
		UtenteDAO dao = new UtenteDAO();
		if (order != null && !order.equals("")) {
			selectSQL += " ORDER BY " + order;
		}
		try (var conn = ds.getConnection()) {
			try (var stmt = conn.prepareStatement(selectSQL)) {

				ResultSet rs = stmt.executeQuery();
				while (rs.next()) {
					Ordine ordine = new Ordine();
					ordine.setId(rs.getInt("id"));
					ordine.setTotaleProdotti(rs.getInt("totaleProdotti"));
					ordine.setTotalePagato(rs.getDouble("totalePagato"));
					ordine.setRegalo(rs.getBoolean("regalo"));
					ordine.setMessaggioRegalo(rs.getString("messaggioRegalo"));
					ordine.setCreatoIl(rs.getTimestamp("creatoIl").toLocalDateTime());
					ordine.setUtente(dao.doRetriveByKey(rs.getInt("uid") + ""));
					ordine.setDestinatarioRegalo(rs.getString("destinatarioRegalo"));
					ordine.setItems(findProductOrder(ordine.getId()));
					ordini.add(ordine);
				}
			}
		}
		return ordini;
	}

	public void doSave(Ordine dao) throws SQLException {
		String insertOrder = "INSERT INTO ordine (uid,  totaleProdotti, totalePagato, regalo, messaggioRegalo, destinatarioRegalo) "
				+ "VALUES (?, ?, ?, ?, ?, ?)";
		String insertItem = "INSERT INTO prodottoOrdine "
				+ "(oid, nome, descrizione, breveDescrizione, prezzo, saldo, quantità, tasse, stato) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
		var conn = ds.getConnection();
		conn.setAutoCommit(false);
		try (var stmt = conn.prepareStatement(insertOrder, Statement.RETURN_GENERATED_KEYS)) {
			stmt.setInt(1, dao.getUtente().getId());
			stmt.setInt(2, dao.getTotaleProdotti());
			stmt.setDouble(3, dao.getTotalePagato());
			stmt.setBoolean(4, dao.isRegalo());
			stmt.setString(5, dao.getMessaggioRegalo());
			stmt.setString(6, dao.getDestinatarioRegalo());

			stmt.executeUpdate();

			ResultSet rs = stmt.getGeneratedKeys();
			if (rs.next()) {
				int lastInsertedId = rs.getInt(1);
				for (ProdottoOrdine item : dao.getItems()) {
					var stmt2 = conn.prepareStatement(insertItem);
					stmt2.setInt(1, lastInsertedId);
					stmt2.setString(2, item.getNome());
					stmt2.setString(3, item.getDescrizione());
					stmt2.setString(4, item.getBreveDescrizione());
					stmt2.setDouble(5, item.getPrezzo());
					stmt2.setDouble(6, item.getSaldo());
					stmt2.setInt(7, item.getQuantità());
					stmt2.setDouble(8, item.getTasse());
					stmt2.setString(9, item.getStato());

					stmt2.execute();
				}
			}
			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
			conn.rollback();
		}
	}

	public void doUpdateProduct(int id, String stato) throws SQLException {
		String updateItem = "UPDATE  prodottoOrdine SET stato=? " + "WHERE id = ?";
		var conn = ds.getConnection();

		try {
			var stmt = conn.prepareStatement(updateItem);
			stmt.setString(1, stato);
			stmt.setInt(2, id);

			stmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();

		}
	}

	@Override
	public int doUpdate(Ordine dao) throws SQLException {
		String updateOrder = "UPDATE  ordine SET(totaleProdotti = ?, totalePagato =?, regalo=?, messaggioRegalo=?) "
				+ "WHERE uid = ? and id = ? ";
		String updateItem = "UPDATE  prodottoOrdine SET(nome = ?, descrizione = ?, breveDescrizione = ?"
				+ ", prezzo = ?, saldo = ?, quantità= ?, tasse=? ) " + "WHERE id = ? and oid = ?  ";
		var conn = ds.getConnection();

		try {
			var stmt = conn.prepareStatement(updateOrder);
			stmt.setInt(1, dao.getTotaleProdotti());
			stmt.setDouble(2, dao.getTotalePagato());
			stmt.setBoolean(3, dao.isRegalo());
			stmt.setString(4, dao.getMessaggioRegalo());
			stmt.setInt(5, dao.getUtente().getId());
			stmt.setInt(6, dao.getId());

			stmt.executeUpdate();

			for (ProdottoOrdine item : dao.getItems()) {
				var stmt2 = conn.prepareStatement(updateItem);

				stmt2.setString(1, item.getNome());
				stmt2.setString(2, item.getDescrizione());
				stmt2.setString(3, item.getBreveDescrizione());
				stmt2.setDouble(4, item.getPrezzo());
				stmt2.setDouble(5, item.getSaldo());
				stmt2.setInt(6, item.getQuantità());
				stmt2.setDouble(7, item.getTasse());
				stmt2.setInt(8, item.getId());
				stmt2.setInt(9, dao.getId());
				stmt2.execute();
			}

		} catch (SQLException e) {
			e.printStackTrace();
			conn.rollback();
		}

		return 0;
	}

	public int doUpdateMexGift(Ordine dao) throws SQLException {
		String updateOrder = "UPDATE  ordine SET messaggioRegalo=? " + "WHERE  id = ? ";

		var conn = ds.getConnection();

		try {
			var stmt = conn.prepareStatement(updateOrder);

			stmt.setString(1, dao.getMessaggioRegalo());
			stmt.setInt(2, dao.getId());
			stmt.executeUpdate();

		} catch (SQLException e) {
			e.printStackTrace();

		}

		return 0;
	}

	@Override
	public boolean doDelete(Ordine item) throws SQLException {
		String deleteSQL = "DELETE * FROM " + TABLE_NAME + "WHERE id = ?";
		int rs;
		try (var conn = ds.getConnection()) {
			try (var stmt = conn.prepareStatement(deleteSQL)) {

				stmt.setInt(1, item.getId());

				rs = stmt.executeUpdate();

				return rs > 0 ? true : false;
			}
		}
	}

	public Collection<Ordine> doRetrieveOrdersBetween(Timestamp fromDate, Timestamp ToDate) throws SQLException {
		String selectSQL = "SELECT * FROM  " + TABLE_NAME + " WHERE creatoIl  BETWEEN ? AND ?";

		Collection<Ordine> ordini = new LinkedList<>();
		UtenteDAO dao = new UtenteDAO();

		try (var conn = ds.getConnection()) {
			try (var stmt = conn.prepareStatement(selectSQL)) {

				stmt.setTimestamp(1, fromDate);
				stmt.setTimestamp(2, ToDate);

				System.out.println(stmt);
				ResultSet rs = stmt.executeQuery();
				while (rs.next()) {
					Ordine bean = new Ordine();
					bean.setId(rs.getInt("id"));
					bean.setTotaleProdotti(rs.getInt("totaleProdotti"));
					bean.setTotalePagato(rs.getDouble("totalePagato"));
					bean.setRegalo(rs.getBoolean("regalo"));
					bean.setMessaggioRegalo(rs.getString("messaggioRegalo"));
					bean.setCreatoIl(rs.getTimestamp("creatoIl").toLocalDateTime());
					bean.setUtente(dao.doRetriveByKey(rs.getInt("uid") + ""));
					ordini.add(bean);
				}
			}
		}
		return ordini;
	}

	public Collection<Ordine> doRetrieveSome(String order, int from, int howMany) throws SQLException {
		Collection<Ordine> orders = new LinkedList<>();
		String selectSQL = "SELECT * FROM  " + TABLE_NAME + " ORDER BY ? LIMIT ? OFFSET ? ";
		try (var conn = ds.getConnection()) {
			try (var stmt = conn.prepareStatement(selectSQL)) {

				stmt.setString(1, order);
				stmt.setInt(2, howMany);
				stmt.setInt(3, from);

				ResultSet rs = stmt.executeQuery();
				while (rs.next()) {
					Ordine bean = new Ordine();

					bean.setId(rs.getInt("id"));
					bean.setTotaleProdotti(rs.getInt("totaleProdotti"));
					bean.setTotalePagato(rs.getDouble("totalePagato"));
					bean.setRegalo(rs.getBoolean("regalo"));
					bean.setMessaggioRegalo(rs.getString("messaggioRegalo"));
					bean.setCreatoIl(rs.getTimestamp("creatoIl").toLocalDateTime());
					bean.setDestinatarioRegalo(rs.getString("destinatarioRegalo"));
				}
			}
		}
		return orders;
	}

	public Collection<Ordine> doRetriveByUser(Utente userBean) throws SQLException {
		Collection<Ordine> ordini = new LinkedList<Ordine>();
		String selectSQL = "SELECT * FROM " + TABLE_NAME + " WHERE uid=? ";
		try (var conn = ds.getConnection()) {
			try (var stmt = conn.prepareStatement(selectSQL)) {

				stmt.setInt(1, userBean.getId());
				ResultSet rs = stmt.executeQuery();
				while (rs.next()) {
					Ordine ordine = new Ordine();
					ordine.setId(rs.getInt("id"));
					ordine.setTotaleProdotti(rs.getInt("totaleProdotti"));
					ordine.setTotalePagato(rs.getDouble("totalePagato"));
					ordine.setRegalo(rs.getBoolean("regalo"));
					ordine.setMessaggioRegalo(rs.getString("messaggioRegalo"));
					ordine.setDestinatarioRegalo(rs.getString("destinatarioRegalo"));
					ordine.setCreatoIl(rs.getTimestamp("creatoIl").toLocalDateTime());
					ordine.setUtente(userBean);
					ordine.setItems(findProductOrder(ordine.getId()));
					ordini.add(ordine);
				}
			}
		}
		return ordini;
	}

	public Collection<Ordine> findGiftForUser(Utente userBean) throws SQLException {
		Collection<Ordine> ordini = new LinkedList<Ordine>();
		String selectSQL = "SELECT * FROM " + TABLE_NAME + " WHERE destinatarioRegalo=? ";
		try (var conn = ds.getConnection()) {
			try (var stmt = conn.prepareStatement(selectSQL)) {
				Ordine ordine = new Ordine();
				stmt.setString(1, userBean.getEmail());
				ResultSet rs = stmt.executeQuery();
				while (rs.next()) {
					ordine.setId(rs.getInt("id"));
					ordine.setTotaleProdotti(rs.getInt("totaleProdotti"));
					ordine.setTotalePagato(rs.getDouble("totalePagato"));
					ordine.setRegalo(rs.getBoolean("regalo"));
					ordine.setMessaggioRegalo(rs.getString("messaggioRegalo"));
					ordine.setCreatoIl(rs.getTimestamp("creatoIl").toLocalDateTime());
					ordine.setUtente(userBean);
					ordine.setItems(findProductOrder(ordine.getId()));
					ordini.add(ordine);
				}
			}
		}
		return ordini;
	}

	public Collection<ProdottoOrdine> findBestSellingProducts() throws SQLException {
		Collection<ProdottoOrdine> prodotti = new LinkedList<ProdottoOrdine>();
		String selectSQL = "SELECT nome, COUNT(*) AS count FROM prodottoOrdine  GROUP BY nome ORDER BY count DESC";
		try (var conn = ds.getConnection()) {
			try (var stmt = conn.prepareStatement(selectSQL)) {
				ResultSet rs = stmt.executeQuery();
				while (rs.next()) {
					ProdottoOrdine bean = new ProdottoOrdine();
					bean.setId(rs.getInt("count"));
					bean.setNome(rs.getString("nome"));
					prodotti.add(bean);
				}
			}
		}
		return prodotti;
	}

	public Collection<ProdottoOrdine> findProductOrder(int code) throws SQLException {
		Collection<ProdottoOrdine> prodotti = new LinkedList<ProdottoOrdine>();
		String selectSQL = "SELECT * FROM prodottoOrdine AS p LEFT JOIN ordine AS o ON p.oid=o.id WHERE o.id=? ";
		try (var conn = ds.getConnection()) {
			try (var stmt = conn.prepareStatement(selectSQL)) {
				stmt.setInt(1, code);
				ResultSet rs = stmt.executeQuery();
				while (rs.next()) {
					ProdottoOrdine item = new ProdottoOrdine();

					item.setId(rs.getInt("id"));
					item.setOid(rs.getInt("oid"));
					item.setNome(rs.getString("nome"));
					item.setDescrizione(rs.getString("descrizione"));
					item.setBreveDescrizione(rs.getString("breveDescrizione"));
					item.setTasse(rs.getInt("tasse"));
					item.setPrezzo(rs.getDouble("prezzo"));
					item.setSaldo(rs.getDouble("saldo"));
					item.setQuantità(rs.getInt("quantità"));
					item.setStato(rs.getString("stato"));

					prodotti.add(item);
				}
			}
		}
		return prodotti;
	}

	public int doRetrieveCount() throws SQLException {
		String sql = "SELECT COUNT(*) AS c FROM " + TABLE_NAME;
		try (var conn = ds.getConnection()) {
			try (var stmt = conn.prepareStatement(sql)) {
				ResultSet rs = stmt.executeQuery();
				return rs.next() ? rs.getInt("c") : 0;
			}
		}
	}

	public synchronized static byte[] load(String id) {

		Connection connection = null;
		PreparedStatement stmt = null;
		ResultSet rs = null;

		byte[] bt = null;

		try {
			connection = ds.getConnection();
			String sql = "SELECT foto FROM prodottoOrdine  WHERE id = ?";
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

	public synchronized static void updatePhoto(int idA, String photo) throws SQLException {
		Connection con = null;
		PreparedStatement stmt = null;

		try {
			con = ds.getConnection();
			stmt = con.prepareStatement("UPDATE prodottoOrdine SET foto = ? WHERE id= ?");

			File file = new File(photo);
			try {
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

}
