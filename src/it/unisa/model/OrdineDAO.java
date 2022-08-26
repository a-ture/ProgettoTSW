package it.unisa.model;

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

		String selectSQL = "SELECT o.id AS orderId, o.uid, o.destination, o.totalProducts, o.totalPaid, o.trackNumber, o.gift, o.giftMessage, o.createdAt,s.* FROM "
				+ TABLE_NAME + " o LEFT JOIN prodotto_ordine s ON  s.oid = o.id WHERE o.id = ?";
		Ordine ordine = new Ordine();
		try (var conn = ds.getConnection()) {
			try (var stmt = conn.prepareStatement(selectSQL)) {
				stmt.setInt(1, Integer.parseInt(code));
				System.out.println(stmt);
				ResultSet rs = stmt.executeQuery();
				if (rs.next()) {

					ordine.setId(rs.getInt("id"));
					ordine.setTotaleProdotti(rs.getInt("totaleProdotti"));
					ordine.setTotalePagato(rs.getDouble("totalePagato"));
					ordine.setRegalo(rs.getBoolean("regalo"));
					ordine.setMessaggioRegalo(rs.getString("messaggioRegalo"));
					ordine.setCreatoIl(rs.getTimestamp("creatoIl").toLocalDateTime());

				}
				do {
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

					ordine.aggiungiPrdotto(item);
				} while (rs.next());
			}
		}
		return ordine;
	}

	@Override
	public Collection<Ordine> doRetriveAll(String order) throws SQLException {
		Collection<Ordine> ordini = new LinkedList<>();
		String selectSQL = "SELECT * FROM " + TABLE_NAME;
		try (var conn = ds.getConnection()) {
			try (var stmt = conn.prepareStatement(selectSQL)) {
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
					ordini.add(bean);
				}
			}
		}
		return ordini;
	}

	@Override
	public void doSave(Ordine dao) throws SQLException {
		String insertOrder = "INSERT INTO ordine (uid,  totaleProdotti, totalePagato, regalo, messaggioRegalo, destinatarioRegalo) "
				+ "VALUES (?, ?, ?, ?, ?, ?)";
		String insertItem = "INSERT INTO prodottoOrdine "
				+ "(oid, nome, descrizione, breveDescrizione, prezzo, saldo, quantità, tasse) "
				+ "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
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
					stmt2.execute();
				}
			}
			conn.commit();
		} catch (SQLException e) {
			e.printStackTrace();
			conn.rollback();
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

	public Collection<Ordine> doRetrieveOrdersBetween(String sort, int userId, int from, int howMany,
			Timestamp fromDate, Timestamp ToDate) throws SQLException {
		String selectSQL = userId == 0
				? "SELECT * FROM  " + TABLE_NAME
						+ " WHERE uid LIKE ? AND creatoIl BETWEEN ? AND ? ORDER BY ? LIMIT ? OFFSET ?"
				: "SELECT * FROM  " + TABLE_NAME
						+ " WHERE uid = ?  AND creatoIl BETWEEN ? AND ? ORDER BY ? LIMIT ? OFFSET ?";

		Collection<Ordine> orders = new LinkedList<>();

		try (var conn = ds.getConnection()) {
			try (var stmt = conn.prepareStatement(selectSQL)) {
				if (userId == 0)
					stmt.setString(1, "%");
				else
					stmt.setInt(1, userId);
				stmt.setTimestamp(2, fromDate);
				stmt.setTimestamp(3, ToDate);
				stmt.setString(4, sort);
				stmt.setInt(5, howMany);
				stmt.setInt(6, from);
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

				}
			}
		}
		return orders;
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
				}
			}
		}
		return orders;
	}

	public Collection<Ordine> doRetriveByUser(Utente userBean) throws SQLException {
		Collection<Ordine> ordini = new LinkedList<Ordine>();
		String selectSQL = "SELECT * FROM " + TABLE_NAME + " WHERE uid=?";
		try (var conn = ds.getConnection()) {
			try (var stmt = conn.prepareStatement(selectSQL)) {
				stmt.setInt(1, userBean.getId());
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
					ordini.add(bean);
				}
			}
		}
		return ordini;
	}

	public Collection<ProdottoOrdine> findProductBuyByUser(Utente userBean) throws SQLException {
		Collection<ProdottoOrdine> prodotti = new LinkedList<ProdottoOrdine>();
		String selectSQL = "SELECT * FROM " + TABLE_NAME + " AS o, prodottoOrdine AS p "
				+ " WHERE uid=? AND p.oid=o.id";
		try (var conn = ds.getConnection()) {
			try (var stmt = conn.prepareStatement(selectSQL)) {
				stmt.setInt(1, userBean.getId());
				ResultSet rs = stmt.executeQuery();
				while (rs.next()) {
					ProdottoOrdine bean = new ProdottoOrdine();

					bean.setBreveDescrizione(rs.getString("breveDescrizione"));
					bean.setDescrizione(rs.getString("descrizione"));
					bean.setId(rs.getInt("id"));
					bean.setNome(rs.getString("nome"));
					bean.setOid(rs.getInt("oid"));
					bean.setPrezzo(rs.getDouble("prezzo"));
					bean.setQuantità(rs.getInt("quantità"));
					bean.setSaldo(rs.getDouble("saldo"));
					bean.setTasse(rs.getDouble("tasse"));
					prodotti.add(bean);
				}
			}
		}
		return prodotti;
	}

	public Collection<ProdottoOrdine> findBestSellingProducts() throws SQLException {
		Collection<ProdottoOrdine> prodotti = new LinkedList<ProdottoOrdine>();
		String selectSQL = "SELECT nome, COUNT(*) AS count FROM prodottoOrdine  GROUP BY nome ORDER BY count DESC";
		try (var conn = ds.getConnection()) {
			try (var stmt = conn.prepareStatement(selectSQL)) {
				ResultSet rs = stmt.executeQuery();
				while (rs.next()) {
					ProdottoOrdine bean = new ProdottoOrdine();
					bean.setNome(rs.getString("nome"));
					prodotti.add(bean);
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

	public Ordine doRetriveByLastUserOrder() throws SQLException {

		String selectSQL = "SELECT * FROM ordine AS o, prodottoOrdine AS p WHERE o.id=p.oid AND o.id=(SELECT max(id) FROM ordine)";
		Ordine ordine = new Ordine();
		try (var conn = ds.getConnection()) {
			try (var stmt = conn.prepareStatement(selectSQL)) {

				ResultSet rs = stmt.executeQuery();
				if (rs.next()) {
					ordine.setId(rs.getInt("id"));
					ordine.setTotaleProdotti(rs.getInt("totaleProdotti"));
					ordine.setTotalePagato(rs.getDouble("totalePagato"));
					ordine.setRegalo(rs.getBoolean("regalo"));
					ordine.setMessaggioRegalo(rs.getString("messaggioRegalo"));
					ordine.setCreatoIl(rs.getTimestamp("creatoIl").toLocalDateTime());
				}
				do {
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

					ordine.aggiungiPrdotto(item);
				} while (rs.next());
			}
		}
		return ordine;
	}
}
